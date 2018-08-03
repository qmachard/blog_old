---
layout: post
title:  "Introduction à BEM"
excerpt: "BEM, Block Element Modifier, définition, et cas d'utilisation."
background: '/img/posts/2018-04-12-hello-world.jpg'
comments: true
tags: html css bem
---

# Introduction à BEM

Cet article s'adresse dans un premier temps aux intégrateurs web. Il permet de définir une nommenclature des classes pour le CSS. Car, comme toujours, le plus dur est de nommer les choses. Voyons donc une approche différente de l'intégration avec BEM.

## BEM, Késako ?

Créée par [@iamstarkov](https://twitter.com/iamstarkov) et [@flatdrop](https://github.com/floatdrop), BEM, *Block Element Modifier*, est une convention de nommage qui s'applique sur le principe des **éléments réutilisables**.

BEM se base donc **uniquement sur des classes CSS** et est donc complètement **décorrélé de la sémantique** HTML ce qui est un **point positif pour l'accessibilité**.

La règle d'or à retenir est donc :

> **Tout élément devant être stylisé doit avoir une classe.**

 Comme toute convention, elle a ses avantages et ses limites, voyons donc ces points en détails.

### Avantages

#### Performance

La nommenclature de BEM permet d'avoir **la plupart des classes CSS au premier niveau**. On évite ainsi la cascade CSS qui est plus longue à être interprétée par le navigateur. Et oui, `.foo > .bar` est plus long que `.foo_bar`.

![Homme montrant sa montre pour dire que le temps presse.](https://media.giphy.com/media/26n6xBpxNXExDfuKc/giphy.gif)

#### Maintenabilité et propreté

**Chaque composant est indépendant** et peut facilement être modifié et retrouvé. Il peut également être surclassé sans utiliser `!important`.

![GIF: Applaudissements d'un homme content](https://media.giphy.com/media/pEBTYXKRdu7M4/giphy.gif)

Cela permet donc d'éviter ce genre de code CSS :

```css
h2 {
  color: red;
}
.my-aside-title {
  font-size: 1.5em; /* Je style mon titre, OK c'est propre */
  color: blue;
}
.my-aside h2.my-aside-title {
  color: red; /* Ah merde, annulation d'une règle sur h2 prévue pour autre chose */
}
```

Aussi, il permet de **fractionner son code** et **faciliter l'utilisation des pré-processeurs CSS** (tels que SASS ou SCSS). Chaque bloc pourra avoir sa feuille de style SCSS associée.

Cette nommenclature sera également **parfaite pour une intégration en mode "Atomic"** (Wait! Je garde ça pour un autre article... *Teaser!*). Mais aussi en React et Angular, par exemple, où la logique est de **faire des composants réutilisables**.

#### Structuration

Comme on a pu le voir plus haut, chaque block / élément **ne dépendra pas de son tag HTML**. On peut donc facilement optimiser le SEO et l'accessibilité.

*Si vous ne l'avez pas encore lu, je vous renvois sur mon [article d'introduction à l'accessibilité]({% post_url 2018-07-03-rendre-son-site-accessible %}).*

### Inconvénients

Alors après tous ces avantages, qu'est-ce qu'on peut bien lui trouvé de mauvais ?

#### Verbeux

![GIF: Gna gna gna](https://media.giphy.com/media/3oriNXSR3p6iPY7GrC/giphy.gif)

Et oui, vous vous en doutiez un peu. Pour que ça fonctionne, la nommenclature de BEM est **un petit peu verbeuse**. Les noms des classes sont long, mais plus tard, nous allons voir comment je l'implémente dans mes projets et finalement, *c'est pas si moche !* Aussi, pour des éléments ayant beaucoup de variantes, la liste des classes peut rapidement s'allonger, notamment pour les boutons ou les liens.

## Vous avez dit BEM ?

Maintenant que l'on a fait la liste des avantages et inconvénients d'une telle solution, voyons de plus près comment elle s'utilise !

![GIF: Détective regardant avec une loupe](https://media.giphy.com/media/JUh0yTz4h931K/giphy.gif)

### Définition de BEM

![Schéma montrant le découpage de BEM](http://getbem.com/assets/github_captions.jpg)

#### B comme Block

Un *block* est **l'élément parent de notre composant**, le but est de tout encapsuler dans celui-ci, dans la limite du possible bien évidemment. Sa classe se nomme de la manière suivante : `block-name`, facile non ?

*Dans l'exemple ci-dessus, "menu" est un bloc. Sa classe sera : `menu`, c'est simple !

> La notation officielle de BEM est `BlockName`. Mais, par habitude, j'ai du mal à utiliser du CamelCase dans CSS et préfère utiliser des tirets.

#### E comme Element

Un *element* est **ce qui compose le bloc**. Je le rappelle *"tout ce qui a besoin d'être stylisé doit avoir une classe"*, nous allons donc "classer" les éléments, pour ce faire la notation sera la suivante : `block-name_element-name`.

*Dans l'exemple ci-dessus, "menu elements" seront des élements. Leur classe sera certainement : `.menu_element`*.

L'avantage de BEM est qu'on aura pas de sélecteur du style `.block-name > .element-name`. Ainsi, pour surclasser cet élément il n'y aura pas besoin de refaire toute la chaîne, ni d'ajouter un !important d'ailleurs.

> La notation officielle de BEM est `BlockName__ElementName`. Je trouve que le double underscore est un peu lourd. Je n'ai pas vu de cas où le simple underscore me génait.

#### Et le M ? M pour Modifier

Un *modifier* est **une variante du block** (un état, un mode, etc.).  La syntaxe sera la suivante `block-name_element-name--modifier`.

*Dans l'exemple ci-dessus, le bloc `button` est dans certains cas vert. On créera donc un modifier `button--green` qui permettra d'afficher le bouton en vert*.

> La notation officielle de BEM est `BlockName__ElementName--ModifierName`.

Ces variantes peuvent s'additionner sur un bloc ou un élement comme des options. Par exemple, si on veut un petit bouton vert, on ecrira en HTML :

```html
<button class="button button--green button--small">Mon bouton</button>
```

C'est dans ce cadre, qu'on pourrait dire que BEM est verbeux, il peut effectivement y avoir plusieurs classes pour un même objet.

Mon conseil pour les modifiers, c'est de garder une notion générique, c'est à dire ne pas avoir quelque-chose comme `button--homepage` qui aurait un style spécifique à la page d'accueil. On perdrait ainsi tout l'avantage de la réutilisablilité.

![](http://fr.web.img4.acsta.net/r_1280_720/newsv7/17/08/09/14/57/3944530.jpg)

### "Euh... Un exemple ne serait pas de refus"

> Le code est diponible ici :  [https://codepen.io/qmachard/pen/rrdWXz](https://codepen.io/qmachard/pen/rrdWXz)

Prenons l'exemple d'un encart simple, qui peut avoir une image, un titre et un texte et qui peut être de couleur blanche (par défaut) ou gris.

![Illustration de l'exemple](/img/posts/bem/example-card.png)

*Afin de bien séparer les choses, nous auront deux fichiers : un fichier html `card.html` qui contiendra le code de notre bloc. Et un fichier `_card.scss` qui contiendra uniquement le style de notre bloc et préprocessé par du SCSS.*

#### Block

Pour le bloc c'est simple on l'appellera `card`. Voici son code HTML :

```html
<!-- card.html -->
<div class="card"></div>
```

Et sa classe associée :

```scss
/* _card.scss */
.card {
  display: block;
  background: white;
}
```

Pour l'instant ça ne change pas grand chose effectivement. Mais voyons la suite...

#### Element

Pour les éléments, il y aura donc une image, un titre et un texte :

```html
<!-- card.html -->
<div class="card">
  <img class="card_image" src="http://placehold.it/500x200" alt="Fake Image">
  <div class="card_content">
    <h2 class="card_title">Titre de l'encart</h2>
    <p class="card_text">Lorem ipsum dolor sit amet</p>
  </div>
</div>
```

Et son style :

```scss
/* _card.scss */
.card {
  display: block;
  background: white;
}

.card_content {
  padding: 20px;
}

.card_image {
  max-width: 100%;
  height: auto;
  margin: 0 auto;
}

.card_title {
  font-size: 1.6em;
  color: #CCCCCC;
}

.card_text {
  font-size: 1.4em;
  color: #000000;
}
```

Voilà, tout le CSS est au même niveau, c'est lisible et optimisé car sans cascade de type `.card > .title { ... }`.

> Cette approche change un peu par rapport au [spécifications de BEM](http://getbem.com/naming/). Pour le titre, il aurait fallu écrire `Card__Content__Title` mais je trouve ça réellement trop verbeux. Rien ne vous empèche de le faire si vous préfèrez.

#### Modifier

Ici on complique un peu, le modifier est une classe en plus qui peut être appliqué à notre block, _en plus_ de la classe de base

Voici donc maintenant le HTML de notre block en mode gris :

```html
<!-- card.html -->
<div class="card card--bg-grey">
  <img class="card_image" src="https://picsum.photos/500/300" alt="Fake Image">
  <div class="card_content">
    <h2 class="card_title">Titre de l'encart</h2>
    <p class="card_text">Lorem ipsum dolor sit amet</p>
  </div>
</div>
```

Et son style:

```scss
/* _card.scss */
.card {
  display: block;
  background: white;

  /* MODIFIERS */

  &--bg-grey { // Sera rendu .card--bg-grey car le & reprend le nom de la classe
    background: #999999;
  }
}

.card_content {
  padding: 20px;
}

/* On ne change rien à l'image */
.card_image {
  max-width: 100%;
  height: auto;
  margin: 0 auto;
}

.card_title {
  font-size: 1.6em;
  color: #CCCCCC;

  /* On modifie seulement la couleur du titre quand il est dans un block modifié */
  .card--bg-grey & { // Sera rendu .card--bg-grey .card_title car le & reprend le nom de la classe
    color: #FFFFFF;
  }
}

.card_text {
  font-size: 1.4em;
  color: #000000;

  /* On modifie seulement la couleur du texte quand il est dans un block modifié */
  .card--bg-grey & { // Sera rendu .card--bg-grey .card_text car le & reprend le nom de la classe
    color: #FFFFFF;
  }
}
```

On peut voir que le seule cas de cascade que l'on a est sur le modifier, ce qui rend le code optimisé. 

Chaque modification qu'apporte un modifier à un élément est écrit dans la classe css de celui-ci (`.card_text` -> `.card--black .card_text`), c'est donc plus facile à modifier et retrouver.

**Voici donc votre premier Block avec la nomenclature BEM.** Un jour, si mon encart est cliquable, on pourra le transformer en lien facilement, car il suffira uniquement de changer sont tag HTML par un `<a></a>` et de passer tous les éléments en inline. On ajoutera également un état hover à ce block qui modifiera l'ombre et la couleur du titre.

Comme ceci :

```html
<!-- card.html -->
<a class="card card--black">
  <img class="card_image" src="http://placehold.it/500x200" alt="Fake Image">
  <span class="card_content">
    <strong class="card_title">Titre de l'encart</strong>
    <span class="card_text">Lorem ipsum dolor sit amet</span>
  </span>
</a>
```

```css
/* _card.scss */
.card {
  display: block;
  background: white;

  /* STATES */

  &:hover {
    box-shadow: 0 0 2px rgba(0, 0, 0, 0.2);
  }

  /* MODIFIERS */

  &--bg-grey {
    background: #999999;
  }
}

.card_content {
  padding: 20px;
}

.card_image {
  max-width: 100%;
  height: auto;
  margin: 0 auto;
}

.card_title {
  font-size: 1.6em;
  color: #CCCCCC;

  /* STATES */

  .card:hover & {
    color: #FF5555;
  }

  /* MODIFIERS */

  .card--bg-grey & {
    color: #FFFFFF;
  }
}

.card_text {
  font-size: 1.4em;
  color: #000000;

  /* MODIFIERS */

  .card--bg-grey & {
    color: #FFFFFF;
  }
}
```

### Imbrications de blocks

Voyons quelque-chose d'un peu plus touchy. Il se peut, dans le cadre d'une molécule par exemple, qu'un block se retrouve dans un autre et a besoin d'un style différent. Deux cas se présentent donc : 

* Soit on lui créé un nouveau modifier, si il est réutilisé ailleurs
* Soit on le modifie en cascade, si le cas ne se présente que pour cette imbrication

#### Oui, je m'explique avec un exemple

Reprenons notre encart. Nous voulons mettre un bouton qui se positionne tout en bas du cadre. On dira dans ce cas : "Mon cadre contient un block bouton qui sera positionné tout en bas". Il est donc logique d'avoir une cascade : `.card .button { ... }`.

Voyons ce que ça change dans le code :

```html
<!-- card.html -->
<div class="card card--black">
  <img class="card_image" src="http://placehold.it/500x200" alt="Fake Image">
  <div class="card_content">
    <h2 class="card_title">Titre de l'encart</h2>
    <p class="card_text">Lorem ipsum dolor sit amet</p>

    <!-- Ceci est un sous block "button" -->
    <button type="button" name="button" class="button">En savoir plus</button>
  </div>
</div>
```

```css
/* _button.scss */
.button {
  background: #47cf73;
  border: none;
  padding: 10px 20px;
  color: #1e753a;
  cursor: pointer;
  
  &:hover {
    background: #75e69a;
  }
}
```

```css
/* _card.scss */
.card {
  display: block;
  position: relative;
  background: white;

  /* STATES */

  &:hover {
    box-shadow: 0 0 2px rgba(0, 0, 0, 0.2);
  }

  /* MODIFIERS */

  &--black {
    background: #999999;
  }

  /* SUB-BLOCKS */
    
  .button {
    width: 100%;
    margin-top: 20px;
  }
}

/* le reste ne change pas */
```

Voilà, vous savez tout !

## Pour aller plus loin

Comme toujours, je vous mets quelques liens que je trouve intéressants à ce sujet :

* [Introduction officielle à BEM](http://getbem.com/introduction/) (en anglais)
* [Article sur les bonnes pratiques CSS d'Alsacreations](https://www.alsacreations.com/article/lire/1641-bonnes-pratiques-en-css-bem-et-oocss.html) (en français)
* [Définition de BEM sur le (super) blog putaindecode.io](http://putaindecode.io/fr/articles/css/bem/) (en français)

N'hésitez pas à **partager cet article** et envoyer  **vos questions ou vos ressources en commentaires** ! 

![GIF: Good Bye](https://media.giphy.com/media/3o6EhGvKschtbrRjX2/giphy.gif)

A bientôt ! Q.