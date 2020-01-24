---
layout: post
title:  "Javascript from Zero to Hero - Part. 2 - DOM"
excerpt: "Le DOM Javascript, définition, sélection et manipulation"
background: '/img/posts/covers/js.jpg'
comments: true
tags: javascript
image: '/img/posts/covers/js.jpg'
---

# Javascript from Zero to Hero - Part. 2 - DOM

## What is the DOM

Une page web est un document HTML, celui-ci est interprété et rendu par le navigateur. Le navigateur créé également une représentation de ce document sous forme d'un objet appelé : Document Object Model.

![View the DOM from Google Inspector](https://miro.medium.com/max/833/1*OvQuQdj-cqgIm62NztgTiA.png)

Cet objet est nommé `document` et il permet d'accéder et de manipuler tous les autres noeuds : leurs contenus, leurs styles, etc..

### The DOM Tree

Chaque élément de l'arbre est appelé un "node", il peut être :

* un `ELEMENT_NODE` : `<html>`, `<div>`, etc.
* un `TEXT_NODE` : `"Lorem ipsum"`
* un `COMMENT_NODE` : `<!-- This is a comment node -->`

Chaque noeuds contient des attributs, ça peut être des classes, des propriétés de styles, etc.

```html
<body id="test">I'm a DIV</div>
```

```js
console.log(document.body.id); // "test"
console.log(document.body.innerText); // "I'm a DIV"
```

La modification d'un attribut impacte directement le DOM et donc le rendu de la page.

```html
<body>Hello world!</body>
```

```js
document.body.style.backgroundColor = 'red';
document.body.innerText = 'Bonjour !';
```

Résultat :

```html
<body style="background-color: red;">Bonjour !</body>
```

## Accessing DOM Elements

Seuls les balises `<head>` et `<body>` sont directement inclus dans l'objet `document`

```js
console.log(document.head); // <head>...</head>
console.log(document.body); // <body>...</body>
```

Pour tous les autres nodes, il faut passer par une fonction permettant de "requêter" les nodes. Celles-ci peuvent être appelée sur l'objet `document` mais également sur n'importe quel noeud permettant ainsi de requêter seulement les enfants de ce noeud.

### [getElementById()](https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementById)

C'est la manière la plus simple et efficace d'obtenir **un noeud**

```html
<div id="test">I'm a DIV</div>
```
```js
const test = document.getElementById('test');
console.log(test); // <div id="test">I'm a DIV</div>
```

### [getElementsByClassName()](https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByClassName)

Permet de récupérer **une liste de noeuds** ayant une classe spécifique

```html
<div id="first">
    <ul>
        <li class="one">One</li>
        <li class="one">Two</li>
        <li class="two">Three</li>
        <li class="one two">Four</li>
    </ul>
</div>
<div id="second">
    <ul>
        <li class="one">Five</li>
    </ul>
</div>
```
```js
const nodes = document.getElementsByClassName('one');

console.log(nodes);
// HTMLCollection : [
//     <li class="one">One</li>,
//     <li class="one">Two</li>,
//     <li class="one two">Four</li>,
//     <li class="one">Five</li>,
// ]

const otherNodes = document.getElementById('first').getElementsByClassName('one');

console.log(otherNodes)
// HTMLCollection : [
//     <li class="one">One</li>,
//     <li class="one">Two</li>,
//     <li class="one two">Four</li>,
// ]
```

Le résultat étant une liste de noeuds, pour modifier leurs attributs, il faudra passer par une boucle.

```js
const nodes = document.getElementsByClassName('one');

for (let i = 0; i < nodes.length; i++) {
    nodes[i].style.backgroundColor = 'red';
}
```

### [getElementsByTagName()](https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByTagName)

Permet de récupérer tous les éléments de même tag

```html
<ul>
    <li class="one">One</li>
    <li class="one">Two</li>
    <li class="two">Three</li>
    <li class="one two">Four</li>
</ul>
```

```js
const nodes = document.getElementsByTagName('li');

console.log(nodes);
// HTMLCollection : [
//     <li class="one">One</li>,
//     <li class="one">Two</li>,
//  <li class="two">Three</li>,
//     <li class="one two">Four</li>,
// ]
```

### Query Selectors

Deux méthodes sont très intéressantes : `querySelectorAll` et `querySelector`. La première permet de récupérer tous les noeuds correspondants à la requête, la seconde récupère seulement le premier noeud de cette requête.

```html
<div class="one">
    <div class="two">Lorem ipsum</div>
    <div class="three">Hello World !</div>
</div>
<div class="four">
    <div class="two">This is a div</div>
</div>
```

```js
const nodes = document.querySelectorAll('.two');

console.log(nodes);
// NodeList : [
//     <div class="two">Lorem ipsum</div>,
//  <div class="two">This is a div</div>,
// ]

const node = document.querySelector('.two');

console.log(node);
// <div class="two">Lorem ipsum</div>

const anotherNode = document.querySelector('.four > .two');

console.log(anotherNode);
// <div class="two">This is a div</div>
```

## Events

Javascript est un langage qui a été écrit pour fonctionner de manière évènementielle. Ce qui fait que chaque noeud va propager des événements : `MouseEvent`, `KeyboardEvent`, etc. que l'on pourra intercepter.

### Add Listener

Pour écouter un événement, on utilise la méthode : [`.addEventListener()`](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener) :

```html
<button id="button">Click me!</button>
```
```js
const button = document.getElementById('button');

const handleClick = e => {
    console.log(e); // MouseEvent : { type: "click", target: button#button, ... }
}

button.addEventListener('click', handleClick, false);
```

La fonction `handleClick` sera déclanchée seulement lorsque l'utilisateur cliquera sur le bouton. On appellera cette fonction une fonction "callback".

### Remove Listener

Pour supprimer un listener, il faut utiliser la méthode : [`.removeEventListener()`](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener)

```js
button.removeEventListener('click', handleClick, false);
```
```