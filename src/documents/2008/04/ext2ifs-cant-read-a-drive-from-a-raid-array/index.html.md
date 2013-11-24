---
layout: post
title: Ext2IFS Can't read a drive from a RAID array
date: 2008-04-06
---

I converted my Ubuntu home server to a Windows 2008 Server. The biggest challenge of the conversion was the 400GB RAID 1 array, which was [Linux software RAID](http://tldp.org/HOWTO/Software-RAID-HOWTO.html) based. I threw caution to the wind, and figured that I could convert it _after _installing Windows Server 2008.

I was sort of banking on the fact that I could use the [Ext2 installable file system](http://www.fs-driver.org/) for Windows to read one of the drives in the array. For some reason, it was unable to read the disk. I had assumed that since the drives were simply mirrors of each other, it would be able to read one by itself. I was wrong.

My solution was to create an [Ubuntu Desktop](http://www.ubuntu.com/products/WhatIsUbuntu/desktopedition) [virtual machine](http://www.vmware.com/), and use it to mount the physical partition. I was then able to copy the files over the virtual network adapter.