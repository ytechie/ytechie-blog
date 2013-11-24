---
layout: post
title: Subtext blog platform feature requests
date: 2008-04-30
tags: ["blogging"]
---

For this blog, I'm currently using [WordPress](http://wordpress.org/). For my [personal blog](http://www.superjason.com), I chose to use [SubText](http://subtextproject.com/). SubText is an ASP.NET based installable blogging platform that was originally based on the [.Text](http://scottwater.com/blog/pages/dottext/) source code. I initially tried to stay with a .NET based solution, so that I would be able to fix it if something went wrong.

It's a great platform, and I have few complaints. It's simple, and it does its job extremely well. I do however, have some suggestions (if they're not already in there).

![image](image2.png) 

**Output Caching** - For low traffic sites, this doesn't really make a difference. What I am concerned with is the chance that my site could end up on the front page of [Slashdot](http://www.slashdot.org) or [Digg](http://www.digg.com). The only hope of survival is output caching. Even caching for 30 seconds could make a huge difference.

As an extra bonus, a [SQL dependency](http://davidhayden.com/blog/dave/archive/2006/04/29/2929.aspx) cache could be used so that changes still show up immediately.

**Meta Description** - The keywords are not very important, but it would be nice to have a nice meta description. Google usually DOES use the meta description tag if you supply one.The all-in-one seo pack for Wordpress works pretty slick, because it gives you a place to change all of your SEO settings.

**301 Redirects for non-standard URL's** - Many of the search spiders are not very intelligent. It would be nice if the URL's were forced to be a certain pattern. For example, if someone links to superjason.com instead of [www.superjason.com](http://www.superjason.com), it doesn't get redirected. That means that the search engines will potentially index both. The same goes for the capitalization of the post names. I would like it to redirect to the all lower case version of the URL's.

**NoFollow, NoIndex** - It would be nice if a lot of the architecture pages (categories, archives, tags), were marked as NoIndex. It would also be nice if links to those pages were marked as NoFollow for safety. There's no reason to pass on your PageRank to pages without any unique content. There is also no reason for them to show up in the search engines.

**HTML Cleanup** - This feature is much less important to me. It would be neat to use [HTML Tidy](http://www.w3.org/People/Raggett/tidy/) to clean up the HTML if it's malformed. I used to write my post HTML by hand until [Windows Live Writer](http://windowslivewriter.spaces.live.com) matured.

I do, however, have lots of old posts that have potentially malformed HTML. My plan is to eventually write a utility that will clean them up.

I've been seriously contemplating converting it to Wordpress. It's nice being on one of the most popular platform. The fact that I can use add-ons to make it exactly what I want is certainly a plus.

Let's see what you can do Subtext!