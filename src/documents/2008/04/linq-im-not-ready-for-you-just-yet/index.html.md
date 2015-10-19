---
layout: post
title: LINQ, I'm not ready for you just yet
date: 2008-04-28
---

Today I was between features on the current project I'm working on, so I had some free time start researching some technologies I've been meaning to learn and start using. The topics at the top of my learning list are [LINQ](http://msdn2.microsoft.com/en-us/netframework/aa904594.aspx) and [MVC](http://weblogs.asp.net/scottgu/archive/2007/10/14/asp-net-mvc-framework.aspx). I gave LINQ a few months to mature, so I figured it was a good time to investigate.

![Boy Crying](boy-crying.jpg) 

(there is no emoticon to express my anger!)

The picture above shows how I felt when I started writing my first LINQ expression. The biggest problem was the fact that the latest version of [ReSharper](http://www.jetbrains.com/resharper/download/new-VS-support.html) doesn't support any .NET 3.0+ language features. Not only does it not support LINQ, it's IntelliSense severely interrupts you while writing it. So much so that it makes it unusable.

I went ahead and downloaded the latest development build (Build 783). On their [download page](http://www.jetbrains.net/confluence/display/ReSharper/ReSharper+4.0+Nightly+Builds), it's listed as &quot;Works here&quot;. That wasn't encouraging. It does work a little better with LINQ, but it's still a steaming pile of you know what (dog poop for the not-so-smart). This further reinforces my love/hate relationship with ReSharper.

Anyway, I was eventually able to write some LINQ code. A great tool to get started is [LinqPad](http://www.linqpad.net/), which is basically a query analyzer but with LINQ expressions. Writing LINQ is very difficult with a SQL background, because everything is backwards. You think you know what you're doing, but you don't.

Right now, we're using [NHibernate](http://www.hibernate.org/343.html) in the main project that I've been working on for the past couple of months. It's amazing, but there are a couple of things that would be nice:

*   Better optimization of queries - It looks like LINQ does an amazing job with this.
*   Batched reads & writes - LINQ does batched writes, but lazy loading by default. Maybe not as big a deal as I think.
*   Cross session saving - I spent hours battling with some code that loaded a complex object with relationships in one session, and then saved them in another. It appears that LINQ solves this, but I'll have to run some tests to be sure.
*   Less work generating mapping files and relationships.  

One thing that is nice about LINQ to objects is the fact that it will generate all of the model classes, plus the glue that connects the model to the database. You can either use Visual Studio and drop the tables into a mapping file, or you can use [SqlMetal](http://msdn2.microsoft.com/en-us/library/bb386987.aspx) to script the class generation.

One of the biggest questions I'm trying to answer write now, is how unit testing fits in with LINQ. We're currently testing our data access layer by using an in memory [SQLite](http://www.sqlite.org/) database, which let's us perform [close to real world saves and loads](http://www.ayende.com/Blog/archive/2006/10/14/7183.aspx). We also use interfaces for our data access methods, which makes it easy to create testable classes that can simply be supplied a database interface.

I'm also not sure if it even makes sense to put my LINQ queries in a data access layer. The code would almost seem trivial, and would just create a lack of flexibility. Ironically, it _almost_ feels like you should use LINQ to query _against_ your data access layer.

For now, there are more questions than answers. For now, I don't plan on retrofitting my last project with LINQ, but I'm going to investigate if it will be a good foundation for the data access logic in my next project. Of course if I go that route, you'll be sure to hear about it!