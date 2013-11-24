---
layout: post
title: Don't play the "What If" game
date: 2008-05-14
tags: ["productivity","software development"]
---

One of the biggest traps I've seen developers fall into is what I like to call the &quot;What If&quot; game:

*   &quot;Make your ID columns integers&quot;, &quot;But **what if** we want them to contain a letter eventually?*   &quot;Let's cook these 10 steaks&quot;, &quot;But **what if **100 people show up?&quot;*   &quot;Let's go to the park&quot;, &quot;**What if** we get sick?&quot;  

The &quot;what if&quot; game consists of over thinking your plan. Planning in general is obviously essential. However, I've seen an alarming rate of crippling fear. Fear to write any code because it will never possibly handle all possible scenarios. It ends up being a self fulfilling prophecy of failure.

Sometimes the side effect isn't just a fear to write code. It often leads to code that is generic beyond usefulness. For example, a database with all columns being VARCHAR(MAX).

![](chart?chs=225x125&amp;cht=gom&amp;chd=t:50&amp;chl=Useful) 

Specialization is basically a spectrum. At one end, we have code that is so specialized that it is basically un-reusable. At the other end, the end I'm talking about, we have code that can be used everywhere, but doesn't really do anything.

Some of the hardest decisions we have to make as developers are related to whether we base our decisions on the present, or a potential future that has a variable amount of certainty.

I'm not saying that you should avoid planning, but your decisions need to be based on the real likelihood that changes will need to be made later. An ounce of prevention is worth a pound of cure, but 64 ounces of prevention is certainly not worth a pound of cure!