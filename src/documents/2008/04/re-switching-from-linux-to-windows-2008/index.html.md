---
layout: post
title: RE: Switching from Linux to Windows 2008
date: 2008-04-18
tags: ["software"]
---

I've gotten so much feedback from my post "[I switched from Linux to Windows Server 2008](http://www.ytechie.com/2008/04/i-switched-from-linux-to-windows-server.html)" that I think I need to clarify a few things. The responses have ranged from agreement to personal attacks. I'm impressed by the emotion of the people that really believe in their operating system. Personally, I've always tried to use each tool for different situations.

Most importantly, I'd like to explain why I wrote the post. I was simply sharing my personal experience, which may or may not be your experience. I know that Linux is very popular, and my opinion is that it is a superior operating system in many ways.

Now for a little history of my experience, which may help understand my feelings.

![Confused!](question-mark-man.png) 

Years ago I was running Windows 2003 for a home server. I was frustrated by the poor performance, high resource usage at idle, and tricky to configure. I have years of Windows experience, and I could never quite get it set up the way I wanted. I also wanted to avoid the cryptic Windows licensing, and their policy of locking you into the products of their choosing.

So, I built a brand new computer, and installed Ubuntu Server 64 bit edition. I spent weeks getting it configured (not continuously of course). I kept notes, and I was pleased at the fact that I could use a single command line to install pretty much everything I needed:
<pre class="csharpcode">Sudo apt-get update; sudo apt-get upgrade; sudo apt-get -y install ssh subversion dovecot-imapd samba xinetd build-essential getmail4 p7zip-full ia32-libs mdadm bind
</pre>

&nbsp;

How cool is that!

I was very happy, except when things would go wrong. For example, 4GB of memory wouldn't work with Linux, but anything less would. It turns out that I had to blacklist the "intel_agp" module. **I really wish I could get back the hours of my time that were wasted. **Am I any better for the experience? No. Can this happen in Windows? It certainly can.

Here were the additional problems I had, which subsequently wasted additional hours of my time:

*   The software RAID array would stop working 50% of the time when rebooting. It's not fun having your heart sink when it says that there is a problem with the RAID array that all of your data is on (yes, I have off-site backups, but it's still a hassle).
*   The VMware server console would not work when I reinstalled the host OS. VMware itself worked fine, and I used the "vmrun" command over Putty to manage my virtual machines. Believe me, that is not fun.
*   Samba was ridiculously slow. Try searching for samba optimizations in Google. Why isn't the performance better out of the box?
*   Random network errors would appear on the server console. Sometimes the network would simply fail. Sometimes it took a reboot to get it working again. Simply calling "sudo restart /etc/init.d/networking" didn't work.
*   Dual monitor support. Don't even ask me how many times I've modified my xorg configuration file.

Could I have taken the dozens of hours and fixed all of these issues? Maybe. I did my due diligence and searched Google and the Ubuntu forums for help. I even posted my problems without getting answers. I'm certainly not against learning. I'm a software engineer by trade, so I would rather be spending time learning Adobe Flex, Silverlight, MVC frameworks, and new coding methodologies. Is it so bad that I want to choose what I want to learn?

**I just want a solution to my problem that works with the minimum amount of hassle, so I can focus on what I enjoy.**

That is my _opinion, _and you can't say it's wrong!

Recently I read quite a few articles about .NET developers switching to Windows 2008 as a workstation operating system. I took the leap and did the same. My experience has been very positive, and my opinion is that it's a great operating system. I intend to write a post specifically about that in the future.

Because of the frustrations I was feeling on my server, I decided to give Windows 2008 a try on there as well. In total, I've spent about 2 hours getting it set up, from start to finish. Some of the new setup features deserve an entire blog post (stay tuned!). The only thing I haven't set up is subversion and my off-site [rsync](http://samba.anu.edu.au/rsync/) backups. I'll be running the [Subversion virtual appliance](http://www.young-technologies.com/Software/Subversion-Virtual-Machine/) for my source code (which coincidentally, is my project).

On person said that I'm just trying to get attention. Well, it's my blog, and I admit that part of my motivation is to get readers.

Another person said that the post was an advertisement (at least I think that's what he meant). Well, to prove I'm not being paid by Microsoft, I'll admit that they have a ton of software that just plain sucks. I'm looking at you Vista.