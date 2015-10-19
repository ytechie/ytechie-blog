---
layout: post
title: .NET XML DataSet Generator from a SQL Query
date: 2008-04-27
---

[As promised](http://www.ytechie.com/2008/04/dataset-xml-serializer-utility-for-unit-testing/), I've now made the [.NET XML DataSet Generator](http://code.google.com/p/queryxmldataset/) available on Google Code.

![.NET XML DataSet Generator](image1.png) 

If anyone can think of a better name for the project, please let me know! It's really hard to convey what it actually does. On the project page, I put these basic steps, which should help make it clear:

1.  Run this program to execute a SQL statement
2.  Copy the resulting XML into a file in your .NET unit test project
3.  Embed the XML file you created
4.  In your test code, load the embedded XML, deserialize it back into a DataSet (code coming soon)  

As the project matures a little bit, I'll have better documentation. I may even whip up a video demonstration. It's not really a fancy tool, but it does come in handy.

For example, let's say you have a database method that returns a DataSet containing a table of blog post items. You have another method that turns that DataSet into an array of post objects. I know that you're thinking you should normally use an [OR mapper](http://en.wikipedia.org/wiki/Object-relational_mapping), but this is just an example, so please don't interrupt me!. This tool lets you create a serialized DataSet that you can use in a unit test, which will reconstitute the DataSet into the exact same thing your database method would have returned. You can now pass in a snapshot of real data into the method your testing. If you ARE using an OR mapper like [NHibernate](http://www.hibernate.org/343.html), this probably won't happen much, but when it does, this tool will come in handy.