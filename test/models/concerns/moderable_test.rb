require 'test_helper'
require 'webmock/minitest'

class ModerableTest < ActiveSupport::TestCase
  include WebMock::API
  
  test "moderation check rejects hateful content" do
    # Stub de la requête HTTP pour simuler une réponse de l'API
    stub_request(:get, /moderation.logora.fr/).
      to_return(status: 200, body: '{"prediction":{"0":0.9}}')

    # Créez un nouveau post avec un contenu qui devrait être rejeté
    post = Post.new(content: "hateful content")

    # Appel explicite de la méthode de vérification du contenu haineux
    post.send(:check_for_hateful_content)

    # Vérifiez que le post n'a pas été accepté
    assert_not post.is_accepted, "Post should not be accepted due to hateful content"
  end
end
