
module Moderable
  extend ActiveSupport::Concern

  included do
    # Avant d'enregistrer l'objet, vérifie le contenu pour la haine ou l'illégalité
    before_save :check_for_hateful_content
  end

  private

  def check_for_hateful_content
    # Construit l'URL pour l'API de modération
    url = "https://moderation.logora.fr/predict?text=#{CGI.escape(self.content)}&language=fr-FR"
    # Effectue une requête GET à l'API, attend une réponse au format JSON
    response = HTTParty.get(url, headers: { 'Accept' => 'application/json' })

    # Si la réponse n'est pas un succès, ajoute une erreur à l'objet et interrompt la sauvegarde
    unless response.ok?
      errors.add(:base, "Problème de connexion avec l'API de modération.")
      throw :abort
    end

    # Analyse la réponse JSON de l'API pour déterminer si le contenu est accepté
    result = JSON.parse(response.body)
    # La logique fictive ci-dessous suppose que la prédiction est acceptée si la probabilité est inférieure à 0.5
    self.is_accepted = result["prediction"]["0"] < 0.5
  rescue JSON::ParserError
    # En cas d'erreur d'analyse JSON, ajoute une erreur et annule la sauvegarde
    errors.add(:base, "Réponse inattendue de l'API de modération.")
    throw :abort
  end
end
