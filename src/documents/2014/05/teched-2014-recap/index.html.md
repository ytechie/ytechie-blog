---
layout: post
title: TechEd 2014 Ultimate Recap - with Links!
date: 2014-05-12
tags: [azure]
---

Just like my [//Build 2014 Ultimate Recap - with Links!](http://www.ytechie.com/2014/04/build-2014-ultimate-recap-with-links/), I'll be doing the same for [TechEd](http://northamerica.msteched.com/). I'll keep updating this content with new announcements until the end of TechEd. Keep in mind that my outline is developer focused, so I won't go as deep on the IT Pro topics.

*Much more information coming soon*

### New Services
* Windows 7 and Windows 8.1 virtual machines now available for MSDN subscribers in the gallery.
* Public preview of Azure Files. This allows you to use a storage account as an SMB share (standard Windows file share).
* Partnerships with Trend Micro and Symantec to provide security solutions for cloud applications.
* Internal load balancing of virtual machines with private addresses
* Multiple site-to-site virtual network connections
* Cross-datacenter virtual network connectivity
* IP reservation of VIPs. Reserve a public IP address and assign them to cloud services as needed (think Elastic IPs but better).
* Instance-level IPs. Assign a public IP address to any VM without having to go through the cloud-service endpoint.
* Azure [RemoteApp](http://azure.microsoft.com/en-us/services/RemoteApp/)
* Public preview of API management (recall that Microsoft purchased [Apiphany](http://apiphany.com/)).
	* Analytics
	* Throttling
* Public preview of [Redis cache](http://redis.io/)
* Shared caching service will be retired in September (there are newer, more robust options).
* Public preview of BizTalk Hybrid Connections. Communicate to TCP or HTTP resources from Azure Web Sites.
* Capture images with OS and data drives attached. Works on running or stopped virtual machines.
* Store support for EA (enterprise agreement) customers.

### Services that are now GA (general availability)
* Larger VM's for virtual machines. A8 machines give you 8 cores, 56GB of RAM, and A9 give you 16 cores and 112GB of RAM. These also provide an [Infiniband](http://en.wikipedia.org/wiki/Infiniband) network.
* [Azure import/export](http://azure.microsoft.com/en-us/pricing/details/storage-import-export/)
* [Azure Cache Service](http://azure.microsoft.com/en-us/services/cache/)

### Visual Studio
* [ASP.NET vNext](http://www.hanselman.com/blog/IntroducingASPNETVNext.aspx)
	* Cloud and server optimized
	* No-compile developer experience
	* Side-by-side runtime and application
	* The runtime is NuGet-able
* Visual Studio [tooling support for Cordova (aka PhoneGap)](http://msopentech.com/blog/2014/05/12/apache-cordova-integrated-visual-studio/). Build cross-platform HTML/JavaScript applications.