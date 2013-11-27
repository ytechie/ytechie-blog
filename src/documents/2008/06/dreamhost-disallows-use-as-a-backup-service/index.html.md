---
layout: post
title: DreamHost disallows use as a backup service
date: 2008-06-23
---

I just received this email from DreamHost: 

> Dear Jason, 
> 
> Our system has noticed what seems to be a large amount of "backup/non-web" content on your account (#xxxx), mostly on user "xxxx" on the web server "xxxx". 
> 
> Some of that content specifically is in /home/superjason/Backup (although there may be more in other locations as well.) 
> 
> Unfortunately, our terms of service (http://www.dreamhost.com/tos.html) state: 
> 
> The customer agrees to make use of DreamHost Web Hosting servers primarily for the purpose of hosting a website, and associated email functions. Data uploaded must be primarily for this purpose; DreamHost Web Hosting servers are not intended as a data backup or archiving service. DreamHost Web Hosting reserves the right to negotiate additional charges with the Customer and/or the discontinuation of the backups/archives at their discretion. 
> 
> At this point, we must ask you to do one of three things: 
> 
> * You can delete all backup/non-web files on your account.      
> * You can close your account from our panel at: https://panel.dreamhost.com/?tree=billing.accounts (We are willing to refund to you any pre-paid amount you have remaining, even if you're past the 97 days. Just reply to this email after closing your account from the panel. 
> 
> OR! 
> 
> * You may now enable your account for backup/non-web use! 
> 
> If you'd like to enable your account to be used for non-web files, please visit the link below. You will be given the option to be charged $0.20 a month per GB of usage (the monthly average, with daily readings) across your whole account. 
> 
> We don't think there exists another online storage service that has anything near the same features, flexibility, and redundancy for less than this, so we sincerely hope you take us up on this offer! 
> 
> In the future, we plan to allow the creation of a single "storage" user on your account which will have no web sites (or email). For now though, if you choose to enable your account for backups, nothing will change (apart from the charges). 
> 
> If you want to enable backup/non-web use on this account, please go here: 
> 
> https://panel.dreamhost.com/backups.cgi?g=xxxx
> 
> If you choose not to enable this, you must delete all your non-web files by 2008-06-29 or your account will be suspended. 
> 
> If you have any questions about this or anything at all, please don't hesitate to contact us by replying to this email. 
> 
> Thank you very much for your understanding,      
> The Happy DreamHost Backup/Non-Web Use Team  

![image](image3.png) 

Admittedly, the primary reason I chose them was because they're a great backup solution. I didn't realize that it was against their terms of service, in fact, there is a ton of information out there about using rsync to backup your files to them. I've been doing it for well over a year now, and I've been recommending the service to others. 

I had heard many bad things about DreamHost, but they were working great for backups. Now you can't use them for that, what do they have going for them? I can't imagine many users have 400GB+ websites that their hosting. If they are, I have a hard time believing they're using cheap shared hosting!

Now I'm looking into other backup solutions, and it's looking pretty grim. Since my server and laptop both run Windows 2008, there aren't many solutions available. For example, [Mozy](http://mozy.com/) requires you to use their business version, which is [ridiculously expensive](http://mozy.com/pro/pricing).

Another option is [JungleDisk](http://www.jungledisk.com/), which uses Amazon's S3 service. I would be looking at paying $30/month to backup around 200GB.

Does anyone have other ideas? The solution has to be automatic, so that I don't have to count on remembering to do it. It also has to be off-site, because I don't want to lose all of our photos of our house burns down.