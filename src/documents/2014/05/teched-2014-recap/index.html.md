---
layout: post
title: TechEd 2014 Ultimate Recap - with Links!
date: 2014-05-12
tags: [azure]
---

Just like my [//Build 2014 Ultimate Recap - with Links!](http://www.ytechie.com/2014/04/build-2014-ultimate-recap-with-links/), I'll be doing the same for [TechEd](http://northamerica.msteched.com/). I'll keep updating this content with new announcements until the end of TechEd. Keep in mind that my outline is developer focused, so I won't go as deep on the IT Pro topics.

### New Services
* Windows 7 and Windows 8.1 virtual machines now available for [MSDN subscribers in the gallery](https://twitter.com/ytechie/status/465857908551335936).
* [Public preview of Azure Files](http://blogs.msdn.com/b/windowsazurestorage/archive/2014/05/12/introducing-microsoft-azure-file-service.aspx). This allows you to use a storage account as an SMB share (standard Windows file share).
* Partnerships with Trend Micro and Symantec to provide Antimalware solutions.
* [Internal load balancing](http://msdn.microsoft.com/en-us/library/azure/dn690121.aspx) of virtual machines with private addresses
* Multiple site-to-site virtual network connections
* Cross-datacenter virtual network connectivity
* IP reservation of VIPs. Reserve a public IP address and assign them to cloud services as needed (think Elastic IPs but better).
* Instance-level IPs. Assign a public IP address to any VM without having to go through the cloud-service endpoint.
* Azure [RemoteApp](http://azure.microsoft.com/en-us/services/RemoteApp/)
* Public preview of [API management](http://azure.microsoft.com/en-us/services/api-management/).
	* Analytics
	* Throttling
	* Caching
	* Permissions
* Public preview of [Redis cache](http://redis.io/)
* Shared caching service will be retired in September. Customers should use the managed cache option or Redis.
* Public preview of [BizTalk Hybrid Connections](http://blogs.msdn.com/b/biztalk_server_team_blog/archive/2014/05/13/hybrid-connections-preview.aspx). Communicate to TCP or HTTP resources from Azure Web Sites.
* [Capture images with OS and data drives attached](http://weblogs.asp.net/scottgu/archive/2014/05/12/azure-vm-security-extensions-expressroute-ga-reserved-ips-internal-load-balancing-multi-site-to-site-vpns-storage-import-export-ga-new-smb-file-service-api-management-hybrid-connection-service-redis-cache-remote-apps-and-more.aspx). Works on running or stopped virtual machines.
* [Store support for EA (enterprise agreement) customers](http://azure.microsoft.com/en-us/updates/azure-store-direct-ea-customers-channel-partners/).
* [Windows 8 Store Update](http://winsupersite.com/windows-8/windows-store-app-gets-major-update)

### Services that are now GA (general availability)
* Larger VM's for virtual machines. A8 machines give you 8 cores, 56GB of RAM, and A9 give you 16 cores and 112GB of RAM. These also provide an [Infiniband](http://en.wikipedia.org/wiki/Infiniband) network.
* [Azure import/export](http://azure.microsoft.com/en-us/pricing/details/storage-import-export/)
* [Azure Cache Service](http://azure.microsoft.com/en-us/services/cache/)

### Visual Studio
* [Visual Studio 2013 Update 2 RTM](http://blogs.msdn.com/b/visualstudio/archive/2014/05/12/visual-studio-2013-update-2-is-here.aspx)
* [ASP.NET vNext](http://www.hanselman.com/blog/IntroducingASPNETVNext.aspx)
	* Cloud and server optimized
	* No-compile developer experience
	* Side-by-side runtime and application
	* The runtime is NuGet-able
	* The source is on [Github](https://github.com/aspnet)
* Visual Studio [tooling support for Cordova (aka PhoneGap)](http://msopentech.com/blog/2014/05/12/apache-cordova-integrated-visual-studio/). Build cross-platform HTML/JavaScript applications.