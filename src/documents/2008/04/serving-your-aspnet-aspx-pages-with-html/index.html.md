---
layout: post
title: Serving your ASP.NET .aspx pages with .html
date: 2008-04-24
tags: ["asp.net"]
---

Many SEO experts believe that Google prefers pages that end with the &quot;html&quot; extension. I'm guessing it has to do with the fact that static content is favored, because it is less commonly spammed. Even if Google doesn't actually look at the extension, you certainly won't be penalized for using the &quot;html&quot; extension.

![carrying www](carrying-www.png) 

To support a custom extension, my first thought was to put the following code in my web.config:
  <pre class="xml" name="code">&lt;compilation&gt;
&lt;buildProviders&gt;
&lt;add extension=&quot;.html&quot; type=&quot;System.Web.Compilation.PageBuildProvider&quot; /&gt;
&lt;/buildProviders&gt;
&lt;/compilation&gt;</pre>

This wouldn't be a bad way to do it, if not for the fact that [ReSharper](http://www.jetbrains.com/resharper/) doesn't like code for non-aspx files. I'm speculating that you may run into problems with other Visual Studio add-ins.

The alternative to use Server.Transfer by intercepting the requests, and transferring them to the correct page for processing.

Here is a basic example of an IHttpModule that will do the rewriting. I offer no guarantees with this code. In fact, I don't use it anywhere in production (we use a full blown rewriter solution):

<pre class="c-sharp" name="code">public class HtmlUrlRewriter : IHttpModule
{
  private HttpApplication _context;
  private void context_BeginRequest(object sender, EventArgs e)
  {
      string path;
      path = _context.Request.Path;
      if (path.EndsWith(&quot;html&quot;, true, CultureInfo.CurrentCulture))
          _context.Server.Transfer(RewriteUri(_context.Request.Url).PathAndQuery);
  }
  public static Uri RewriteUri(Uri uri)
  {
      UriBuilder newUri;
      newUri = new UriBuilder(uri);
      newUri.Path = newUri.Path.Replace(&quot;.html&quot;, &quot;.aspx&quot;);
      return newUri.Uri;
  }
  #region IHttpModule Members
  public void Init(HttpApplication context)
  {
      _context = context;
      context.BeginRequest += context_BeginRequest;
  }
  public void Dispose()
  {
  }
  #endregion
}</pre>

Of course you'll probably have other types of requests that you are going to be rewriting, so I recommend coming up with a URL rewriter framework, or use one of the third party options that are available.

One last note. Before IIS will allow ASP.NET to handle the processing of html files, you need to add an application extension mapping. [More information about configuring IIS mappings is available here](http://aspnet.4guysfromrolla.com/articles/011404-1.aspx).

[Obishawn](http://blog.obishawn.com/) also has some more information about [URL rewriting and postbacks](http://blog.obishawn.com/2008/04/url-rewriting-and-postbacks.html) on his blog.