---
layout: post
title: Build 2015 Mega Post
date: 2015-05-01
---

[Keynote Highlights](https://www.youtube.com/embed/6no1vF__Oj0)

### Windows

* UAP -> UWP Universal Windows Platform
	* [Deep Dive](http://blogs.windows.com/buildingapps/2015/04/30/a-deeper-dive-into-the-universal-windows-platform/)
	* [Need to Know: What is UWP?](https://www.thurrott.com/windows/windows-10/3294/need-to-know-universal-windows-platform)
	* [Live tiles, notifications and Action center](http://channel9.msdn.com/Events/Build/2015/2-762)
		* XAML Tiles are being worked on
		* Interactive tiles are being worked on
		* JSON format being worked on
	* [Web of apps](http://channel9.msdn.com/Events/Build/2015/3-765)
	* Subscription based IAPs are coming to the new dev center and win10 apps
	* Carrier Billing across all Windows 10 devices
	* One Dev Center
		* Single submission flow for your Universal Windows Apps, as well as legacy Windows 8.x and Windows Phone 7.x/8.x apps
		* Single dashboard to analyze and manage app performance across all you apps
		* Ability to distribute your apps to consumers who use Windows Store, as well as in a storefront specifically built for businesses and organizations, all via a single app submission
		* Management of your ads-in-apps from within Dev Center
	* [Universal App Samples on GitHub have been updated](https://github.com/Microsoft/Windows-universal-samples)
	* [Initial Design Guidance](http://blogs.windows.com/bloggingwindows/2015/04/29/windows-10-design-getting-the-balance-right/)


* [Bridges](http://blogs.msdn.com/b/stevengu/archive/2015/04/30/building-bridges-that-empower-developers.aspx)
	* [Use your Android Code on Windows](http://channel9.msdn.com/Events/Build/2015/2-702)
	* [Use your iOS Code on Windows](http://channel9.msdn.com/Blogs/OneCode/How-to-Port-iOS-apps-to-Windows-Store-apps)
	* [Convert your classic Windows app to a UWP app](http://channel9.msdn.com/Events/Build/2015/2-692)
		* Advantages of a UWP app like easy install, automatic updates.
		* File & registry redirection
		* Live tiles
		* Can do anything a UWP app can do
* [Hololens](http://channel9.msdn.com/Events/Build/2015/C9-08)
* [Continuum for Phone](http://channel9.msdn.com/Events/Build/2015/2-703)
	* Run the tablet version of phone apps with a connected display
	* Works over HDMI or Miracast
	* Will require new hardware
* [Windows 10 preview for IoT is available](http://channel9.msdn.com/Events/Build/2015/2-724)
	* Works on Minnowboard Max or Raspberry Pi 2
	* [Get started here](http://ms-iot.github.io/content/GetStarted.htm)
* [Windows 10 "Arduino Certified" components](http://www.zdnet.com/article/windows-10-gets-arduino-certified-with-new-two-open-source-libraries/)
* [DirectX 12 Support](http://channel9.msdn.com/Events/Build/2015/3-673)
* [Manifold.js](http://www.manifoldjs.com/)
	* Create hosted apps on Android, iOS, and Windows
	* Uses standard manifest

### Azure

* [.NET SDK 2.6](http://azure.microsoft.com/en-us/documentation/articles/azure-sdk-dotnet-release-notes-2_6/)
	* HDInsight improvements
	* In-Role caching uses latest storage SDK
	* App Service tools
	* Azure Resource Manager new templates for Virtual Machines, Networking, and Storage
	* Diagnostic improvements
* [Data lake service](https://www.youtube.com/watch?v=MlNU48h39wU&feature=youtu.be)
	* HDFS compatible file system
	* Unlimited storage
	* Optimized for high throughput, low latency
* [Project Oxford](http://channel9.msdn.com/Events/Build/2015/2-613)
	* Face detection
	* Speech recognition
	* Vision information API
	* Powers [how-old.net](http://how-old.net)
* [Service Fabric](http://channel9.msdn.com/events/Build/2015/2-640)
	* Stateful microservices
* [SQL Database](http://channel9.msdn.com/Events/Build/2015/2-678)
	* SQL DB Transparent data encryption public preview
	* SQL DB Service Tier Advisor public preview - asses performance needs
	* Elastic Data Pool
	* Full-text Search
* More than 500 new features in Azure in the past year
* Over 50 trillion storage objects
* [App Service Architecture](http://channel9.msdn.com/Events/Build/2015/2-628)

### Visual Studio

* [Visual Studio Code](http://channel9.msdn.com/Events/Build/2015/3-680)
	* Free, cross-platform editor
	* Get it [here](https://www.visualstudio.com/en-us/products/code-vs.aspx)
* [2015 RC available](http://go.microsoft.com/fwlink/?LinkId=521794&clcid=0x409)
* [Visual Studio 2013 Update 5 RC](https://www.visualstudio.com/en-us/news/vs2013-update5-vs.aspx)
* TypeScript 1.5 Beta
* [TypeScript 1.6 Async/Await](http://channel9.msdn.com/Events/Build/2015/3-644)
* [Extensibility model for VSO](http://blogs.msdn.com/b/visualstudioalm/archive/2015/05/01/extensions-for-visual-studio-online-rest-apis-for-tfs-2015-rc-and-more-from-build-2015.aspx)
* [GitHub Inside Your Visual Studio](http://haacked.com/archive/2015/04/30/github-in-your-visual-studio/)

### Misc

* [Project Spartan is now Edge](http://channel9.msdn.com/Events/Build/2015/2-656)
	* [Need to Know: Edge](https://www.thurrott.com/windows/windows-10/3280/need-to-know-microsoft-edge)
	* Extension support nearly compatible with Chrome
* [.NET support on Linux in Docker](http://channel9.msdn.com/Events/Build/2015/2-683)
* [.NET core preview for Linux and Mac](http://channel9.msdn.com/Events/Build/2015/3-670)
	* Additionally, run and debug .NET on Linux, in a Docker container
* .NET 4.6 RC for Windows
* [Nano server](http://channel9.msdn.com/Events/Build/2015/2-755)
	* Admin GUIs on servers are poison
	* It's just a deployment option
	* Features are pulled in separately, not on disk
	* Hyper-V, ASP.net, clustering support
	* Configuration via core PowerShell and WMI
	* Uses core CLR, most core engine components
	* Nano server is a subset of the full server surface area
	* An app that works on nano server will run on the full server
	* Optional Reverse forwarders package allows you run non-nano apps and silently fail on unsupported API calls
	* Lots of things can run with the reverse forwarders like Java, node.js
	* Less than 3 minutes to install
	* 400mb vs 5+gb for full server
	* Inject drivers in image before install
* Office has a unified endpoint for all API calls
	* Add-ins run everywhere that office does
* [Vorlon.js](http://blogs.msdn.com/b/eternalcoding/archive/2015/04/30/why-we-made-vorlon-js-and-how-to-use-it-to-debug-your-javascript-remotely.aspx)
	* An open source, extensible, platform-agnostic tool for remotely debugging and testing your JavaScript
* Building a new Reactor space in San Francisco
* Minecraft Modding in Visual Studio
