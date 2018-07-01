---
layout: post
title:  "Rendre son site Accessible"
subtitle: "Définition de l'accessiblité, des bonnes pratiques et des outils."
background: '/img/posts/2018-06-14-accessibility.jpg'
---

# Rendre son site accessible

Ayant eu l'occasion de travailler sur le projet d'un site pour une organisation publique, j'ai été amené à faire des recherches concernant l'accessibilité. Il me tenait donc à coeur d'écrire un article sur le sujet, car je trouve qu'il est important et relativement simple de rendre son site accessible.

## Introduction

### Définition

> L'accessibilité numérique est la **mise à la disposition des ressources numériques pour tous les individus**, quels que soit leur matériel ou logiciel, leur infrastructure réseau, leur langue maternelle, leur culture, leur localisation géographique, ou leurs aptitudes physiques ou mentales.
>
> — MDN Mozilla

Il faut donc retenir que l'accessibilité ne touche **pas seulement le handicap**, il prend également en compte le support de l'utilisateur (mobile, tablette) mais aussi son infrastructure réseau, etc. En fait, il participe au **bien-être d'un utilisateur** sur un site.

### Bénéfices

#### Site utilisable par tout le monde

Un site web, par définition, répond à un besoin. Il est donc **primordial que cette réponse soit ouverte au plus grand nombre**.

#### Accessibilité + SEO = ❤️

Beaucoup de principes d'accessibilité sont **bénéfiques pour le référencement**. Il passe notamment par la bonne sémantique de ses pages. Autant faire d'une pierre deux coups.

#### Éthique et morale

L'accessibilité montre qu'un site est ouvert à l’autre, ce qui favorise son image.

### Handicaps et solutions

Il est important de penser à **tous les cas de "handicap"**, pas seulement les cas courants et ne pas se restreindre à ses propres conditions (réseaux, taille d'écran, système d'exploitation, etc.).

Il faut réussir à se mettre **dans les conditions d'utilisation** et pour cela utiliser des outils spécialisés permettant d'apporter des solutions.

*Faisons un point sur les solutions existantes pour chaque trouble* :

#### Troubles de la vue

Les personnes ayant des troubles de la vue auront plus de mal à lire le contenu d'une page si les couleurs utilisées manquent de contraste. C'est pour cela que **le contraste est un critère important pour l'accessibilité**.

