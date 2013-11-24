---
layout: post
title: ASP.NET output caching by user agent
date: 2008-04-14
---

I received this question from [ObiShawn](http://www.Obishawn.com):

&quot;Does .NET/IIS output caching vary by user-agent?&quot;

Good question Shawn! By default, the output cache stores the same version of the page for all users, **regardless** of their user agent. To change this behavior, add the [VaryByHeader](http://msdn2.microsoft.com/en-us/library/system.web.ui.outputcacheparameters.varybyheader.aspx) parameter to your OutputCache declaration:
  <pre class="xml" name="code">&lt;%@ OutputCache Duration=&quot;60&quot; VaryByParam=&quot;*&quot; VaryByHeader=&quot;User-Agent&quot;  %&gt;</pre>

This is probably a good idea to include in your OutputCache directive, because ASP.NET will [render controls differently to some browsers](http://msdn2.microsoft.com/en-us/library/x3k2ssx2(VS.80).aspx). It modify the output HTML based on the browsers capabilities. 

If your site is only targeting the latest generation of browser, you can probably avoid varying by user agent. 

One last note. You can include multiple headers in the VaryByHeader parameter. Simply separate them with semi-colons. 

For more information about OutputCaching, [this is a great article](http://aspnet.4guysfromrolla.com/articles/022802-1.aspx).