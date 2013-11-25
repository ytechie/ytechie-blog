---
layout: post
title: ASP.NET LinkButton and SEO
date: 2008-04-07
tags: ["asp.net","seo"]
---

A common question that comes up, is what do [LinkButton's](http://msdn2.microsoft.com/en-us/library/system.web.ui.webcontrols.linkbutton.aspx) do for [SEO](http://en.wikipedia.org/wiki/Search_engine_optimization) (Search Engine Optimization)? Well, let's take a look what a LinkButton actually renders for HTML:

	<a href="javascript:__doPostBack('ctl01','')">Click me!</a>

Notice that it's simply a standard hyperlink with a JavaScript call. Typically, the search engines are only going to look at your HTML. They're not going to evaluate the JavaScript. Doing so would be a big can of worms.

![WWW Web](www-web.png) 

So basically, the LinkButton is going to be **invisible** to the search engines. At most, they might look at the words in the link text, and consider them as part of the rest of the content.

Remember, the purpose of the LinkButton to be a replacement for the ASP.NET Button control, but with the look of a hyperlink.