---
layout: post
title: Improve your software by creating an API
date: 2008-06-04
tags: ["productivity"]
---

I'm going to talk about the benefits of having an [API](http://en.wikipedia.org/wiki/API) for your product, and why you should consider building one for your next project.

I used to work for company that developed manufacturing software. Now I'm on the other side of the fence. Since I work in the IT department, I'm asked to help in evaluating the software that our company will use. One of our main tasks is to write the glue that puts all of the other pieces together. We know we'll have to fill in the gaps with custom software, since no boxed software is perfect for our custom process. Those gaps could be missing functionality, or it could be code that hooks up two systems so that they work together.

So what is the single best thing you can do to help people like me out?

**<u>Have an API for your software!</u>**

![Doorway](doorway.jpg)
 **<u></u>**  

If your software has an API that lets us read and write the valuable data in your system, it's going to save us a lot of time. If we have to start modifying data in your database, we have to worry about tables changing. Worse yet, you might be using a type of database that we're not familiar with. That's only going to make us less likely to upgrade.

The great part is that this makes your software easy to sell. If someone asks for a feature that you don't have, you can tell them that your great API supports it, and their IT team could easily build that custom functionality. Better yet, they may contract you to build it for them. You can avoid saying &quot;no&quot;, which can sometimes be the kiss of death for a potential sale.

What else can you do to have a _great_ API?

*   Try to avoid being restrictive on how the data is queried. The [Flickr API](http://www.flickr.com/services/api/) is a great example of allowing full access to just about everything, and allowing it to be queried in an amazing number of ways.
*   Try to maintain backwards compatibility when possible
*   When necessary changes are made, have a list so that our software can be updated
*   Have great documentation, which some clear examples  

If you want to make sure that your API can truly get at all the data a customer would want, then why don't use use it yourself? If your own product is built on your API, it will be another selling point, as well as a guarantee that it fulfills the need. It also ensures that the layers in your software are not blurred. You will have a clear, well defined way that all data is moved in and out of the system.