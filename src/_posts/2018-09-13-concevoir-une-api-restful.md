---
layout: post
title:  "Concevoir une API REST"
excerpt: "Techniques de base pour designer une API, en utilisant le standard REST"
background: '/img/posts/covers/clouds.jpg'
comments: true
tags: API rest back
image: '/img/posts/covers/clouds.jpg'
---

# Concevoir une API REST

Pour communiquer entre elles, les applications ont besoin d'un support **basé généralement sur HTTP**. C'est une qu'on appelle **une API** ou **un webservice**.

C'est en 2000 que Roy Fielding crée le **standard REST** afin de **normaliser de manière simple ces API** et d'utiliser au maximum le standard HTTP. Cette norme est basée sur 4 niveaux souvent appelés "[Glory of REST](https://martinfowler.com/articles/richardsonMaturityModel.html)".

Voyons comment cela se présente.

![GIF: Détective regardant avec une loupe](https://media.giphy.com/media/JUh0yTz4h931K/giphy.gif)

## Les ressources

Une API sert avant tout à **exécuter des actions sur des ressources** métiers. Il faut donc dans un premier temps **définir ces ressources**.

> Par exemple, si je veux créer une API permettant de gérer une bibliothèque musicale. Mes ressources seront donc : les albums, les artistes et les pistes.

Les ressources **se présentent sous la forme d'un objet JSON** et se découpent en plusieurs catégories : les **entités** et les **collections**.

### Entité 📕

Une entité est la **représentation la plus simple d'une ressource**. Elle permet simplement d'en afficher les détails.

> Voici un exemple de représentation de mon entité "album"
> ```json
> {
>   "id": 7291,
>   "title": "The Groove Sessions",
>   "year": 2007,
>   "artwork": "/path/to/artwork.jpeg",
>   "artists": [
>     {
>       "id": 4523,
>       "name": "Chinese Man"
>     }
>   ]
> }
> ```

### Collections 📚

Une collection est **une liste d'entités**.

> Exemple de la liste de mes albums
> ```json
> {
>   "items": [
>     {
>       "id": 7291,
>       "title": "The Groove Sessions"
>     },
>     {
>       "id": 7745,
>       "title": "Epoch"
>     },
>     ...
>   ],
>   "count": 10,
>   "limit": 10,
>   "total": 26
> }
> ```

Comme on peut le voir dans l'exemple, l'avantage de retourner un objet et non directement une liste est la possibilité d’ajouter la pagination de notre liste ou des éléments associés à celle-ci.

### Erreurs ❌

Une erreur n'est pas vraiment une ressource réelle, mais elle a tout de même un schéma qui est intéressant à travailler.

![- Developpeur : "Mais putain", - API: "Unknown error. Please try again"](/img/posts/rest/error.png)

Comme le montre cette vignette de [CommitStrip.com](http://www.commitstrip.com/fr/2013/07/01/quand-lapi-rend-fou/), il est toujours frustrant pour un développeur de ne pas comprendre l'erreur renvoyée par le webservice. Il est donc nécessaire de renvoyer une erreur correctement formatée.

> Voyons un exemple d'erreur
> ```json
> {
>   "message": "Album not found",
>   "status": 404,
>   "type": "not_found"
> }
> ```

## Les URI

> "Un **URI**, de l'anglais *Uniform Resource Identifier*, soit littéralement *identifiant uniforme de ressource*, est une courte chaîne de caractères identifiant une ressource sur un réseau."
> -- <cite>[URI, Wikipedia](https://fr.wikipedia.org/wiki/Uniform_Resource_Identifier)</cite>

### URI = Ressource

Il est important de garder une règle en tête : "**Chaque URI correspond à une ressource de notre système et non à une action**".

#### Collection

L'URI associé à une liste d'entités (une collection, donc) se présente sous la forme `/entities` (avec un *s* pour mettre en avant la pluralité des entités). 

> L'URI correspondant à ma collection d'albums sera donc `/albums`.

#### Entité

Pour requêter une entité il faut garder en tête cette phrase : "je requête une entité de ma collection", ainsi, l'URI tombe sous le sens et sera `/entities/{entity-id}` (on récupère un item de la collection, celle-ci garde donc son *s* pour rester cohérente).

> L'URI correspondant à un album sera `/albums/{album-id}`

#### Le cas des sous-ressources

Dans certains cas, une ressource est dépendante d'une autre, c'est ce que l'on appelle une **sous-ressource**.

L'URI correspondante à une collection de sous-ressources sera `/entities/{entity-id}/sub-resources` et pour récupérer une entité `/entities/{entity-id}/sub-resources/{sub-resource-id}`.

> Dans l'exemple, on peut se dire que les titres seront les enfants d'un album. On pourra donc avoir ces URI :
>
> * Collection de pistes d'un album : `/albums/{album-id}/tracks` 
> * Piste (d'une collection de pistes) d'un album : `/albums/{album-id}/tracks/{track-id}`

### Utilisation des paramètres de requête

Les paramètres de requête (appelés QueryParams) sont des **paramètres optionnels** qui s'ajoutent à la fin de mon URL.

#### Rechercher

Comme Google, on peut utiliser un paramètre `q` pour **faire une recherche sur une collection**.

> Pour rechercher les albums on peut faire quelque chose comme `/albums?q=Dyna-Mite`

#### Filtrer

Les paramètres permettent également de **filtrer les éléments d'une collection**. On utilisera généralement l'attribut de la ressource comme clé.

> Pour lister les albums d'une année spécifique on peut prévoir un URI comme `/albums?year=2007`

#### Pagination

On peut paginer simplement une collection comme on le ferait sur un site standard en ajoutant deux paramètres `page` permettant d'afficher une page et `limit` permettant de spécifier le nombre d'items par page.

> Pour paginer mes albums par pas de 10 et sélectionner la deuxième page, je ferais certainement quelque chose comme `/albums?page=2&limit=10`

Il y a d'autres types de pagination, par exemple on peut paginer par gamme et prévoir un paramètre de type `range=0-10`, etc. 

En bref, on peut faire ce que l'on veut 🎉.

#### Tri

Afin de trier une collection, les query params sont la solution par excellence. Il suffit d'ajouter un paramètre `sort` et le tour est jouer. 

*Tips: Afin de choisir dans quel ordre trier mes éléments, j'ajoute un `-` quand il s'agit d'un ordre décroissant.*

> Pour trier les albums par années décroissantes mon URI sera `/albums?sort=-year`.

#### Format

Une API doit pouvoir s'adapter aux besoins des clients (applications, services, etc.). On peut donc leur laisser la main sur les données dont ils ont besoin et ainsi optimiser le poids des requêtes. Ainsi, on ajoute un paramètre `fields` pour **lister les champs à remonter** lors de l'appel.

> Si on veut lister les albums en affichant seulement leur titre, l'URI sera `/albums?fields=title`

## Les verbes HTTP

La plupart du temps, un API sert à afficher, créer, modifier et supprimer des entités de notre application, c'est ce qu'on appelle un **CRUD**.

> "L'acronyme informatique anglais **CRUD** (pour *create*, *read*, *update*, *delete*) [...] désigne les quatre opérations de base pour la persistance des données."<br>
> -- <cite>[CRUD, Wikipedia](https://fr.wikipedia.org/wiki/CRUD)</cite>

### CRUD

Pour ce faire, nous allons utiliser [**les verbes que met HTTP à notre disposition**](https://developer.mozilla.org/fr/docs/Web/HTTP/M%C3%A9thode), c'est-à-dire **GET**, **POST**, **PATCH**, **PUT** et **DELETE**.

![](https://media.giphy.com/media/dUMyRVhUMmD1m/giphy.gif)

Voici un petit tableau permettant de comprendre le rôle de chaque verbe lorsqu'il est exécuté sur une entité ou une collection.

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

L'idempotence est le fait que lorsqu'une requête est appelée plusieurs fois, le résultat obtenu ne varie pas.

Les verbes `GET`, `PUT`, `PATCH`, `DELETE` sont idempotents. Seul `POST` ne l'est pas, car il crée une entité à chaque appel.

cf. [Idempotent REST API](https://restfulapi.net/idempotent-rest-apis/)

#### *PATCH* ton *POST*

Ces deux verbes HTTP permettent d'ajouter un corps (*content*) à notre requête. Ce corps sera également un object JSON et représentera les attributs d'entrée de l'objet (ceux utiles à sa création).

> Si nous voulons créer un nouvel album, nous exécuterons cette requête :
>
> ```markdown
> # POST /albums
> + Request (application/json)
> {
>     "title": "Lunar Lane",
>     "year": "2015"
> }
> 
> + Response 201 (application/json)
> {
>     "id": 274,
>     "title": "Lunar Lane",
>     "year": "2015"
> }
> ```
>
> Et pour modifier cet album
> ```markdown
> # PATCH /albums/274
> + Request (application/json)
> {
>     "title": "Lunar Lane (Deluxe)",
>     "year": "2015"
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
> * `DELETE /artists/{artist}/albums/{album}` : Supprime uniquement la liaison entre l'album et l'artiste

### Actions particulières

Bien sûr **certaines actions ne se résument pas aux simples CRUD**. Dans ce cas, il est nécessaire de faire un **URI particulier en y ajoutant un verbe**.

![WHAT?!?](https://media.giphy.com/media/SqmkZ5IdwzTP2/giphy.gif)

Oui, au début de mon article je vous ai dit "pas de verbes", mais ces actions sont **l'exception qui confirme la règle**. 

Bien sûr, il faut avant tout essayer de faire rentrer cette action dans un des verbes HTTP. Cette nouvelle URL sera **forcément appelée en POST**.

> Par exemple, si je veux lire une piste d'un album, je n'ai pas de verbe HTTP qui correspondrait... Je vais donc **exceptionnellement** créer cette action :
>
>  ```
> POST /albums/{album-id}/tracks/{track-id}/play
>  ```

## Les "status code"

![](https://www.commitstrip.com/wp-content/uploads/2018/08/Strip-Response-code-650-final.jpg)

Comme le montre très bien cette planche de l'excellent [CommitStrip.com](http://www.commitstrip.com/fr/2018/08/24/http-headers-ftw/), en plus de retourner un [format d'erreur](#erreurs-) correct il est important d'**utiliser les status codes correspondants**.

> Un des *status code* le plus connu est 404, que l'on croise régulièrement, mais qu'en est-il des [autres](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) ?

L'idée n'est pas de vous lister un à un l'intégralité des *status codes*, mais de vous montrer les plus utilisés et les plus subtiles.

Ceux-ci ce découpent en 4 catégories : **1xx**, **2xx**, **3xx**, **4xx** et **5xx**. *On ne va pas parler des erreurs de type 1xx, qui n'ont pas grand intérêt pour ma part.* 

Allez, pour rendre le tout plus fun, ces codes seront illustrés par [des chats](https://http.cat/) (c'est cadeau 🎁).

### 2xx : *Tout va bien*

![200 - OK](https://http.cat/204)

Les statuts 2xx sont retournés par le serveur quand **tout s'est bien passé**.

| Code | Erreur            | Cas d'usage                                                  |
| ---- | ----------------- | ------------------------------------------------------------ |
| 200  | *OK*              | Il est utilisé pour **tous les retours d'une API qui se passe bien** et qui ne rentre pas dans les cas suivants. |
| 201  | *Created*         | Il est utilisé lors d'**un retour positif de création** (POST) ou de liaison (PUT) d'une ressource. |
| 204  | *No Content*      | Il est utilisé à la suite d'**une réussite de suppression** (DELETE). *Le corps de la réponse doit être vide.* |
| 206  | *Partial Content* | Il est utilisé lorsque la collection retournée n'est pas complète. *Si la collection contient 2 pages, la première appelée retournera un statut 206 et la deuxième un statut 200.* |

### 3xx : *Regarde ailleurs*

![301 - Move Permanently](https://http.cat/301)

Les status 3xx sont retournées lorsque la ressource est à retrouver ailleurs (dans une autre URL, dans le cache, etc.).

| Code | Erreur              | Cas d'usage                                                  |
| ---- | ------------------- | ------------------------------------------------------------ |
| 301  | *Moved Permanently* | Il est utilisé lorsque **la ressource a été déplacée**. Il est accompagné d'un header `Location: {URL de la ressource}` |
| 304  | *Not Modified*      | Il est utilisé pour dire au client que **la ressource n'a pas été modifiée depuis son dernier appel**. *La ressource ne sera pas renvoyée, le client prendra donc par défaut l'entité en cache.* |

### 4xx : *Tu t'es planté*

![404 - Not Found](https://http.cat/404)

Les statuts 4xx sont renvoyés lorsque le client de l'API a fait une erreur ou ne peut pas accéder à la ressource. 

Ces erreurs seront **toujours accompagnées d'un objet "erreur"** (vu précédemment).

| Code | Erreur         | Cas d'usage                                                  |
| ---- | -------------- | ------------------------------------------------------------ |
| 400  | *Bad Request*  | Il est utilisé lorsque le contenu de **la requête ne correspond pas à ce qui est demandé**. *Lors de la création d'une entité, si un champ est mal renseigné par exemple.* |
| 401  | *Unauthorized* | Il est utilisé lorsque **le client n'a pas accès à la ressource**, car il doit spécifier un toque ou une clé d'API. |
| 403  | *Forbidden*    | Il est utilisé lorsque **le client n'a pas accès à la ressource**. La subtile différence avec la 401 réside dans le fait que même si le client renseigne un toque ou une clé d'API valide, la ressource lui sera toujours refusée. |
| 404  | *Not Found*    | Dois-je réellement vous l'expliquer ? Il est utilisé lorsqu'**une ressource est introuvable**. |
| 409  | *Conflict*     | Il est, par exemple, utilisé lorsque deux ressources sont déjà liées entre-elles suite à un PUT. |

### 5xx : *Je me suis planté*

![500 - Internal Server Error](https://http.cat/500)

Les status 5xx sont retournées lorsque le serveur a un problème.

Ces erreurs seront **toujours accompagnées d'un objet "erreur"** (vu précédemment).

| Code | Erreur                | Cas d'usage                                                  |
| ---- | ------------------------ | -------------------------------------------- |
| 500  | *Internal Server Error* | Lorsque le script ne se déroule pas correctement, mais que le client n'y est pour rien. |

## Exemple

Comme je vous trouve sympas, je vous donne la documentation complète de l'API d'exemple : [Music API](https://musicapi7.docs.apiary.io/#). 

Pour cette documentation, j'ai utilisé [API BluePrint](https://apiblueprint.org/), un langage basé sur Markdown, mais axé Rest (je vous ferais un petit article à ce sujet, c'est promis 😉).

![You're Welcome](https://media.giphy.com/media/3o85xwxr06YNoFdSbm/giphy.gif)

## Glory of REST

Certains formats de ressources permettent d'aller plus loin et d'améliorer l'expérience développeur lors des appels API. Je ne vais pas m'attarder sur ces formats, mon but est simplement de vous faire une petite introduction et vous donner envie d'aller plus loin.

### HATEOAS

HATEOAS, *Hypermedia As The Engine Of Application State*, permet de formaliser les ressources de la même manière qu'on le ferait en HTML : **en créant des liens entres-elles**. Cela permet de **naviguer dans l'API sans connaître sa documentation**, mais uniquement son point d'entrée.

> Reprenons mon exemple. Voici ce que donnerait un résultat d'album en HATEOAS :
>
> ```json
> {
>     "id": "628",
>     "title": "The Groove Sessions",
>     "artists": [
>         {
>             "id": 4,
>             "name": "Chinese Man",
>             "links": [
>                 {
>                     "rel": "self",
>                     "href": "/artists/4"
>                 }
>             ]
>         }
>   	],
>     "year": "2007",
>     "created_at": "1535021696",
>     "links": [
>         {
>             "rel": "list",
>             "href": "/albums",
>         },
>         {
>             "rel": "self",
>             "href": "/albums/628"
>         },
>         {
>             "rel": "tracks",
>             "href": "/albums/628/tracks"
>         }
>     ]
> }
> ```

### JSON Schema

Le but ici est de **documenter notre API** en utilisant un schéma. C'est très utile pour tester que le retour d'une API est conforme à sa documentation, mais aussi pour créer les modèles dans notre langage de programmation préféré.

> Dans mon exemple d'API, un album se présente comme ceci :
>
> ```json
> {
>   "$schema": "http://json-schema.org/draft-04/schema#",
>   "type": "object",
>   "properties": {
>     "id": {
>       "type": "string"
>     },
>     "title": {
>       "type": "string"
>     },
>     "artists": {
>       "type": "array"
>     },
>     "year": {
>       "type": "string"
>     },
>     "created_at": {
>       "type": "string"
>     }
>   }
> }
> ```

### JSONLD

À la manière du JSON Schéma, le but est de décrire nos ressources, mais cette fois-ci dans des **schémas standardisés**.

> Prenons l'exemple de la documentation. Si la ressource est une personne, je ne vais pas réinventer les informations d'une personne, donc je peux directement utiliser un schéma standard de Personne : [https://json-ld.org/contexts/person.jsonld](https://json-ld.org/contexts/person.jsonld).
>
> ```json
> {
>   "@context": "https://json-ld.org/contexts/person.jsonld",
>   "@id": "http://dbpedia.org/resource/John_Lennon",
>   "name": "John Lennon",
>   "born": "1940-10-09",
>   "spouse": "http://dbpedia.org/resource/Cynthia_Lennon"
> }
> ```

## Pour aller plus loin

Et voilà, vous voyez ce n'est pas très complexe ! 

![GIF: ... That was easy !](https://media.giphy.com/media/zcCGBRQshGdt6/giphy.gif)

Maintenant, si vous êtes dev back, vous n'aurez plus aucune excuse pour oublier un status code. Et si vous êtes dev front, partagez cet article à votre dev back !

Comme toujours, je vous mets quelques liens que je trouve intéressants à ce sujet :

- [A RESTful Tutorial](https://www.restapitutorial.com/) (en anglais)
- [Quick Card Reference](https://blog.octo.com/wp-content/uploads/2014/12/OCTO-Refcard_API_Design_EN_3.0.pdf) (PDF, en anglais)
- [HATEOAS, le Graal des développeurs d'API](http://putaindecode.io/fr/articles/api/hateoas/) (en français)
- [Exemple d'API](https://musicapi7.docs.apiary.io) (en anglais)

N'hésitez pas à **partager cet article** et envoyer **vos questions ou vos ressources en commentaires** ! 

![GIF: See You Soon!](https://media.giphy.com/media/l1J3CbFgn5o7DGRuE/giphy.gif)

À bientôt ! Q.