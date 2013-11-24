---
layout: post
title: Understanding LINQ and LINQ to SQL (and EF)
date: 2009-09-17
tags: [".net","c#","entity framwork","LINQ"]
---

Back to basics for this post. Developers often throw around the word LINQ when talking about a number of different technologies. Now that I have been comfortably using a wide variety of LINQ technologies for a fair amount of time, I'm now able to convey some of the key differences that are critical to using LINQ technologies efficiently. I'm also using this as a foundation and reference for some exciting upcoming posts.

The first key point is to know what the heck LINQ is. LINQ itself is a number of separate features. One of these key features is being able to write SQL-like syntax (query syntax) in your code. At a basic level, that's all you need to know for now.

**LINQ (to objects)**

First, we're going to talk about LINQ to objects, which I typically just refer to as LINQ (possibly making the matter more confusing). It has absolutely nothing to do with SQL Server, Oracle, or any other kind of relational database. I'm talking about LINQ to objects, because I think that understanding it and contrasting it with LINQ to SQL is critical to understanding both.

For a moment, forget that LINQ exists. Let's say that you wanted to filter a list of names, to only get names that start with the letter "J". You could write the following "utility" function: (if you don't understand ["yield return", see this post on that topic](http://www.ytechie.com/2009/02/using-c-yield-for-readability-and-performance.html)).
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:74dcd1eb-c170-4d76-b6e8-441fc9f40dba" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public static IEnumerable&lt;string&gt; GetNamesStartingWithJ(IEnumerable&lt;string&gt; names)
{
    foreach(var name in names)
        if(name.StartsWith("J"))
            yield return name;
}</pre></div>

A new feature in C# introduced in .NET 3.0, is a concept known as an extension method. This lets us turn my handy dandy static utility method into a method that can be called on a list of names. By changing the signature to this:

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b27c9cbc-7f0a-4fb5-be05-8f5946380254" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public static IEnumerable&lt;string&gt; GetNamesStartingWithJ(this IEnumerable&lt;string&gt; names)</pre></div>

I can then call it like this (Sweet!):

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:9b70c490-45ef-40a4-903b-4cbd3b3470ed" class="wlWriterEditableSmartContent"><pre name="code" class="c#">var myListOfNames = new List&lt;T&gt; {"Abe", "Jack", "Jason"};
var jNames = myListOfNames.GetNamesStartingWithJ();</pre></div>

We haven't even talked about LINQ yet, but we've basically reinvented a portion of it. As an exercise for the reader, think about how you could use a Lambda parameter to pass in a filter criteria to create a &quot;.Where" method. All the pieces are in place to re-create this form of LINQ yourself.

One actual new feature for LINQ is known as query syntax. Basically, it gives us an alternative way to write our query. It makes the code look more like SQL, and less like a long chain of extension methods.

Lambda Syntax:

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a76b3655-6a72-4fa3-b147-38bfd8dedf80" class="wlWriterEditableSmartContent"><pre name="code" class="c#">var uppercaseJNames = names.Where(name =&gt; name.StartsWith("J")).Select(name =&gt; name.ToUpper());</pre></div>

Query Syntax (same query):

  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:7e10587a-ba5f-4062-bba8-cab816b7eb3e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">var uppercaseJNames = from name in names
	where name.StartsWith("J")
	select name.ToUpper();</pre></div>

In both of those examples, the exact same operations are occurring, and you get the result. The one you choose will most likely come down to personal preference. It's also worth noting that some of the extension methods provided out of the box are not available in query syntax. You can either avoid the query syntax in those cases, or use a hybrid approach.

**How is LINQ to SQL (and Entity Framework, etc) Different?**

Now, I hope you understand that there isn't really any magic going on in LINQ. Microsoft has simply given us a new set of easy to use tools that make working with sets a breeze.

LINQ to SQL is a different matter. Instead of executing code, you're building an expression. An expression is simply a "picture" of what you're trying to accomplish. It can interpreted in many different ways. To understand the underlying technology, you'll have to read up on expression trees, which I'm intentionally keeping outside the scope of this post.

If we have a "picture" of a query, what happens to it when we want to "run" it? LINQ to SQL, Entity Framework, and other LINQ implementations look at your query, and basically translate it into something else. How about an example?:

  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:fc8658fb-f565-47dc-af0c-f5c4007c3a89" class="wlWriterEditableSmartContent"><pre name="code" class="c#">//Query Syntax
var deviceIds = from device in Devices
where device.Type == "I"
select device.DeviceId

//Lambda Sytax (extension methods)
var deviceIds = Devices
   .Where (device =&gt; (device.Type == "I"))
   .Select (device =&gt; device.DeviceId)

//SQL
SELECT [t0].[DeviceId]
FROM [Devices] AS [t0]
WHERE [t0].[Type] = "I"</pre></div>

I've provided the query syntax and the lambda syntax. At the bottom is the resulting translation into a SQL statement.

In this last example, I'll try to make it clear that your code is simply interpreted and translated:

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:a87dc611-83a7-4e29-ad97-f2b3ecff5f57" class="wlWriterEditableSmartContent"><pre name="code" class="c#">//Query Syntax:
from device in Devices
where device.Type != null
select device.DeviceId

//SQL Syntax:
SELECT [t0].[DeviceId]
FROM [Devices] AS [t0]
WHERE [t0].[Type] IS NOT NULL</pre></div>

Notice that the C# operator "!=" translates in SQL to "IS NOT NULL". This was handled automatically for us. Our expression did NOT get back all the rows and apply a conditional to it.

Why is this important? To use either technology effectively, you have to understand that when you're working with objects, it's simply a chain of methods, and often behaves as you would expect. When working with LINQ to SQL (or a related technology), the expression is evaluated, and might not execute like you expected.

Understanding the internal workings of these technologies will let us fully take advantage of all the wonderful features it has to offer. In upcoming posts, I'll be warning you of some potential pitfalls related to how your queries are interpreted and translated. I'll also be showing you how to get significant performance gains by using LINQ to SQL or Entity Framework efficiently (over traditional SQL based solutions). I'll also be showing you how I write LINQ queries to query an AutoCAD document!

Related Posts:

*   [Using Yield Return for readability and performance](http://www.ytechie.com/2009/02/using-c-yield-for-readability-and-performance.html)
*   [Using "var" to simplify code and avoid redundancy](http://www.ytechie.com/2008/06/using-var-to-simplify-code-and-avoid-redundancy.html)