---
layout: post
title: I switched from Linux to Windows Server 2008
date: 2008-04-15
tags: ["software"]
---

Wait, did I say that right? I thought it was supposed to be the other way around?

I admit it, I loved running [Ubuntu Server](http://www.ubuntu.com/products/whatisubuntu/serveredition) 64-bit on my [VMware](http://www.vmware.com/) server. It ran very amazingly fast, and I didn't have to touch it for months. I also liked the idea of all of the configuration being text based. It was easy to backup and restore.

![Ubuntu Linux](ubuntu-logo.png) 

There were just a couple of recurring issues that made me uneasy. The console screen would randomly display network adapter issues, and sometimes I would lose the network connection until I would restart the networking script.

The other issue is that my software RAID 1 array would randomly disappear on reboot. I would have to run this command to fix it:
<pre class="csharpcode">sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 --assume-clean /dev/sd[ab]
</pre>

The last major issue I had was with the VMware Server installation. Out of the gate, the installation was 10 times more difficult. It wasn't a click->next-&gt;next-&gt;next install. Once I got it installed, the VMware server console wouldn't connect.

 ![Windows Server 2008](windows-server-2008.png) 

Since Windows Server 2008 has been released, I've heard nothing but amazing things. This is the best operating system to come out of Microsoft for a long time. For about the past month, I've been trying it out on my laptop. It's basically Vista x64 SP1 without all of the crap. Microsoft really messed up Vista, but somehow they managed to fix it in their server product.

Installation took less than 15 minutes, and I appreciate the fact that it doesn't ask you anything other than the location to install to. It boots extremely fast, and is impressively snappy.

All of the previous issues I mentioned have gone away (I cheated on the RAID problem, since I'm not using RAID anymore).

The most frustrating thing about Linux (and one of it's biggest strong points), is that I never had a really good GUI tool to fall back on when things got rough. When something goes wrong in Windows, I can at least look around at my options. In Linux, you have to look at documentation and examples, and guess what the syntax and settings are for your configuration.

The biggest problem for many of my readers is going to be the fact that you can't get a copy of Server 2008 for a reasonable price. In my case, this is a development server, and I'm able to use my [MSDN](http://msdn2.microsoft.com/en-us/subscriptions/default.aspx) (Microsoft Developer network) license.

A common question I'm asked, is if I had any problems finding drivers. Every driver I needed was automatically installed by Windows. It's very impressive seeing as how it's a completely custom server, with all of the parts purchased on [NewEgg](http://www.newegg.com/).

I still love Linux, but right now I'm more productive with Windows Server 2008 x64.

<span style="font-size:100%;">[
](http://www.ytechie.com/2008/04/re-switching-from-linux-to-windows-2008.html)</span>

<span style="font-size:100%;">[Update Apr. 18, 2008: I posted a follow-up to this post here](http://www.ytechie.com/2008/04/re-switching-from-linux-to-windows-2008.html)</span>