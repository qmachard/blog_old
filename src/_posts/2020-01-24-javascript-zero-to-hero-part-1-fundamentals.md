---
layout: post
title:  "Javascript from Zero to Hero - Part. 1 - Fundamentals"
excerpt: "Les fondamentals de Javascript et les nouveautées ES6 : Variables, Functions, Destructuration, etc."
background: '/img/posts/covers/js.jpg'
comments: true
tags: javascript
image: '/img/posts/covers/js.jpg'
---

# Javascript from Zero to Hero - Part. 1 - Fundamentals

## Variables

### Variables types

Javascript n'est pas un langage explicitement typé, mais il existe 5 types primitifs à connaitre :

* string: `"lorem ipsum"`
    * Inclus la chaine vide et tous les autres chaines de caractères `'...'` ou `"..."`
* number: `-2.36`
    * Peut être un entier, un décimal ou une valeur spécifique : `NaN` (Not a Number) ou `Infinity`
* boolean: `true`
    * Seulement deux valeurs possibles
* object : `{ foo: 'bar' }`
    * Inclus les tableaux `Array`, les fonctions `Function` et les objets "ordinaires" `Object, Date, RegExp, ...`
* null: `null`
* undefined: `undefined`

### Falsy values

Certaines valeurs sont évaluées comme `false` dans un contexte conditionnel :

* `false`
* `null`
* `undefined`
* `0`
* `NaN`
* `''`

Attention donc à la valeur `0` ou `''` qui dans certains contextes métier ne sont pas "fausses", par exemple, si vous voulez savoir si un utilisateur à bien renseigné un champs de formulaire et qu'il a renseigné `0` :

```js
function checkValue(value) {
    if (value) {
        return true;
    }
    
    return false;
}

checkField(null); // false
checkField(1);    // true
checkField(0);    // false -> Here, we would like to get "true" because 0 is a correct value

function checkValue2(value) {
    if (undefined !== value && null !== value) {
        return true;
    }
    
    return false;
}

checkField2(null); // false
checkField2(1);    // true
checkField2(0);    // true
```

## Variables scoping : `let` & `const` vs `var`

Le scope de `var` est la fonction

```js
function someFunction() {
    if (condition) {
        var foo = 'bar';
    }
    
    console.log(foo); // bar
}

console.log(foo); // ReferenceError
```

Le scope de `let` & `const` est le bloc (`{ ... }`)

```js
function someFunction() {
    if (condition) {
        let foo = 'foo';
        const bar = 'bar';
        
        console.log(foo); // foo
        console.log(bar); // bar
    }
    
    console.log(foo); // ReferenceError
    console.log(bar); // ReferenceError
}
```

Depuis ES6, il est préconisé d'utiliser `let` et `const` plutôt que `var`.

### Variable and immutability : `let` vs `const`

`const` est immuable, on ne peut l'assigner qu'une fois

> Dans le cas d'un objet, on peut changer ses propriétés

```js
const foo = { bar: 1 };
foo = 'bar' // TypeError: Assignment to constant variable.

foo.bar = 2; 
console.log(foo); // { bar: 2 }
```

## Functions

### Simple functions

Une fonction en javascript s'écrit avec le mot clé `function`.

```js
function myFunction(variable) {
    console.log(variable);
}

myFunction('foo'); // foo
```

### Object context : What is `that` ?

Chaque fonction définie par le mot clé `function` défini son propre `this`, ce qui peut poser des confusions.

```js
function Personne() {
    this.age = 0;
    
    setTimeout(function growUp() {
        this.age++;
    }, 1000);
}

var p = new Personne();
console.log(p.age); // 0

setTimeout(function() {
    console.log(p.age); // 0
}, 2000);
```

On s'attendait à avoir `1` lors du deuxième log, or le `this` a été redéfini pour la fonction `growUp`.

Pour corriger, en ES2015 il fallait passer par une variable intermédiaire : `that`

```js
function Personne() {
    var that = this; // Save the current this into var
    that.age = 0;
    
    setTimeout(function() {
        that.age++; // We use the variable that instead of this
    }, 1000);
}

var p = new Personne();
console.log(p.age); // 0

setTimeout(function() {
    console.log(p.age); // 1
}, 2000);
```

### Arrow functions

Depuis ES6, on peut écrire une fonction sous cette forme :

```js
const myFunction = (variable) => {
    console.log(variable);
}

myFunction('foo'); // foo
```

Cette notation permet de ne pas redéfinir de `this` au sein de celle-ci et donc de ne pas avoir besoin de créer une variable intermédiaire `that`.

```js
function Personne() {
    this.age = 0;
    
    setTimeout(() => {
        this.age++;
    }, 1000);
}

var p = new Personne();
console.log(p.age); // 0

setTimeout(function() {
    console.log(p.age); // 1
}, 2000);
```

## Destructuring / Restructuring

### Object Destructuring

Pour récupérer une valeur d'un objet et le stocker dans une variable en ES2015 :

```js
const foo = { bar: 1 };
const bar = foo.bar;

console.log(bar); // 1
```

Depuis ES6, on peut "destructurer" un objet et donc récupérer directement ses valeurs :

```js
const foo = { bar: 1 };
const { bar } = foo;

console.log(bar); // 1
```

L'avantage est de pouvoir récupérer des infos "nested" et d'appliquer des valeurs par défaut :

```js
const foo = { 
    bar : {
        zed: "Current Value",
        noValue: undefined,
    }
}
const { bar: { zed = "This is default value", noValue = "This is default value" } } = foo;

console.log(zed); // Current Value
console.log(noValue); // This is default value

console.log(bar); // ReferenceError: bar is not defined 
```

Cette méthode est également beaucoup utilisée en passage de paramètres d'une fonction

```js
const foo = ({ var1, var2 }) => {
    console.log(var1);
    console.log(var2);
}

foo({
    var1: 1,
    var2: 2
});

// 1
// 2
```

### Array Destructuring

On peut aussi récupérer une valeur d'un tableau :

```js
const foo = [ 1, 2, 52 ];
const [one, two] = foo;

console.log(one); // 1
console.log(two); // 2
```

### Object Restructuring with ...Spread Operator

```js
let foo = { bar: 1 };

foo = {
  ...foo,
  zed: 15,
}

// foo = Object.assign({}, foo, { zed: 15 })

console.log(foo); // { bar: 1, zed: 15 }
```

### ...Rest Operator

```js
const foo = { bar: 1, zed: 15, three: 3, five: 5 };

const { bar, zed, ...numbers } = foo;

console.log(bar); // 1
console.log(zed); // 15
console.log(numbers) // { three: 3, five: 5 };
```