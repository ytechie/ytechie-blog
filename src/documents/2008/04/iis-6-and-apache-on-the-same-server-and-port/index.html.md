---
layout: post
title: IIS 6 and Apache on the same server and port
date: 2008-04-26
---

This has [been written](http://www.prismix.com/blog/2006/06/running_apache_and_iis_6_toget.cfm) about before, but I just ran into it, and hopefully I can save someone a headache.

![Apache Feather](feather.gif)&#160; 

I installed Apache on my dedicated server, which has 9 IP addresses. Since all my sites have a dedicated IP address, I figured I would just configure Apache to listen on some IP's, and IIS listen on the others. They both would listen on port 80\. I configured it correctly, only to find out that Apache wouldn't start.

It turns out that IIS hogs port 80 on all IP addresses, whether IIS is configured to listen on them or not. Microsoft has a good [knowledge base article](http://support.microsoft.com/default.aspx?scid=kb;en-us;813368&Product=iis60) on the subject, and of course it's by design so it's not going away.

The only thing to remember is that the instructions are for specifying the IP addresses that IIS **_should_** listen on. For some reason, I was thinking the opposite initially, which obviously caused some frustration.