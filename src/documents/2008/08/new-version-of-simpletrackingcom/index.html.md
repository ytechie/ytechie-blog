---
layout: post
title: New Version of SimpleTracking.com
date: 2008-08-27
---

I recently released a new version of [SimpleTracking.com](http://www.simpletracking.com/). Here are the highlights:

* Nearly a complete rewrite, making the code far more [modular and manageable](http://www.ytechie.com/2008/06/a-dependency-injection-example-with-springnet/).
* Nearly 100% unit tested code base.
* Dedicated hosting instead of shared hosting. This means that the speed and reliability has increased quite a bit. The site used to go down a couple times a day for a minute or two at a time.
* Automatic fail-over. If the site goes down, within a matter of minutes, a completely different hosting provider kicks in and takes over. This is done through [a DNS fail-over service](http://www.dnsmadeeasy.com/s0306/prod/dnsfosm.html). 

![image](image-thumb.png)

I also set up a [feedback page](http://feedback.simpletracking.com/) (using UserVoice), that allows you to vote for the features that you would like to see on the site. This is really going to help me decide if and where to focus my time. Please head over there and get voting and suggesting!