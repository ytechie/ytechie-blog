---
layout: post
title: Removing duplicate page addresses in MVC
date: 2008-10-07
tags: ["asp.net","mvc","seo"]
---

As I mentioned before, there are a couple of SEO issues with MVC. I'll discuss two ways to get around the trailing slash issue. [Recall](http://www.ytechie.com/2008/10/aspnet-mvc-what-about-seo.html) what the issue was. MVC will happily serve up your URL's both with and without a trailing slash:

* www.test.com/path
* www.test.com/path/  

Search engines could potentially index both paths, and count them separately in their search results. The first solution is to make one of the versions return a 404 (page not found) response code. Hopefully, this would deter anyone from linking to the non-preferred version. We can do this by creating a custom route constraint, by implementing the **IRouteConstraint** interface:
  
	public class TrailingSlashConstraint : IRouteConstraint
	{
		private readonly bool _trailingSlash;
	
		public TrailingSlashConstraint(bool trailingSlash)
		{
			_trailingSlash = trailingSlash;
		}
	
		public bool Match(HttpContextBase httpContext, Route route, string parameterName,
			RouteValueDictionary values, RouteDirection routeDirection)
		{
			return _trailingSlash == httpContext.Request.Url.LocalPath.EndsWith("/");
		}
	}

Then, when you define the route, supply an instance of the constraint:

	routes.MapRoute("mobileVersion", "m",
		new { controller = "home", action = "mobile", id = "" },
		new TrailingSlashConstraint(false));

The second solution is to redirect the non-preferred version to the preferred version. We can do this by either creating a custom HTTP Module, or by using a canned product like the free [UrlRewriter.NET](http://urlrewriter.net/).

### Should I use a trailing slash or not?

This is one of the problems with MVC. In ASP.NET webforms, you could use a default page to avoid having to specify a file in the URL. This gets you the nice MVC style paths. The good part was that if someone accessed the version without a trailing slash, it would automatically redirect to the version with the trailing slash. So in ASP.NET WebForms, the trailing slash was obviously preferred since it was the default behavior.

Now, in ASP.NET MVC, they decided to make the default behavior the **opposite**. It does serve up both versions as I mentioned, but when it _generates_ links, they don't have a trailing slash.

If you're long term solution is to use MVC, I recommend dropping the trailing slashes, just to avoid the pain. I'm really hoping that by the time the final version of MVC comes out, they'll give us an option to define routes that should have a trailing slash.