---
layout: post
title: ASP.NET MVC, What about SEO?
date: 2008-10-01
---

I've started working the the latest preview of the ASP.NET MVC framework. I'm completely converting one of my sites, because learning by _doing _is typically the best way. Unfortunately, I've run into some alarming SEO (Search Engine Optimization) issues with this new paradigm (or more specifically, the Microsoft implementation).

![Duplicate Ducks!](istock-000006003382xsmall-thumb.jpg)

### Duplicate Content

[Duplicate content](http://www.webconfs.com/duplicate-content-filter-article-1.php) is a major issue. If a search engine (Google, which we're primarily concerned with) finds multiple identical pages, it could be seen as a spam technique. Google likes original content, and penalizes duplicate content.

The problem is that the ASP.NET MVC default routing is too forgiving. If I have a page with this address: "/controller/action/id", the routing engine happily serves it up at "/controller/action/id/". There is no reason to not be strict on this. In ASP.NET WebForms, if you forget the trailing slash, it will automatically perform a 301 (permanent) redirect to the version with the trailing slash.

ASP.NET MVC has a bug (I'm calling it that) that won't let you define a URL as requiring a trailing slash. Below, I've defined a route as a sample. In the URL to match, I have a trailing slash. In the routing code, the trailing slash is removed when it's added to the routing table. This also has the side-effect of _generating_ the URL's _without_ a trailing slash.

	routes.MapRoute(
		"Legacy-Firefox",
		"Firefox-Extension/",
		new { controller = "Home", action = "Firefox", id = "" } );

Since routes can be configured to reuse actions and controllers, it makes more paths to follow. If I again use the route defined above, I end up with all of these valid addresses that could potentially be linked to and indexed:

* a.com/Firefox-Extension
* a.com/Firefox-Extension/
* a.com/Home/Firefox
* a.com/Home/Firefox/
* a.com/Home/Firefox/anythingyouwant

**If you're lucky,** Google won't penalize duplicate content. However, if Google indexes the same content using multiple URL's, you won't get the benefit of focusing the PageRank. A similar situation occurs with you have a site that can be addressed like "cnn.com" and "www.cnn.com". They counted as separate pages, that end up competing for good rank.

### Legacy URL's

I'm sure there is a large group of people that are anxiously awaiting to take advantage of the new MVC style development. Many of them will undoubtedly have existing URL's they want to preserve.

There are a couple of ways to handle this issue. The search engines would prefer that your URL's simply remain the same. This is possible, but requires some fancy routing. The SEO community highly recommends this approach (with good cause).

Another way to handle it is to adopt the new REST style URL's that typically make the most sense with an MVC approach: "/controller/action/id". Then, setup 301 redirects from the old addresses to the new one's. [This article](http://blog.eworldui.net/post/2008/04/ASPNET-MVC---Legacy-Url-Routing.aspx) discusses the technical details. In theory, this should be the best scenario. However, Google themselves say to get the incoming links pointed to the new addresses ASAP. The truth is, this solution sucks. I've actually done this with a site. It was search engine suicide for a couple of months. I eventually got my old position back, **but lost a significant amount of revenue because of it**.

Yet another way that I found is to set up multiple routes so that the content is accessible with both the old and new addresses. If you've been paying attention, you'll know that this counts as duplicate content, and is **very, very bad**. I was in shock when [I found this approach being advocated](http://www.dimecasts.net/Casts/CastDetails/11).

### Conclusion

I'm not saying the routing system is completely wrong, I just think it would be set up so that the easy way of migrating a site is the correct way, or as close to it as possible. I don't want to have to write custom routing. At the very least, come up with a way to designate that a particular action has a single path (and cancel out additional paths in other routes). It would also be nice if there was a way to use the old style urlMapping section in the web.config for legacy URL's.

If I'm completely wrong about how the routing works, let me know. It's difficult to find good information (which is understandable right now), and I'm admittedly still in an early learning stage.