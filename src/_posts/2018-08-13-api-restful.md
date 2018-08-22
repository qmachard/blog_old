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

![GIF: Détective regardant avec une loupe](https://media.giphy.com/media/JUh0yTz4h931K/giphy.gif)

## Les ressources

Une API sert avant tout à **executer des actions sur des ressources** métiers. Ils faut donc dans un premier temps **définir ces ressources**.

> Par exemple, si je veux créer une API permettant de gérer une bibliothèque musicale. Mes ressources seront donc : les albums, les artistes et les pistes.

Les ressources **se présentent sous la forme d'un objet JSON** et se découpent en plusieurs catégories : les **entités** et les **collections**.

### Entité 📕

Une entité est la **représentation la plus simple d'une ressource**. Elle permet simplement d'en afficher les détails.

> Voici un exemple de représentation de mon entité "album"
> ```json
> {
>    	"id": 7291,
>     "title": "The Groove Sessions",
>     "year": 2007,
>     "artwork": "/path/to/artwork.jpeg",
>     "artists": [
>         {
>             "id": 4523,
>             "name": "Chinese Man"
>         }
>     ]
> }
> ```

### Collections 📚

Une collection est **une liste d'entités**.

> Exemple de la liste de mes albums
> ```json
> {
> 	"items": [
>         {
>             "id": 7291,
>             "title": "The Groove Sessions"
>         },
>         {
>             "id": 7745,
>             "title": "Epoch"
>         },
>         ...
>     ],
>     "count": 10,
>     "limit": 10,
> 	"total": 26
> }
> ```

Comme on peut le voir dans l'exemple, l'avantage de retourner un objet et non directement une liste est la possibilité ajouter la pagination de notre liste ou des éléments associés à celle-ci.

### Erreurs ❌

Une erreur n'est pas vraiment une ressource réelle, mais elle a tout de même un schéma qui est intéressant à travailler.

> Voyons un exemple d'erreur
> ```json
> {
> 	"message": "Album not found",
>     "status": 404,
>     "type": "not_found"
> }
> ```

## Les URIs

> "Un **URI**, de l'anglais *Uniform Resource Identifier*, soit littéralement *identifiant uniforme de ressource*, est une courte chaîne de caractères identifiant une ressource sur un réseau."
>
> -- <cite>[URI, Wikipedia](https://fr.wikipedia.org/wiki/Uniform_Resource_Identifier)</cite>

### URI = Ressource

Il est important de garder une rêgle en tête : "**Chaque URI correspond à une ressource de notre système et non à une action**".

#### Collection

L'URI associée à une liste d'entités (une collection, donc) se présente sous la forme `/entities` (avec un *s* pour mettre en avant la pluralité des entités). 

> L'URI correspondante à ma collection d'albums sera donc `/albums`.

#### Entité

Pour requêter une entité il faut garder en tête cette phrase : "je requête une entité de ma collection", ainsi, l'URI tombe sous le sens et sera `/entities/{entity-id}` (on récupère un item de la collection, celle-ci garde donc son *s* pour rester cohérente).

> L'URI correspondante à un album sera `/albums/{album-id}`

#### Le cas des sous-ressources

Dans certains cas, une ressources est dépendante d'une autre, c'est ce que l'on appelle une **sous-ressource**.

L'URI correspondante à une collection de sous-ressources sera `/entities/{entity-id}/sub-resources` et pour récupérer une entité `/entities/{entity-id}/sub-resources/{sub-resource-id}`.

> Dans l'exemple, on peut se dire que les titres seront les enfants d'un album. On pourra donc avoir ces URI :
>
> * Collection de pistes d'un album : `/albums/{album-id}/tracks` 
> * Piste (d'une collection de pistes) d'un album : `/albums/{album-id}/tracks/{track-id}`

### Utilisation des paramètres de requête

Les paramètres de requête (appelés QueryParams) sont des **paramètres optionnels** qui s'ajoute à la fin de mon URL.

#### Rechercher

Comme Google, on peut utiliser un paramètre `q` pour **faire une recherche sur une collection**.

> Pour rechercher les albums on peut faire quelque-chose comme `/albums?q=Dyna-Mite`

#### Filtrer

Les paramètres permettent également de **filtrer les éléments d'une collection**. On utilisera généralement l'attribut de la ressource comme clé.

> Pour lister les albums d'une année spécifique on peut prévoir une URI comme `/albums?year=2007`

#### Pagination

On peut paginer simplement une collection comme on le ferait sur un site standard en ajoutant deux paramètres `page` permettant d'afficher une page et `limit` permettant de spécifier le nombre d'item par page.

> Pour pagination mes albums par pas de 10 et sélectionner la deuxième page, je ferais certainement quelque-chose comme `/albums?page=2&limit=10`

Il y a d'autres types de pagination, par exemple on peut paginer par gamme et prévoir un paramètre de type `range=0-10`, etc. Bref, on peut faire ce qu'on veut 🎉.

#### Tri

Afin de trier une collection, les query params sont la solution par excellence. Il suffit d'ajouter un parametre `sort` et le tour est jouer. 

*Tips: Afin de choisir dans quel ordre trier mes élements, j'ajoute un `-` quand il s'agit d'un ordre décroissant.*

> Pour trier les albums par années décroissante mon URI sera `/albums?sort=-year`.

#### Format

Une API doit pouvoir s'adapter aux besoins des clients (applications, services, etc.). On peut donc leur laisser la main sur les données qu'ils ont besoin et ainsi optimiser le poids des requêtes. On peut donc ajouter un paramètre `fields` pour **lister les champs à remonter** lors de l'appel.

> Si on veut lister les albums en affichant seulement leur titre, l'URI sera `/albums?fields=title`

## Les verbes HTTP

La plupart du temps, un API sert à afficher, créer, modifier et supprimer des entités de notre application, c'est ce qu'on appelle un **CRUD**.

> "L'acronyme informatique anglais **CRUD** (pour *create*, *read*, *update*, *delete*) [...] désigne les quatre opérations de base pour la persistance des données."
>
> -- <cite>[CRUD, Wikipedia](https://fr.wikipedia.org/wiki/CRUD)</cite>

### CRUD

Pour ce faire, nous allons utiliser [**les verbes que met HTTP à notre disposition**](https://developer.mozilla.org/fr/docs/Web/HTTP/M%C3%A9thode), c'est à dire **GET**, **POST**, **PATCH**, **PUT** et **DELETE**.

![](https://media.giphy.com/media/dUMyRVhUMmD1m/giphy.gif)

Voici un petit tableau permettant de comprendre le rôle de chaque verbe lorsqu'il est executé sur une entité ou une collection.

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

#### Idempotence

L'idempotence est le fait que lorsque qu'une requête est appelée plusieurs fois, le résultat obtenu de varie pas.

Les verbes `GET`, `PUT`, `PATCH`, `DELETE` sont idempotents. Seul `POST` ne l'est pas car il créé une entité à chaque appel.

Cf. [Idempotent REST APIs](https://restfulapi.net/idempotent-rest-apis/)

####*PATCH* ton *POST*

Ces deux verbes HTTP permette d'ajouter un corps (*content*) à notre requête. Ce corps sera également un object JSON qui représente l'objet.

> Si nous voulons créer un nouvel album nous executerons cette requête :
>
> ```
> # POST /albums
> + Request (application/json)
> {
>    "title": "Lunar Lane",
>    "year": "2015"
> }
> 
> + Response 201 (application/json)
> {
>     "id": 274,
>    "title": "Lunar Lane",
>    "year": "2015"
> }
> ```
>
> Et pour modifier cet album
> ```
> # PATCH /albums/274
> + Request (application/json)
> {
>    "title": "Lunar Lane (Deluxe)",
>    "year": "2015"
> }
> 
> + Response 200 (application/json)
> {
>     "id": 274,
>     "title": "Lunar Lane (Deluxe)",
>     "year": "2015"
> }
> ```

### Le cas des ressources liées

Afin de lier deux ressources entre elles sans définir pour autant de lien de parenté j'utilise le verbe `PUT`.

> Les artistes possèdent plusieurs albums, on va donc lier un artiste à un album (ce choix est arbitraire) :
>
> * `GET /artists/{artist}/albums` : Liste les albums liés à un artiste
> * `PUT /artists/{artist}/albums/{album}` : Lie l'album à l'artiste
> * `DELETE /artists/{artist}/albums/{album}` : Supprime la liaison entre l'album et l'artiste

### Actions particulières

Bien sûr, **certaines actions ne se résument pas aux simple CRUD**. Dans ce cas, il est nécessaire de faire une **URI particulière en y ajoutant un verbe**.

![WHAT?!?](https://media.giphy.com/media/SqmkZ5IdwzTP2/giphy.gif)

Oui, au début de mon article je vous ai dit "pas de verbes", mais ces actions sont l'exception qui confirme la règle. 

Bien sûr, il faut avant tout essayer de faire rentrer cette action dans un des verbes HTTP. Cette nouvelle URL sera **forcément appelée en POST**.

> Par exemple, si je veux lire une piste d'un album, je n'ai pas de verbe HTTP qui correspondrait... Je vais donc **exceptionnellement** créer cette action :
>
>  ```
> POST /albums/{album-id}/tracks/{track-id}/play
>  ```

## Les "status code"

![](C:\Users\qmachard\Perso\blog\src\img\posts\rest\error.png)

Comme le montre très bien cette vignette de [CommitStrip.com](https://www.commitstrip.com/fr/2016/03/03/its-not-working/), il n'y a rien de pire lorsque l'on requête une API que de ne pas comprendre quelle est l'erreur.

Et encore une fois, HTTP a fait les 3/4 du boulot en **ajoutant des status code à ses retours de requêtes**. Il serait donc dommage de s'en priver.

> Un des *status code* le plus connu est 404, que l'on croise régulièrement, mais qu'en est-til des [autres](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) ?

L'idée n'est pas de vous lister un à un l'intégralité des *status codes*, mais de vous montrer les plus utilisés et les plus subtiles.

Ceux-ci ce découpent en 4 catégories : **1xx**, **2xx**, **3xx**, **4xx** et **5xx**. *On ne va pas parler des erreurs de type 1xx, qui n'ont pas grand intérêt pour ma part.*

### 2xx : *Tout va bien*

|      |      |      |
| ---- | ---- | ---- |
|      |      |      |

### 3xx : *Regarde ailleurs*

|      |      |      |
| ---- | ---- | ---- |
|      |      |      |

### 4xx : *Tu t'es planté*

|      |      |      |
| ---- | ---- | ---- |
|      |      |      |

### 5xx : *Je me suis planté*

|      |      |      |
| ---- | ---- | ---- |
|      |      |      |

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
- [API REST CheatSheet](https://blog.octo.com/wp-content/uploads/2014/10/RESTful-API-design-OCTO-Quick-Reference-Card-2.2.pdf) (PDF, en anglais)

N'hésitez pas à **partager cet article** et envoyer **vos questions ou vos ressources en commentaires** ! 

![GIF: Good Bye](https://media.giphy.com/media/3o6EhGvKschtbrRjX2/giphy.gif)

À bientôt ! Q.