Les personnes aveugles ou malvoyantes utiliseront, quant à elle, un [logiciel de lecteur d'écran](http://www.sautcreatif.com/fr/accessibilite-comment-lire-page-web-quand-mal-voyant-ou-non-voyant/). Celui-ci est **inefficace si le contenu du site n'est pas bien structuré sémantiquement**.

#### Troubles de l'audition

Les internautes malentendants ne pourront pas écouter des sons ou des vidéos. Une solution simple est de **transcrire textuellement le contenu du média** ou encore de **mettre à disposition des sous-titres**.

#### Trouble de la mobilité

Certaines personnes ont du mal à appréhender une souris, ou n'en ont tout simplement pas. Ils devront donc **naviguer sur le site au clavier**.

#### Trouble cognitif

Pour aider les utilisateurs ayant des [troubles cognitifs](https://sante-medecine.journaldesfemmes.fr/faq/38498-trouble-cognitif-definition), il est important que le **site soit cohérent et simple**.

* Header et footer, toujours placés aux mêmes endroits suivant les pages
* Formulaires simples et expliqués
* Limitation du nombre d'informations contenues dans une page
* Utilisation d'un langage simple et clair

### Normes existantes

Le W3C a défini un certain nombre de critères dans une norme appelée [*Web Content Accessibility Guidelines* (WCAG)](https://www.w3.org/Translations/WCAG20-fr/).

En France, le ministère de l'Intérieur en a fait une adaptation appelée [*Référentiel Général d'Accessibilité pour les Administrations* (RGAA)](https://references.modernisation.gouv.fr/rgaa-accessibilite/).

Ces deux normes contiennent 3 niveaux de critères :

* **A**: Niveau standard, ce qu'on va voir dans cet article.
* **AA**: Niveau avancé.
* **AAA**: Niveau expert, pour moi très difficile a atteindre, mais on peut réussir a atteindre quelques points.

## Bonnes pratiques

Maintenant que l'on connaît les problèmes d'accessibilité et les solutions existantes, que doit-on faire en tant que développeur / intégrateur web ? **N'ayez crainte, c'est pas si compliqué !!**

![Go on... (The IT Crowd - Moss)](https://media3.giphy.com/media/3oKIPnbKgN3bXeVpvy/giphy.gif)

### La sémantique

Comme vous le savez maintenant, les liseuses d'écran, tout comme les robots, s'appuient essentiellement sur le code de votre page web. Il est donc nécessaire d'**utiliser le bon balisage HTML**.

En plus de l'accessibilité, cela ajoute quelques bénéfices :

- **Facilite les développements** : Fonctionnalités natives sans Javascript
- **Meilleur pour le mobile** : Plus organisé et donc plus facile à rendre responsive
- **Bon pour le SEO** : Les moteurs de recherches donnent de l'importance aux mots clés présents dans les balises de titres et aux sections des sites.

#### La structure de la page

Le but est d'**utiliser tout simplement les bonnes balises HTML** en fonction de la nature de l'élément afin de hiérarchiser les informations sur la page.

- En-têtes de page, de section ou d'articles : `<header>`
- Pied de page, de section ou d'articles : `<footer>`
- Navigations : `<nav>`
- Sections de page : `<main>`, `<section>`, `<article>`, `<aside>`

[Retrouvez la liste des nouvelles balises HTML5 et comment les utiliser](https://www.alsacreations.com/article/lire/1376-html5-section-article-nav-header-footer-aside.html)

##### Par exemple

```html
<header>
  <h1>Header</h1>
</header>

<nav>
  <!-- main navigation in here -->
</nav>

<!-- Here is our page's main content -->
<main>
  <article>
    <h2>Article heading</h2>
  </article>

  <aside>
    <h2>Related</h2>
  </aside>
</main>

<!-- And here is our main footer that is used across all the pages of our website -->
<footer>
  <!-- footer content in here -->
</footer>
```
Et si vous aviez l'habitude ~~des années 2000~~ d'utiliser des tableaux pour vos mises en page, sachez que **l'usage des tableaux pour structurer une page est strictement interdit !**

![Animation d'un homme s'écriant "NON!"](https://media.giphy.com/media/12XMGIWtrHBl5e/giphy.gif)

#### La structure du texte

De la même manière que pour la page, il est important d'**utiliser les bonnes balises de texte**. Celles-ci permettent de différencier, **autrement que par le style d'affichage**, un titre, un paragraphe, une liste, etc.

- Titres : `<h1>`, `<h2>`...
- Paragraphes :  `<p>`
- Listes : `<ul>` et `<ol>` + `<li>`
- Mise en avant de texte : `<em>` ou `<strong>` au lieu de `<b>` et `<i>`

##### Exemple

À faire :

```html
<h1>My heading</h1>

<p>This is the first section of my document.</p>

<p>I'll add another paragraph here too.</p>

<ol>
  <li>Here is</li>
  <li>a list for</li>
  <li>you to read</li>
</ol>

<h2>My subheading</h2>

<p>This is the first subsection of my document. I'd love people to be able to find this content!</p>
```

À ne pas faire :

```html
<font size="7">My heading</font>
<br><br>
This is the first section of my document.
<br><br>
I'll add another paragraph here too.
<br><br>
1. Here is
<br><br>
2. a list for
<br><br>
3. you to read
<br><br>
<font size="5">My subheading</font>
<br><br>
This is the first subsection of my document. I'd love people to be able to find this content!
<br><br>
```

Visuellement, les deux codes donnent le même résultat. On se rend bien compte que le premier est bien plus lisible que le second.

#### Actions et formulaires

Il faut essayer d'**utiliser au maximum les balises prévues** pour l'action souhaitée (`<button>`, `<a>`, etc.). **Le label de ces balises doit être explicite** pour éviter de se retrouver avec des "cliquez ici" sur toute la page.

Remplacez :

```html
<p>Les baleines sont de très jolies créatures. Pour en savoir plus, <a href="whales.html">cliquez ici</a>.</p>
```

Par :

```html
<p>Les baleines sont de très jolies créatures. <a href="whales.html">En savoir plus sur les baleines</a>.</p>
```

#### Tableaux

Qui a dit que les tableaux n'étaient pas accessibles ? Biens utilisés et implémentés, ils le sont. Il y a juste quelques règles à respecter :

- Ajouter une description  au tableau : `<caption>`
- Utiliser les structures de tableau : `<thead>`, `<tfoot>`, `<tbody>`
- Utilisation de l'attribut `scope`de la balise `<th>` pour spécifier si le header correspond à la ligne (`scope="row"`) ou à la colonne (`scope="row"`)

Plus d'informations sur [les tableaux accessibles sur la MDN web docs](https://developer.mozilla.org/fr/Apprendre/HTML/Tableaux/Advanced)

```html
<table>
  <caption>Comment j'ai choisi de dépenser mon argent</caption>
  <thead>
    <tr>
      <th scope="col">Achats</th>
      <th scope="col">Ou ?</th>
      <th scope="col">Date</th>
      <th scope="col">Avis</th>
      <th scope="col">Coût (€)</th>
    </tr>
  </thead>
  <tfoot>
    <tr>
      <td colspan="4">SUM</td>
      <td>48</td>
    </tr>
  </tfoot>
  <tbody>
    <tr>
      <th scope="row">Coupe de cheveux</th>
      <td>Coiffeur</td>
      <td>12/09</td>
      <td>Bonne idée</td>
      <td>30</td>
    </tr>
    <tr>
      <th scope="row">Lasagnes</th>
      <td>Restaurant</td>
      <td>12/09</td>
      <td>Regrets</td>
      <td>18</td>
    </tr>
  </tbody>
</table>
```

#### Images

Les images, qui ne sont pas décoratives, **doivent avoir un texte alternatif** afin d'être interprétées par le public malvoyant. Celui-ci doit être une description claire de l'image.

```html
<img src="dinosaur.png" alt="A red Tyrannosaurus Rex: A two legged dinosaur standing upright like a human, with small arms, and a large head with lots of sharp teeth.">
```

[Plus d'informations sur les images accessibles](http://mdn.github.io/learning-area/accessibility/html/accessible-image.html).

### Design et CSS

#### Contrastes

Une **attention particulière doit être portée sur les contrastes**. Certains outils en ligne existent pour faciliter les tests.

Quelques sites proposent même un **bouton permettant d'augmenter les contrastes** en modifiant les couleurs. C'est le cas du [site de la SNCF](https://www.sncf.com/fr) par exemple.

#### Focus clavier

On a vu tout à l'heure que le site devait être **navigable au clavier**. Il est donc important de savoir où est le focus.

Par défaut, les navigateurs proposent une bordure pas forcément très design... On peut donc tout simplement proposer une alternative en CSS grâce au `:focus` qui s'utilise de la même manière que le `:hover`.

#### Éléments masqués

Dans certains cas, on veut **rendre "visible" des éléments seulement pour les liseuses d'écran**, mais pas pour tout le monde.

La solution est donc de les masquer en CSS, mais tout n'est pas si simple, le **`display: none;` n'est pas interprété par les liseuses**.

![GIF de Minion s'écriant "WHAT?!!"](https://media.giphy.com/media/SqmkZ5IdwzTP2/giphy.gif)

Rassurez-vous, il existe pas mal de [possibilités pour contourner cette "limite"](https://webaim.org/techniques/css/invisiblecontent/). Par exemple :

```html
<i class="icon icon-phone"><span class="hidden-label">Téléphone :</span></i>
```

```css
/* Non interprété par une liseuse */
.hidden-label {
    display: none;
    /* ou */
    visibility: hidden;
}
```

```css
/* Interprété par une liseuse */
.hidden-label {
	overflow: hidden;
	text-indent: -10000px;
    /* ou */
	overflow: hidden;
	width: 0;
    height: 0;
}
```
![GIF de la scène "On me voit, on me voit plus" du film Asterix et Obélix: Mission Cléopatre](https://78.media.tumblr.com/c0d4cf8e8e91c5f72f31605da8a537f0/tumblr_inline_oya8nkAdWz1s9x8us_540.gif)

### WAI-ARIA

On utilise de plus en plus de javascript pour améliorer l'expérience utilisateur. Cependant, les liseuses interprètent très mal ces widgets. Pour améliorer cette prise en charge, le W3C a ajouté des attributs à ses standards, ils sont appelés *WAI-ARIA*.

Ils se découpent en deux catégories :

- Les **rôles** permettent de définir la fonction de l'élément :
  - Navigation : `role="navigation"` (comme `<nav>`)
  - Sidebar : `role="complementary"` (comme `<aside>`)
  - Bannière : `role="banner"`
  - Recherche : `role="search"`
  - Onglets : `role="tabgroup"` et `role="tab"`
  - Etc.
- Les **propriétés** permettent de définir des états, labels sur les éléments
  - Élément requis : `aria-required="true"`
  - Élément désactivé : `aria-disabled="true"`
  - Élément non-visible : `aria-hidden="true"`
  - Etc.

Il existe tout un tas d'attributs ARIA. Une liste est disponible sur la [MDN web docs](https://developer.mozilla.org/en-US/docs/Learn/Accessibility/WAI-ARIA_basics).

Pour voir comment ça fonctionne, prenons l'exemple d'un affichage en onglets.

```html
<ol>
  <li id="ch1Tab">
    <a href="#ch1Panel">Chapitre 1</a>
  </li>
  <li id="ch2Tab">
    <a href="#ch2Panel">Chapitre 2</a>
  </li>
  <li id="quizTab">
    <a href="#quizPanel">Quiz</a>
  </li>
</ol>

<div>
  <div id="ch1Panel">Le contenu du chapitre 1 va ici</div>
  <div id="ch2Panel">Le contenu du chapitre 2 va ici</div>
  <div id="quizPanel">Le contenu du Quiz va ici</div>
</div>
```

Visuellement, ça fonctionne, mais côté code on ne comprend pas trop...

Voici donc le même widget avec les attributs ARIA ajoutés.

```html
<ol role="tablist">
  <li id="ch1Tab" role="tab">
    <a href="#ch1Panel">Chapter 1</a>
  </li>
  <li id="ch2Tab" role="tab">
    <a href="#ch2Panel">Chapter 2</a>
  </li>
  <li id="quizTab" role="tab">
    <a href="#quizPanel">Quiz</a>
  </li>
</ol>

<div>
  <div id="ch1Panel" role="tabpanel" aria-labelledby="ch1Tab">
      Chapter 1 content goes here
  </div>
  <div id="ch2Panel" role="tabpanel" aria-labelledby="ch2Tab">
      Chapter 2 content goes here
  </div>
  <div id="quizPanel" role="tabpanel" aria-labelledby="quizTab">
      Contenu du Quiz
  </div>
</div>
```

### Mobile

Concernant le responsive, **si le site est optimisé pour une navigation sur mobile c'est parfait**. Pensez néanmoins à ne pas désactiver le zoom sur le viewport afin qu'une personne puisse agrandir ou réduire le texte à sa guise.

Aussi, afin d'afficher un clavier optimisé, il faut utiliser les bons types de champs (`type="email"`, `type="tel"`, etc.).

## Outils et Ressources

Je vous présente quelques outils permettant de tester ou d'améliorer l'accessibilité d'une page web.

### Wave

**[WAVE](https://wave.webaim.org) est une extension gratuite** pour Chrome et Firefox créée par WebAIM. Elle permet de mettre en avant les bonnes et mauvaises pratiques mises en place sur une page web.

![Capture d'écran du plugin WAVE](https://lh3.googleusercontent.com/pWuGtAxAUGMBUtVsQUXIqgK3XAFeMQQIpBtcjGvf_A7gG1_Sba31fAJxXz-IY5R-bmJuT0-r=w800-h600-e365)

Il permet de mettre en avant la structure du document, les liens vides, les balises `alt` sur les images, etc. Mais aussi, il permet d'afficher la page sans CSS et en mode "outline" qui contient seulement la titraille pour comprendre l'organisation de celle-ci. Autre fonction intéressante, il permet de montrer les problèmes liés aux contrastes.

Bien sûr, comme tout outil automatique, **il ne faut pas prendre tout au pied de la lettre**. Par exemple, si l'outil nous dit qu'une balise `alt` n'est pas renseignée, il faut se poser la question pour **savoir si elle a réellement besoin de l'être** ou si l'image n'est là que pour un côté décoratif.

[Découvrir WAVE](https://wave.webaim.org)

### RGAA et WCAG

Même si ces documentations semblent très verbeuses, elles forment de **très bons référentiels** pour savoir si tous les aspects de l'accessibilité sont bien pris en compte. Le RGAA met également à disposition une procédure de tests pour chaque critère.

[Lire le RGAA](https://references.modernisation.gouv.fr/rgaa-accessibilite/)

![Keep calm and RTFM](https://media.forgecdn.net/avatars/101/978/636327059561858229.png)

### Web

Des sites et articles comme celui-ci, il y en a (heureusement) plein d'autres. Voici ceux que je peux vous conseiller.

*Cette liste est non exhaustive et pourra être complétée si je trouve d'autres ressources intéressantes.*

#### a11ymatters

Ce site est une petite mine d'or, il est spécialisé dans l'accessibilité web et publie des articles sur ce sujet.

Le petit plus, il propose également des "Patterns", qui sont des tutos très bien expliqués sur des widgets régulièrement utilisés sur le web : pagination, formulaire de recherche, etc.

[Visiter a11ymatters](http://www.a11ymatters.com/)

*Le site est en anglais*

#### MDN WebDoc

Créé par Mozilla, il fait partie de l'ensemble de la documentation pour les développeurs web. Je vous conseille de lire l'[article d'introduction à l'accessibilité](https://developer.mozilla.org/fr/Apprendre/a11y/What_is_accessibility), qui permet de comprendre rapidement les bases de l'accessibilité.

[Visiter MDN WebDoc](https://developer.mozilla.org/fr/docs/Accessibilité)

*Le site est traduit en français, mais il reste quelques articles en anglais.*

#### WCAG : Introduction

Introduction officielle à la WCAG, c'est un peu la bible de celui pour qui l'accessibilité est importante.

[Lire l'introduction au WCAG](https://www.w3.org/WAI/standards-guidelines/wcag/)

*Le site est en anglais.*

#### Alsacréation

Le très connu Alsacréation a écrit toute une guideline complète (open source et en français) sur l'accessibilité.

[Visiter Alsacréation](https://www.alsacreations.com/outils/guidelines/Guidelines-Accessibilite.md)

*Le site est en français.*

## Conclusion

Voilà, vous êtes maintenant prêts pour améliorer l'accessibilité de votre site web. Comme vous avez pu le voir, ce sont de petites choses, mais je pense que vous vous êtes déjà tous retrouvés devant un site qui n'était pas optimisé pour votre support, et vous comprenez donc pourquoi ces petites choses sont importantes.

Il existe beaucoup de règles que je n'ai pas énoncées dans cet article. Je vous conseille donc de [lire le RGAA](https://references.modernisation.gouv.fr/rgaa-accessibilite/).