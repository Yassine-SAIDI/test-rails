# Test technique pour Rails - Module de modération

## Objectif

Le but de ce test est d'écrire un module Rails nommé "Moderable" qui permet de modérer automatiquement les attributs d'un modèle Ruby on Rails en utilisant une API de modération.

## Fonctionnalités

- Le module Moderable peut être inclus dans d'autres classes Rails.
- Lorsque les colonnes à modérer sont modifiées, le module appelle une API de modération pour voir si le contenu est rejeté ou accepté.
- Le résultat de la modération est stocké sous forme de booléen dans une colonne "is_accepted" de la classe modérée.

## Utilisation

Pour utiliser le module Moderable, incluez-le dans la classe concernée et définissez les colonnes à modérer.

## Tests

Des tests unitaires sont fournis pour tester le bon fonctionnement du module Moderable. Pour exécuter les tests, utilisez la commande suivante :
rails test

 
 
