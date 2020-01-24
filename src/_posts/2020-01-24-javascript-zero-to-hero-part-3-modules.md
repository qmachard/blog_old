---
layout: post
title:  "Javascript from Zero to Hero - Part. 3 - Modules"
excerpt: "Les modules Javascript, import et export"
background: '/img/posts/covers/js.jpg'
comments: true
tags: javascript
image: '/img/posts/covers/js.jpg'
---

# Javascript from Zero to Hero - Part. 3 - Modules

## Multiple Named Export

```js
// utils.js
export const square = x => {
    return x * x;
}

export const add = (x, y) => {
    return x + y;
}

// main.js
import { square, add } from './utils.js';

console.log(square(2)); // 4
console.log(add(4, 5)); // 9
```

## Single Export  / Default Export

```js
// square.js
export default function() {
    console.log('Foo!');
}

// main.js
import someName from './foo.js';

someName(); // Foo!
```