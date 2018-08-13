---
layout: post
title:  "Concevoir une API RESTful"
excerpt: "-- todo --"
background: '/img/posts/covers/bem.jpg'
comments: true
tags: html css bem
image: '/img/posts/covers/bem.jpg'
---

# Concevoir une API RESTful

Pour communiquer entre elles, les applications ont besoin d'un support **basé généralement sur HTTP**. C'est une qu'on appelle **une API** ou **un webservice**.

C'est en 2000 que Roy Fielding créé le **standard REST** afin de **normaliser de manière simple ces APIs**. Cette norme est basée sur 4 niveaux souvent appelés "[Glory of REST](https://martinfowler.com/articles/richardsonMaturityModel.html)".

Voyons comment cela se présente.

## Les ressources

La norme REST est avant tout **basé sur les ressources**. C'est à dire que chaque URI correspond à une ressource de notre système et non une action. Il faut donc savoir ce qu'est une ressource dans mon projet.

Il y a deux types de resources, les entités et les collections d'entités.

Par exemple, si je veux créer une API permettant de gérer une bibliothèque musicale. Mes ressources seront donc : les albums, les artistes et les pistes.

Ma collection d'album sera

