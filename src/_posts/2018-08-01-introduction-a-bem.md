---
layout: post
title:  "Introduction à BEM"
excerpt: "BEM, Block Element Modifier, définition, et cas d'utilisation."
background: '/img/posts/2018-04-12-hello-world.jpg'
comments: true
tags: html css bem
---

# Introduction à BEM

Cet article s'adresse surtout aux intégrateurs HTML / CSS. Il permet de définir une nommenclature pour le CSS car, comme toujours, le plus dur est de nommer les choses. Voyons donc une approche différente de l'intégration avec BEM.

## BEM, Késako ?

Créée par [@iamstarkov](https://twitter.com/iamstarkov) et [@flatdrop](https://github.com/floatdrop), BEM, *Block Element Modifier*, est une convention de nommage qui s'applique sur le principe des **éléments réutilisables**.

BEM se base donc **uniquement sur des classes CSS** et est donc complètement **décorrélé de la sémantique** HTML ce qui est un **point positif pour l'accessibilité** (Si vous ne l'avez pas encore lu, je vous renvois sur mon [article d'introduction à l'accessibilité]({% post_url 2018-07-03-rendre-son-site-accessible %})).

La règle d'or à retenir est :

> **Tout élément devant être stylisé doit avoir une classe.**

 Comme toute convention, elle a ses avantages et ses limites.

### Avantages

#### Performance

La nommenclature de BEM permet d'avoir **la plupart des classes CSS au premier niveau**. On évite ainsi la cascade CSS qui est plus longue à être interprétée par le navigateur. Et oui, `.foo > .bar` est plus long à interprété par le navigateur que `.foo_bar`.

