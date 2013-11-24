---
layout: post
title: Vista x64 Frequent Stuttering – Dell M6400
date: 2009-01-29
tags: ["hardware"]
---

I recently got a new laptop at work (the details of which I'm saving for another day). It's a Dell Precision M6400\. With a fresh install of Vista Enterprise x64, the whole machine would stutter/pause/stall every few seconds. It wasn't just the mouse, it was the display, the sound, everything. It was unbearably annoying, and I eventually fixed it.

When the stuttering started, I frantically searched Google for other people having the same issue. Apparently it's a frequent issue, and is often caused by NVidia drivers. In other cases, it's caused by hard drive issues. It was even occurring on all the other laptops we ordered with the same configuration.

I spent hours trying to fix it, including the following:

*   Updated BIOS
*   Switched the hard drives to performance mode
*   Enabled VT extensions (needed to do this anyway)
*   Forced all of the graphics options in the NVidia control panel to off.
*   Uninstalled NVidia drivers, reinstalled them. I also [hacked some of the official NVidia drivers](http://www.laptopvideo2go.com/forum/index.php?showtopic=9243) and installed them instead of using the ones that Dell supplies.
*   Turned off superfetch
*   Turned on readyboost and used a USB thumb drive
*   Full scandisk checking for bad sectors
*   Defrag
*   Disabled touchpad and eraser head
*   Turned off just about every service, and killed almost every process
*   Installed chipset drivers (SM Bus)  

I had just about given up, when a [colleague](http://www.obishawn.com) suggested a few things, including **installing new SATA drivers** for my RAID array (I'm running RAID 0). I grabbed the latest copy from Dell, instead of using the ones that came on the original CD. Sure enough, **that fixed it**.

[![Storage Manager Drivers (Middle One)](image6.png "Storage Manager Drivers (Middle One)")](http://support.dell.com/support/downloads/driverslist.aspx?os=WV64&amp;osl=EN&amp;catid=-1&amp;impid=-1&amp;servicetag=&amp;SystemID=PREC_M6400&amp;hidos=WLH&amp;hidlang=en&amp;TabIndex=) 

The irony is that I usually set up my own machines (I'm pretty specific about how I like it set up), but this time I let our IT guy set it up to save me some time. When I set up machines, I'm obsessive about getting the latest drivers from the web, because I've been through this type of problem before. From now on, I'm going back to setting up my own machines.

I get the feeling this will help _someone_ out there!