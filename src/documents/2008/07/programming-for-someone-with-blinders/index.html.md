---
layout: post
title: Programming for someone with blinders
date: 2008-07-22
tags: ["productivity","software development"]
---

One of your goals as a developer should be to make your code as readable as possible, both for yourself, and for the other developers you work with.

[![Horse with Blinders](image-thumb.png)](http://www.ytechie.com/post-images/2008/07/image9.png) 

One great way to determine if your code is well written, is to ask yourself if the code you're writing is readable by itself. Another developer should be able to jump into a module, and have a fairly easy time seeing what's going on. They shouldn't have to sift through thousands of lines of interweaved code to figure out what's going on.

Of course, what I'm talking about is simply a test for the [single responsibility principle](http://en.wikipedia.org/wiki/Single_responsibility_principle). If you've written a huge &quot;do it all&quot; class with thousands of lines of code, you're ensuring that you're the only one that will be able to maintain it. That that type of code usually suffers from [high coupling](http://en.wikipedia.org/wiki/Coupling_(computer_science)#Low_coupling) to the other modules in the program.

I used to organize code into classes based on the type of functionality being provided. I used them more as containers for related functionality. At the time, I didn't see a reason to split it apart. _I was very wrong_.

In a recent article by Jimmy Bogard, he walks through [creating classes with a separation of concerns](http://www.lostechies.com/blogs/jimmy_bogard/archive/2008/07/17/separation-of-concerns-by-example-part-5.aspx). In the conclusion is my favorite part:
  > Now we have many more classes (4 vs. 1) and interfaces (3 vs. 0).&#160; For those who don't like more classes, GET OVER IT.  

That is an excellent point. Why should you be afraid of creating more classes and interfaces? It's really not more code to write, in fact, it's often less. Refactoring tools remove many of the obstacles of maintaining the interface, class, and method structure 

When someone looks at your code and you have 4 classes instead of 1, and those classes are very specific and short enough to process by our tiny brains, it will be much easier to maintain and modify (or even better, extend).