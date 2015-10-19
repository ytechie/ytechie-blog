---
layout: post
title: Response.Redirect and Output Caching Trouble
date: 2008-10-13
---

I ran into an interesting issue with output caching. If you have a page that uses output caching and that page **conditionally** sends a redirect response, you need to be careful.

![Redirect](redirect.jpg)

Let's say that you have a page that redirects to the mobile version of your website if they have a mobile browser. Let's suppose that you're using a standard, generic output caching directive:

	<%@ OutputCache Duration="300" VaryByParam="*" %>

When the page renders, the rendered HTML will be cached. The next incoming request will get the cached HTML, and the page rendering and code execution will be completely avoided. If you get a visitor that is using a mobile device, **your code to determine if the request should be redirected will never get executed**.

Here is another way to look at this scenario:

* **Request #1:** Page makes the decision to redirect to another page.
* **Result:** Page not cached.
* **Request #2:** Page makes the decision to render HTML.
* **Result:** This HTML is now rendered and cached.
* **Request #3:** **Doesn't matter.
* **Result:** The cached HTML from request #2 is rendered, even if the page should be redirecting.

There are a couple of workarounds to keep your redirects working:

### Turn off caching

Of course the simplest option is to simply turn of output caching for the page that needs to perform a conditional redirect. It goes without saying that you'll lose all the wonderful advantages of output caching.

### Use a caching seed

Another option is to write some code in your applications "`[GetVaryByCustomString](http://msdn.microsoft.com/en-us/library/system.web.httpapplication.getvarybycustomstring.aspx)`"; method that determines if it's a request that will be redirected. If so, a unique value is returned. This forces the page to re-render because it is not found in the page cache. Unfortunately, the code in your custom string method may get complicated very quickly.

If you're lucky, you'll be making the redirect decision based on something that can be automatically used to vary the output caching. For example, if your page redirects based on a URL parameter, you can simply use the `VaryByParam="*"` in your output cache directive (or specify the specific parameter). Keep in mind that each set of parameters supplied to the page will result in a separate cache entry. This could lead to excessive memory usage for some pages.

### Use fragment caching

Of course you could avoid using output caching on the page itself. You simply use the page as a place for your redirect logic, not the content generation. Then, put the actual page generation logic and content into a UserControl. When you use output caching on that control, it won't affect the redirect logic in the page. The disadvantage of this technique is that you may have to do extra work separating your content into controls. You also won't get the full benefit of caching since some of the control tree still needs to be processed, and some parts of the page such as the MasterPage will not get cached.

### Conclusion

Remember, this is only an issue if the page being cached makes a decision to redirect. If the page always performs a redirect, the page will not be cached (why are you using output caching then?). Obviously this issue isn't unique to Response.Redirect, but it is an issue you should be aware of.

One mischievous aspect of this issue is that if you test your site in a certain order, you won't see a problem. For example, if you first view the page under the circumstances needed to make it redirect, it will work. You'll only see the issue if you cause it to _not_ redirect, and _then_ try to get it to redirect.