---
layout: post
title: Speeding up your ASP.NET Application
date: 2008-05-05
tags: [software-development]
---

I read a post titled "[Improve Web Application Performance](http://dotnetslackers.com/articles/aspnet/ImproveWebApplicationPerformance.aspx)". I expected to have a lot of information to add, but it's actually pretty comprehensive. I recommend reading it if you're developing a web application. One of my biggest complaints about most websites is that they're **way** too slow. In this day and age there is really no reason for that.

![Analog Stopwatch](istock-000005198862xsmall.jpg)

The only other optimization I have used in the past that isn't mentioned in the post, is removing whitespace. While it can make your life a little harder because of some layout glitches it might cause (which are fixable), it can often have a pretty big effect on your page sizes. On one of my websites, I saw an average of a 10-20% decrease in page sizes, even when [gzip compression](http://www.microsoft.com/technet/prodtechnol/WindowsServer2003/Library/IIS/25d2170b-09c0-45fd-8da4-898cf9a7d568.mspx?mfr=true) was turned on.

The easiest way to remove whitespace from your pages is to use an HTTP module. One solution is [available here for free](http://blog.madskristensen.dk/post/A-whitespace-removal-HTTP-module-for-ASPNET-20.aspx). You simply add the binary DLL, and reference it in your web.config file. It couldn't hurt to give it a try the next time you're writing an ASP.NET application.