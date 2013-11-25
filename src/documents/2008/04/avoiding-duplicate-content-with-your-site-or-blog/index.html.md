---
layout: post
title: Avoiding duplicate content with your site or blog
date: 2008-04-18
tags: ["blogger","seo"]
---

One of the most important rules in SEO (Search engine optimization) is avoiding duplicate content. Google has some [information on their page](http://www.google.com/support/webmasters/bin/answer.py?answer=66359) about how they handle duplicate content. Unfortunately, the Googlebot is rarely smart enough to know which content is original. Google wants to avoid users that copy and/or republish someone else's work simply to get content for their site.

You also want Google find pages on your site that have substance, and that are not just a copy of content from one of your other pages.

![printer](printer.png) 

So how do you avoid it on your site? The first step is to identify potential pages that have duplicate content. It's probably happening without you even being aware of it.

Type this into Google: site:http://www.**yoursite**.com

I'm using blogger, and by default here are some pages that are indexed that should not be:

* http://www.ytechie.com/2008/04/aspnet-linkbutton-and-seo.html?widgetType=BlogArchive&widgetId=BlogArchive1&amp;action=toggle&amp;dir=close&amp;toggle=YEARLY-1199167200000&amp;toggleopen=MONTHLY-1207026000000
* http://www.ytechie.com/2008_03_01_archive.html 

Now that we've identified the offending pages, we can create or modify our **robots.txt** file, at the root of our site.

Here is what I could add to my robots.txt to block those pages:
<pre class="csharpcode">Disallow: /*?
Disallow: /*_archive.html$</pre>

Once you've updated your robots.txt file, you can use the [Google webmaster tools to test it](http://www.google.com/support/webmasters/bin/answer.py?hl=en&amp;answer=35237). For more information on how to edit your robots file, including syntax, [consult Google](http://www.google.com/support/webmasters/bin/answer.py?answer=40360&amp;ctx=related).

There is one big problem. If you're using a service like Blogger (like this blog), you can't edit your robots file. There has been talk of adding support, but we have to deal with what is available.

The best I've been able to come up with, is adding this into the head (look for <head>) of my template code:

<span class="kwrd">&lt;</span><span class="html">b:if</span> <span class="attr">cond</span>='<span class="attr">data:blog</span>.<span class="attr">pageType</span> == <span class="kwrd">"archive"</span><span class="kwrd">&gt;</span>
 <span class="kwrd">&lt;</span><span class="html">meta</span> <span class="attr">name</span><span class="kwrd">="robots"</span> <span class="attr">content</span><span class="kwrd">="noindex, nofollow"</span> <span class="kwrd">/&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">b:if</span><span class="kwrd">&gt;</span></pre>

This adds a noindex and nofollow meta tag to the generated archive pages. I have not yet figured out how to remove pages that contain parameters (?param=value). If anyone has a way to do it, please let me know! I've actually been considering removing the archive widget to solve it.