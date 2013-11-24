---
layout: post
title: Software is hard!
date: 2008-05-23
tags: ["productivity","software development"]
---

Not too long ago, I was telling my uncle about an e-commerce site that a coworker and I were able to develop in about 4 months. I was shocked at his next query:
  > What is so hard about that? Why did it take so long?  

What??? I write thousands of lines of code over dozens of pages, and you don't get it? In a way, that means the software was successful. Often, the simpler the end result, the more code it takes to achieve that simplicity. Most users are completely oblivious to what it takes to create something that actually works.

&#160;![Frustrated Developer](image8.png) 

Windows has over [50 million lines of code, which was written by over 5000 developers](http://www.winsupersite.com/reviews/winserver2k3_gold2.asp). I've heard that NASA spends over $10,000 per line of production code.

So why IS software so hard? It usually requires the entire mental ability of a software developer. In a given day, one would surely exercise their entire brain.

To write a feature, here is just a fraction of what must be considered:

*   Software creation is art and science. You must be creative, imaginative, logical, talented, and knowledgeable.*   Layer synchronization - Data gets passed up and down between layers, and they all need to agree on how they will call other functionality, as well as how they need to be called. Decisions need also be made to determine if and where data will be validated.*   Failure modes must be considered - For every line of code, there needs to plan to handle that failure.*   Affected code needs to be evaluated - Ever heard the line &quot;this is a small change, it won't break anything&quot;. I'm not falling for that one again. It's like changing out a block at the base of a pyramid.*   A testing strategy needs to be formulated - Unit tests need to test the new code, and acceptance tests need to test the new functionality*   More code must be maintained - Every line of code you write counts toward the theoretical maximum number of lines of code that you can realistically maintain.*   Consider performance and memory - The questions in this area are virtually endless, and the answers might not come easy. Compromise is inevitable.*   Technology considerations - How much does the target platform vary? What technologies will work, and which ones are the best?*   Balance modularity and simplicity - Sometimes they go hand in hand, sometimes they're a tradeoff.*   Balance the needs of the present with the needs of the future - Try not to play the [&quot;What If?&quot;](http://www.ytechie.com/2008/05/dont-play-the-what-if-game.html) game, but at the same time, don't be ignorant of the future.*   Many companies have cross functional teams that developers must report to. Instead of having a manager that feeds a developer their work, now you have multiple sources that are asking for conflicting information. So much for a [developer abstraction layer](http://www.joelonsoftware.com/articles/DevelopmentAbstraction.html).*   You're not the only developer - You need to be cooperative and collaborative to simplify the integration of your code.  

Nothing is ever as simple as it seems. _You're not going to piece together code snippets from the web and create a great product_.