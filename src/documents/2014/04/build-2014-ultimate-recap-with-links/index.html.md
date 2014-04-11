---
layout: post
title: //Build 2014 Ultimate Recap - with Links!
date: 2014-04-11
tags: [azure]
---

* [Windows Phone](http://blogs.windows.com/windows_phone/b/windowsphone/archive/2014/04/02/cortana-yes-and-many-many-other-great-features-coming-in-windows-phone-8-1.aspx) - Lots of industry excitement!
	* 8.1 developer preview will be available soon. [Joe Belfiore said check back next week :-)](https://twitter.com/joebelfiore/status/454281727158919168)
	* Action center + notification center
	* New keyboard - world record holder
	* Cortana
		* Siri + google play
		* Interviewed personal assistants
		* Notebook
		* Quiet hours
	* HIGHLY customizable lock screen
	* Rewritten calendar
	* IE 11
	* Bluetooth LE
	* VPN
	* Windows is now free for any screen under 9"
	* 8.0 apps are still compatible
	* Buy applications and in-app purchases and share then between Win8.1 and WP8.1
	* Geofencing
	* WiFi sense - auto-WiFi portal login and password sharing with friends
	* Signed and encrypted email
	* Switch calls to Skype while on a call
	* WebGL in IE11
	* Inline video playback
	* Battery Sense - Monitor battery performance by application
	* [New phones announced](http://press.nokia.com/2014/04/02/nokia-introduces-three-lumia-smartphones-for-windows-phone-8-1/)
* Azure
	* [New portal](https://portal.azure.com/) focused on merging separate products and supporting DevOps
		* Integrated billing
		* Integrated Visual Studio Online
	* Remote debugging in IaaS - thanks to the agent
	* Websites
		* Free SSL certs for web sites
		* Java support
		* Autoscale GA
		* Traffic Manager GA
	* SQL Databases
		* Restore from backups at regular intervals
		* Max size for premium is now 500GB, up from 150GB
	* [Big pricing drops](http://blogs.msdn.com/b/windowsazure/archive/2014/03/31/microsoft-azure-innovation-quality-and-price.aspx)
		* Compute by up to 35%
		* Storage by up to 65%
		* New "basic" tier without load balancing - 27% price drop
	* [Orleans preview released](http://research.microsoft.com/en-us/projects/orleans/) - The framework that powers [Halo's distributed cloud services](http://channel9.msdn.com/Events/Build/2014/3-641)
	* Partnerships with [Chef and Puppet to run their management software on Azure](http://techcrunch.com/2014/04/03/microsoft-updates-azure-with-deeper-visual-studio-integration-puppet-and-chef-support/)
	* Mobile services
		* Offline sync capability
		* Kindle push notifications GA
	* New CDN Service
		* Can point at blobs
		* Can point at a content folder. Previously this was /content/, and it is now /cdn/
	* [Azure Active Directory Premium GA](http://blogs.technet.com/b/ad/archive/2014/04/03/azure-active-directory-premium-has-reached-ga.aspx)
		* Multi-factor authentication
		* Machine learning-based security & reports
		* Self-service password reset
		* Company branding
* .NET/Windows
	* Side-loaded apps
		* Ability to call existing .NET code
		* Allows local loopback
		* A new option to [purchase unlimited sideloading](http://blogs.windows.com/windows/b/business/archive/2014/04/02/building-the-mobile-workplace-with-windows-and-windows-phone.aspx)
	* [Universal apps](http://channel9.msdn.com/Events/Build/2014/3-591)
		* 80%+ API convergence		
		* Structured to separate out common code but design device specific screens
		* Future support for Xbox
		* Supports C#, JavaScript, c++
		* Different than PCL
			* No binary output
			* Include platform specific code in #if conditionals
	* [Project N - .NET Native](http://msdn.microsoft.com/en-US/vstudio/dotnetnative)
		* Compile .NET store apps to native code for c++ performance
	* [Roslyn](https://roslyn.codeplex.com/)
		* [Compiler as a service](http://channel9.msdn.com/Events/Build/2014/2-577)
		* Now open source
	* Lots of other [Microsoft software open sourced through the .NET foundation](http://www.dotnetfoundation.org/)
	* Demoed modern office apps
		* Based on iPad UI, which has been very well received
	* [WinJS open sourced](http://channel9.msdn.com/Events/Build/2014/2-506)
	* [TypeScript 1.0 release](http://channel9.msdn.com/Events/Build/2014/3-576)
	* Future version of Windows
		* Start menu option with live tiles
		* Run modern apps in a Window