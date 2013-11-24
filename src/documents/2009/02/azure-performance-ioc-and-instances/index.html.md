---
layout: post
title: Azure – Performance, IoC, and Instances
date: 2009-02-19
tags: ["software"]
---

Ever since the [Google App Engine](http://code.google.com/appengine/) was released, I've been fascinated with cloud computing frameworks. The vision is to have a website that can scale from nothing to infinity, without having to worry about servers, viruses, uptime, etc. I've finally gotten a chance to play around with Azure, and I must say that I'm in love with the concept, but disappointed by the current reality.

[![Azure](azure-thumb.jpg "Azure")](http://www.ytechie.com/post-images/2009/02/azure.jpg) 

###Performance

I've taken a site that I consider a "playground site", and converted it over to run in Azure. One of the metrics I wanted to look at was the responsiveness of the deployed application. I run the main version of the site on a dedicated server, and I don't think it's unreasonable to use that as a baseline. After all, the purpose of Azure is to have the advantages of all the different types of hosting, yet have less to worry about.

To gauge performance, I used the Firefox add-in called Firebug. This let me see the amount of time that each requested element took to be transferred from the server. It also gives some insight into the amount of time it takes for the page to render. In the future, I'm going to use some server tracing to find specific operations that may be taking longer.

This is the baseline data from [http://www.simpletracking.com](http://www.simpletracking.com). As you can see, the page is served up very quickly. The page takes less than 100ms to render (1/10 of a second), and the entire page comes through in less than half of a second.

[![simpletracking.com](simpletrackingcom-thumb.png "simpletracking.com")](http://www.ytechie.com/post-images/2009/02/simpletrackingcom.png)

Now take a look at the same code running on Azure:

[![simpletracking.cloudapp.net](simpletrackingcloudappnet-thumb.png "simpletracking.cloudapp.net")](http://www.ytechie.com/post-images/2009/02/simpletrackingcloudappnet1.png)

To render the page, instead of 89ms, it now takes ~650ms. It takes a full second for the entire page and its elements to be sent down to the client.

Running both pages several times started to give me interesting results. The dedicated server was giving me extremely consistent results (even with other users hitting it). Azure however, was all across the board. It was typically around 1 second for the entire page to render, but would spike up to 5 seconds occasionally. Personally, I think this is completely unacceptable performance. Hopefully this is not indicative of the performance I can expect once it's released.

###IoC

Azure is designed so that if you have an application that runs in medium trust, it shouldn't require any conversion to run straight in Azure (in most cases). If you're using a database, there are other restrictions because Azure doesn't use a standard SQL database. In addition to these obvious issues, a non-obvious issue is that if you're using an IoC container, it probably won't run in medium trust.

My application uses the IoC container Spring.NET, which immediately failed. I suspected (incorrectly) that Windsor might have worked better, but couldn't tell from the documentation. To make it easy to plug in different IoC containers, I started using the [Common Service Locator](http://www.codeplex.com/CommonServiceLocator). If you're doing IoC without the common service locator, I really recommend you check it out.

I was then fortunate enough to find [this page](http://onceuponans.blogspot.com/2009/01/how-i-spent-my-winter-vacation-two.html), which has great information on the different IoC containers and their Azure compatibility:

* **Castle Windsor** - My preferred IoC container, but it won't run under medium trust. Out!      
* **StructureMap** - My second favorite IoC container. Runs under medium trust locally, but not under Azure. Submitted bug report to Jeremy Miller. Reading through the [StructureMap user's group](http://groups.google.com/group/structuremap-users), it looks like he's going to try to fix that early this year.      
* **Ninject** - I didn't really monkey around with Ninject much. The sample code I saw was riddled with [Inject] attributes, which kinda turned me off. Apologies to @nkohari if I dismissed it too early.      
* **Autofac** - Works great in medium trust under Azure, easy to configure, but doesn't support registering arguments for constructor injection at configuration time. You have to specify them when you resolve the service.      
* **Unity** - No problems at all! Worked great in medium trust on Azure, easy to configure, supports everything I need! I gotta say I'm really impressed by how far Unity has come in such a short time.  

My only reasonable option was Unity, which is Microsoft's IoC container. After another fun conversion, I was up and running! I honestly don't have any complaints about their IoC offering.

###Instances

The Azure team decided to introduce the concept of "Instances". You have to decide how many virtual instances of a web server that you want running. I really don't understand the logic here. Their sales pitch is all about handing unpredictable traffic patterns, yet an instance based approach just gives me another aspect of the application that I have to worry about. They're promising that a configurable heuristics system will eventually be in place to handle the management of the number of instances. In effect, they are putting a band aid on a problem that they've created even before release.

Contrast this design with the Google App Engine. With their system, you don't have to worry about configuring instances at all. It automagically scales from nothing to infinity automatically.

Instances on the worker roles make sense. Worker roles are not public facing, they are there to process data. By configuring the number of worker role instances, I can change the rate at which my data gets processed.

###Conclusion

I realize that Azure isn't even in beta yet, so I shouldn't expect the world. I had my fingers crossed that their CTP would be production quality (wouldn't that be nice?). I think that Microsoft will eventually have a great cloud platform on their hands, it's simply a question of timing. Personally, I really don't want to have to worry about uptime, scaling, RAID, drivers, viruses, etc. so I think cloud computing is the inevitable solution.