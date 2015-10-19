---
layout: post
title: Converted my blog from Blogger to Wordpress
date: 2008-04-26
---

Well I did it. I actually really liked using [Blogger](http://www.blogger.com), and I had finally gotten my blog set up the way I liked. However, I just wanted a little more. I evaluated a couple of different solutions (including [Subtext](http://subtextproject.com/), which I use on my [personal blog](http://www.superjason.com)), and I decided to go with [WordPress](http://wordpress.org/) (the software, not the hosted service).

![WordPress Logo](image.png)

First off, I wanted to be able to have a little more control over some SEO aspects of my blog, such as using a robots.txt. The [all in one SEO pack](http://wp.uberdose.com/2007/03/24/all-in-one-seo-pack/) Wordpress plug-in seems to handle many of my requirements. Unlike Blogger, a lot of the non-content pages won't get indexed now (a good thing). See "[Avoiding duplicate content with your site](http://www.ytechie.com/2008/04/avoiding-duplicate-content-with-your-site-or-blog/)" for more information.

I also wanted to use the Apache [mod_rewrite](http://httpd.apache.org/docs/1.3/mod/mod_rewrite.html) functionality, which is really an amazing tool. For example, I'm doing 301 redirects on all of the old Blogger archive pages, to the equivalent Wordpress archive URL's.
<pre class="c-sharp">RewriteRule ^([d]{4})_([d]{2})_[d]{2}_archive.html$ /$1/$2 [R=301,L]</pre>
I also set up the [Google Analtyics Plugin](http://xavisys.com/wordpress-google-analytics-plugin/), which sets up some pretty neat tracking features. It's even supposed to track outgoing links, but it isn't working for me for some reason. I'll be checking with the author.

Overall, I'm very happy with the Wordpress platform. It's very simple and simply works like I would expect. Since it's one of the most popular blogging platforms, I know that support is just a Google away, and bugs shouldn't stay around too long. I also know that I can easily extend its functionality, or at least add content.

I'm hosting it on my dedicated server under [Xampp](http://www.apachefriends.org/en/xampp.html). Installation of [Apache](http://www.apache.org/), [MySql](http://www.mysql.com/), and Wordpress couldn't be easier. In fact, I had it up and running in about 10 minutes. The performance seems pretty good compared to Blogger. There are a lot less files being downloaded, which should really help. I also plan to enable gzip compression for some more speed, and I would like to get a caching plugin to avoid constant page regeneration.

Let me know what you think of the new site, and my new theme!

PS. Sorry to my RSS subscribers. When I switched to Wordpress, [the RSS feed](http://feeds.feedburner.com/ytechie) shows the posts as all being new.