---
layout: post
title: Cloud Computing (and Azure) - Right for your site?
date: 2008-11-11
tags: ["asp.net","hardware","software","software development","virtualization"]
---

Everyone seems to be getting excited lately about the prospect of cloud computing. Just like many others, I get excited by the idea that I wouldn't have to worry about adding servers to scale up. Theoretically, a guy (or girl) could make the next YouTube, in his basement, for _free_. However, there is one huge advantage that most people ignore, and that's the fact that's also **perfect for a small scale website**.

![iStock_000004135866XSmall](istock-000004135866xsmall.jpg) 

I've tried or considered many different ways of hosting my content:

*   **Shared hosting** - Cheaply host your sites, but be at the mercy of their IT guy messing with your computer and rebooting it for automatic updates. Also, in my experience, the performance is terrible if your traffic spikes. They typically have hundreds of users on the same server as you, and you all get to compete for performance.*   **Dedicated hosting** - This is what I use now, because it ensures that I get the full performance of a machine. The disadvantage is that I have a single point of failure, and I have to manage the machine myself.*   **Hosting from home** - Yes, people actually do this. If you have a high enough upload speed it shouldn't be too bad. The problem is that your connection typically won't be able to handle traffic spikes. You'll also potentially be a victim of power or Internet outages, where professional hosts would have redundant systems in place (in theory). 

Now, let's talk about cloud computing. That magical cloud that many don't understand. There are two potentially viable cloud computing methods available right now:

*   **Cloud virtual machines** - Amazon's EC2 solution is probably the most popular in this category. Basically, you can create, start, and stop virtual machines remotely. You just pay an hourly rate while the computer is running. You can even upgrade and downgrade the hardware as needed. The advantage is that you can treat the computer like a physical machine and configure and use it however you like. The disadvantage is that maintaining individual machines can be time consuming and is not necessarily part of your core business.*   **Cloud application server** - Instead of creating virtual machines, a cloud application server runs your application directly. You no longer worry about the constraints of a physical machine. You application could potentially be run on dozens or hundreds of servers simultaneously. The major advantage is that there is little to no maintenance, because that is the job of the provider. 

I see the cloud application server as having some of the greatest advantages. You're free to write your application with a level of abstraction, which allows you to solve the problems you really want to solve.

One of the most well known cloud application services is the [Google App Engine](http://code.google.com/appengine/), which currently supports Python applications. Microsoft joined the game recently with [Azure](http://www.microsoft.com/azure/default.mspx) for ASP.NET.

As I mentioned, not only do application servers let your applications scale up, they let you **pay only for what you use**. This is great for the small to medium website's that are stuck with bad shared hosting or difficult-to-manage dedicated hosting. The fact is that most sites get a **few hundred visitors daily or less**. If you start to think about how often a page is actually requested, you'll realize that it's not very much. Even with 500 users requesting 5 pages each in a 12 hour period can easily be handled with a very low end server from years ago.

The reason that application servers are so much more efficient than shared hosting is because they're built from the ground up to spread the load around. This results in higher utilization, but more headroom for any single application. Shared hosting providers can move users between servers, but it's usually a manual, and often difficult process. You're bound to a specific physical machine (unless it's VPS hosting), and if it goes down, so does your site.

Cloud computing is also a great way to handle traffic spikes such as the Digg effect. Let's say that you only have 500 visitors today, but might get 10, 100, or 1000 times more in a single day. [It happened to FaceStat](http://www.lukasbiewald.com/?p=153). They went from 10,000 page views per day to almost a million because of a story on the front page of Yahoo. They had to scramble to add application servers and develop a scaling strategy immediately.

**Conclusion - Cloud Application Server Benefits**

Cloud computing has tremendous benefits. You no longer have to worry about scaling the underlying hardware, you simply pay as you go, and you can handle traffic spikes with ease. Once cloud computing becomes mainstream and absolutely reliable, there will be few reasons to not use it.