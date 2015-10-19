---
layout: post
title: Removing rules="all" from the rendered table from a GridView
date: 2008-04-04
---

By default, the ASP.NET GridView control adds **rules="all"** to its generated table HTML. It might not be terribly obvious how to remove it. I struggled for quite some time adding "border: none;" everywhere in my stylesheet, which wouldn't remove the lines between the rows. Here is a sample:

![Gridview Border Example](gridview-lines.png) 

The answer is to simply use **GridLines="None"** to the GridView declaration.