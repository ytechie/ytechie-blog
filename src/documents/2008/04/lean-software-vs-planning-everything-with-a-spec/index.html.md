---
layout: post
title: LEAN software vs planning everything with a spec
date: 2008-04-22
---

Every since reading [Joel's](http://www.joelonsoftware.com/) article "[Painless functional specifications - Part 1: Why Bother](http://joelonsoftware.com/articles/fog0000000036.html)?", I've be a big fan of writing functional specs. I've done it for a few projects, and I've encouraged others to do the same. The biggest reason is to solve problems ahead of time, instead of waiting last minute.

Then, I start reading about the [LEAN philosophy](http://en.wikipedia.org/wiki/Lean_software_development), and it's telling me to not plan anything, do what you need to do, and change as the customer makes requests, or as you learn what the project really needs. What??? How the heck is that supposed to work.

![Thinking](woman-thinking.png) 

I think the answer is a hybrid approach. Write your spec document, but don't try to design your entire program before writing any code. Solve the overall issues that you know need to be solved, and also plan any features that you are absolutely sure you will need. The spec document should be a snapshot of the bare bones version of what the software needs to look like.

The problem with Joel's approach is that it assumes that the customer won't change their mind, and if they do, they'll be able to get all of it out of the way **before** any code is written.

I'll give you a real life example of a project I'm working on. The project was extremely rushed to get the first version out the door. Because of a lack of planning (I wish we had a spec!), we had to throw a lot of our work away and start over.

The lesson learned was that we needed better planning.

However, once the site was live, we realized that we didn't really understand what the customer wanted. We needed to look through our statistics and get customer feedback before we could attempt to plan future features. The result is that we try to **plan our features** is detail, but we meet every week to prioritize them.

If we were to formally plan the next version of the site, and then code it for a month, I believe the results would be a disaster. Because we are constantly learning, we need to be able to adapt to changing conditions quickly.

If we were to plan another major release of the site, I would advocate creating a detailed spec, but try to minimize the size of the release as much as possible. Release early, and release often.

I know that Joel is against the "release early, release often" mindset. The truth is, it highly depends on what kind of software you're writing. Joel is writing Fogbugz, which is already very popular, and has a great set of features. They can afford to take their time, and they probably have a good understanding of what the customer wants. If you're not as fortunate, you may just have to put something out there that isn't perfect, learn what users want, and adapt quickly.