---
layout: post
title:  "Concevoir une API RESTful"
excerpt: "-- todo --"
background: '/img/posts/covers/bem.jpg'
comments: true
tags: api rest back
image: '/img/posts/covers/bem.jpg'
---

# Designer une API RESTful

Pour communiquer entre elles, les applications ont besoin d'un support **basé généralement sur HTTP**. C'est une qu'on appelle **une API** ou **un webservice**.

C'est en 2000 que Roy Fielding créé le **standard REST** afin de **normaliser de manière simple ces APIs** et d'utiliser au maximum le standard HTTP. Cette norme est basée sur 4 niveaux souvent appelés "[Glory of REST](https://martinfowler.com/articles/richardsonMaturityModel.html)".

Voyons comment cela se présente.

## Les ressources

==TODO==

* Introduction sur les ressources
* Introduction sur JSON

### Entité

==TODO==

- Détail d'une entité

### Collections

==TODO==

* Liste d'entité
* Pagination

## Les URIs

### URI = Ressource

La norme REST est, avant tout, **basé sur les ressources**. C'est à dire que **chaque URI correspond à une ressource de notre système** et non à une action. Il faut donc definir les ressources de son projet.

Il y a deux types de resources : les **entités** et les **collections d'entités**.

>  Par exemple, si je veux créer une API permettant de gérer une bibliothèque musicale. Mes ressources seront donc : les albums, les artistes et les pistes.

Pour récupérer une liste d'entités, nous allons donc créer une URI du genre `/resources`. Ensuite, pour récupérer une entité de cette collection la traduction en URI sera `/resources/{idResource}`.

> L'URI correspondante à ma collection d'albums sera `/albums`. Et pour en récupérer un en particulier `/albums/{album}`

### Le cas des sous-ressources

Dans certains cas, une ressources est dépendante d'une autre, c'est ce que l'on appelle une **sous-ressource**.

L'URI correspondante à une collection de sous-ressources sera `/resources/{idResource}/sub-resources` et pour récupérer une entité `/ressources/{idResource}/sous-ressources/{idSubResource}`.

> Dans l'exemple, on peut se dire que les titres seront des enfants d'un album. Pour les lister nous aurons donc `/albums/{album}/tracks` et pour récupérer un titre `/albums/{album}/tracks/{track}`.

### Utilisation des paramètres de requête

==TODO==

* Recherche
* Filtrage
* Pagination
* Tri
* Format

### Actions particulières

==TODO==

## Les verbes HTTP

La plupart du temps, un API sert à afficher, créer, modifier et supprimer des entités de notre application, c'est ce qu'on appelle un CRUD.

### CRUD

Pour ce faire, nous allons utiliser [**les verbes que met HTTP à notre disposition**](https://developer.mozilla.org/fr/docs/Web/HTTP/M%C3%A9thode).

| Verbe  | Collection        | Entité                         |
| ------ | ----------------- | ------------------------------ |
| GET    | Liste les entités | Affiche le détail d'une entité |
| POST   | Créer une entité  | -                              |
| PATCH  | -                 | Modifie l'entité               |
| DELETE | -                 | Supprime l'entité              |

> Reprenons notre collection musicale. Voici la liste des actions disponibles pour notre ressource "Albums" :
>
> * `GET /albums` : Récupère la liste des albums
> * `POST /albums` : Ajoute un album à notre collection
> * `GET /albums/{album}` : Affiche le détail de l'album
> * `PATCH /albums/{album}` : Modifie l'album
> * `DELETE /albums/{album}` : Supprime l'album

### Le cas des ressources liées

Afin de lier deux ressources entre elles sans définir pour autant de lien de parenté on peut utiliser le verbe `PUT`.

> Les artistes possèdent plusieurs albums, on va donc lier un artiste à un album :
>
> * `GET /artists/{artist}/albums` : Liste les albums liés à un artiste
> * `PUT /artists/{artist}/albums/{album}` : Lie l'album à l'artiste
> * `DELETE /artists/{artist}/albums/{album}` : Supprime la liaison entre l'album et l'artiste

## Les "status code"

==TODO==

## Glory of REST

### HATEOAS

==TODO==

### JSONLD

==TODO==

* Définir les types de données

### JSON Schema

==TODO==

* Définition des ressources

## Pour aller plus loin

Comme toujours, je vous mets quelques liens que je trouve intéressants à ce sujet :

- [HATEOAS, le Graal des développeurs d'API](http://putaindecode.io/fr/articles/api/hateoas/) (en français)

N'hésitez pas à **partager cet article** et envoyer **vos questions ou vos ressources en commentaires** ! 

![GIF: Good Bye](https://media.giphy.com/media/3o6EhGvKschtbrRjX2/giphy.gif)

À bientôt ! Q.