![Homme montrant sa montre pour dire que le temps presse.](https://media.giphy.com/media/26n6xBpxNXExDfuKc/giphy.gif)

#### Maintenabilité et propreté

**Chaque composant est indépendant** et peut facilement être modifié et retrouvé. Il peut également être surclassé sans utiliser `!important`.

![GIF: Applaudissements d'un homme content](https://media.giphy.com/media/pEBTYXKRdu7M4/giphy.gif)

Cela permet donc d'éviter ce genre de code CSS :

```css
h2 {
  position: absolute;
}
.my-aside-title {
  font-size: 1.5em; /* Je style mon titre, OK c'est propre */
}
.my-aside h2.my-aside-title {
  position: inherit; /* Ah merde, annulation d'une règle sur h2 prévue pour autre chose */
}
```

Aussi, il permet de **fractionner son code** et **faciliter l'utilisation des pré-processeurs CSS** (tels que SASS ou SCSS).

Cette nommenclature sera également **parfaite pour une intégration en mode "Atomic"** (Wait! Je garde ça pour un autre article... *Teaser!*). Mais aussi en React et Angular, par exemple, où la logique est de faire des composants réutilisables.

#### Structuration

Comme on a pu le voir plus haut, chaque block / élément **ne dépend pas de son tag HTML**. On peut donc facilement optimiser le SEO et l'accessibilité.

### Inconvénients

Alors après tous ces avantages, qu'est-ce qu'on peut bien lui trouvé de mauvais ?

#### Verbeux

![GIF: Gna gna gna](https://media.giphy.com/media/3oriNXSR3p6iPY7GrC/giphy.gif)

Et oui, vous vous en doutiez un peu. Pour que ça fonctionne, la nommenclature de BEM est **un petit peu verbeuse**. Les noms des classes sont long, mais plus tard, nous allons voir comment je l'implémente dans mes projets et finalement, *c'est pas si moche !*

## Vous avez dit BEM ?

Maintenant que l'on a fait la liste des avantages et inconvénients d'une telle solution, voyons de plus près comment elle s'utilise !

![GIF: Détective regardant avec une loupe](https://media.giphy.com/media/JUh0yTz4h931K/giphy.gif)

### Définition de BEM

![Schéma montrant le découpage de BEM](http://getbem.com/assets/github_captions.jpg)

#### B comme Block

Un *block* est l'**élément parent de notre composant**, le but est de tout encapsuler dans celui-ci, dans la limite du possible bien évidemment. Il se note de la manière suivante : `block-name`, facile non ?

*Dans l'exemple ci-dessus, "menu" est un block. Sa classe sera au plus simple : `menu`*

#### E comme Element

Un *element* est **ce qui compose le block**. Comme vu plus haut, "tout ce qui a besoin d'être stylisé doit avoir une classe", nous allons donc "classer" les éléments, pour ce faire la notation sera la suivante : `block-name_element-name`.

*Dans l'exemple ci-dessus, "menu elements" seront des élements. Leur classe sera certainement : `.menu_element`*.

#### Et le M ? M pour Modifier

Un *modifier* est un état du block, un mode. Par exemple un block `button` qui par défaut est blanc peut avoir une couleur différente si il permet de valider ou supprimer quelque-chose. La syntaxe sera la suivante `block-name_element-name--modifier`

*Dans l'exemple ci-dessus, le block `button` aura un modifier "theme green" qui permettra d'afficher le bouton en vert*.

> J'ai pas tout compris, un exemple ne serait pas de refus [https://codepen.io/anon/pen/qoEZOO](https://codepen.io/anon/pen/qoEZOO)

### Exemple

Prenons l'exemple d'un encart simple, qui peut avoir une image, un titre et un texte et qui peut être de couleur blanche (par défaut) ou gris.

![](C:\Users\qmachard\Perso\blog\src\img\posts\exemple_bem_1.png)

#### Block

Pour le block c'est simple on l'appellera `card`. Voici son code HTML

```html
<div class="card"></div>
```

Et sa classe associée :

```scss
.card {
  display: block;
  background: white;
}
```

Pour l'instant ça ne change pas grand chose effectivement. Mais voyons la suite...

#### Element

Pour les éléments, il y aura donc une image, un titre et un texte :

```html
<div class="card">
  <img class="card_image" src="http://placehold.it/500x200" alt="Fake Image">
  <div class="card_content">
    <h2 class="card_title">Titre de l'encart</h2>
    <p class="card_text">Lorem ipsum dolor sit amet</p>
  </div>
</div>
```

Et son CSS

```scss
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
  font-size: 16px;
  color: #CCCCCC;
}

.card_text {
  font-size: 14px;
  color: #000000;
}
```

Voilà, tout le CSS est au même niveau, c'est lisible et optimisé car sans cascade de type `.card > .title { ... }`.

#### Modifier

Ici on complique un peu, le modifier est une classe en plus qui peut être appliqué à notre block, _en plus_ de la classe de base

Voici donc maintenant le HTML de notre block en mode gris :

```html
<div class="card card--bg-grey">
  <img class="card_image" src="https://picsum.photos/500/300" alt="Fake Image">
  <div class="card_content">
    <h2 class="card_title">Titre de l'encart</h2>
    <p class="card_text">Lorem ipsum dolor sit amet</p>
  </div>
</div>
```

Et son CSS

```scss
.card {
  display: block;
  background: white;

  /* MODIFIERS */

  &--bg-grey { /* Petit tips SCSS : sera rendu .card--black car le & reprend le nom de la classe */
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
  font-size: 16px;
  color: #CCCCCC;

  /* On modifie seulement la couleur du titre quand il est dans un block modifié */
  .card--black & { /* Petit tips SCSS : sera rendu .card--black .card_title car le & reprend le nom de la classe */
    color: #FFFFFF;
  }
}

.card_text {
  font-size: 14px;
  color: #000000;

  /* On modifie seulement la couleur du texte quand il est dans un block modifié */
  .card--black & { /* Petit tips SCSS : sera rendu .card--black .card_text car le & reprend le nom de la classe */
    color: #FFFFFF;
  }
}
```

On peut voir que le seule cas de cascade que l'on a est sur le modifier, ce qui rend le code optimisé. Chaque modification qu'apporte un modifier à un élément est écrit dans la classe css de celui-ci (`.card_text` -> `.card--black .card_text`), c'est donc plus facile à modifier et retrouver.

Et voilà, votre premier Block avec la nomenclature BEM. Demain, si mon encart est cliquable, on pourra le transformer en lien facilement, car il suffira uniquement de changer sont tag HTML par un `<a></a>` et de passer tous les éléments en inline. On ajoutera également un état hover à ce block qui modifiera l'ombre et la couleur du titre.

```html
<a class="card card--black">
  <img class="card_image" src="http://placehold.it/500x200" alt="Fake Image">
  <span class="card_content">
    <strong class="card_title">Titre de l'encart</strong>
    <span class="card_text">Lorem ipsum dolor sit amet</span>
  </span>
</a>
```

```css
.card {
  display: block;
  background: white;

  /* STATES */

  &:hover {
    box-shadow: 0 0 2px rgba(0, 0, 0, 0.2);
  }

  /* MODIFIERS */

  &--black {
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
  font-size: 16px;
  color: #CCCCCC;

  .card:hover & {
    color: #FF5555;
  }

  .card--black & {
    color: #FFFFFF;
  }
}

.card_text {
  font-size: 14px;
  color: #000000;

  .card--black & {
    color: #FFFFFF;
  }
}
```

### Imbrications de blocks

Voyons quelque-chose d'un peu plus touchy. Il se peut, dans le cadre d'une molécule par exemple, qu'un block se retrouve dans un autre et a besoin d'un style différent. Deux cas se présentent donc : soit on lui créé un nouveau modifier si il est réutilisé ailleurs, soit on le modifie en cascade si le cas ne se présente que pour cette imbrication.

#### Exemple

Reprenons notre exemple d'encart. Nous voulons mettre un bouton qui se positionne tout en bas du cadre. On dira dans ce cas : "Mon cadre contient un block bouton qui sera positionné tout en bas". Il est donc logique d'avoir une cascade : `.card .button { ... }`.

```html
<div class="card card--black">
  <img class="card_image" src="http://placehold.it/500x200" alt="Fake Image">
  <div class="card_content">
    <h2 class="card_title">Titre de l'encart</h2>
    <p class="card_text">Lorem ipsum dolor sit amet</p>

    <!-- Ceci est un sous block de bouton -->
    <button type="button" name="button" class="button">En savoir plus</button>
  </div>
</div>
```

```css
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

Comme toujours, je vous mets une liste d'articles que je trouve intéressants à ce sujet :

* [Introduction officielle à BEM](http://getbem.com/introduction/) (en anglais)
* [Article sur les bonnes pratiques CSS d'Alsacreations](https://www.alsacreations.com/article/lire/1641-bonnes-pratiques-en-css-bem-et-oocss.html) (en français)
* [Définition de BEM sur le (super) blog putaindecode.io](http://putaindecode.io/fr/articles/css/bem/) (en français)

N'hésitez pas à partager **vos questions ou vos ressources en commentaires** !

A bientôt !
