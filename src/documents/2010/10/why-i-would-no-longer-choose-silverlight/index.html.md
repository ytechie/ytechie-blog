---
layout: post
title: Why I Would no Longer Choose Silverlight
date: 2010-10-28
---

I recently spoke to some of the wonderful guys on the ASP.NET team over at Microsoft (@[shanselman](http://twitter.com/shanselman) @[haacked](http://twitter.com/haacked) and others). Somebody asked if anyone had any complaints they wanted to share. I brought up the topic of Silverlight since it's been on my mind recently.

![](Microsoft_Silverlight.jpg)

I would like to make it clear that the product we built with it is still amazing, and Silverlight has a lot to do with that. Silverlight is a solid product that has reflected the amount of effort that the developers put into it.

When I was originally confronted with the decision of building our user interface in Silverlight or HTML, I chose Silverlight for the following reasons:

*   It's the cool thing to do*   Perceived fast development*   User interface performance without having to touch "icky" JavaScript  

Now that the first commercially available version of our software is available, I can't help but admit some regret with the choice to use Silverlight.

The bottom line for me comes down to the fact that HTML runs **everywhere**, and Silverlight runs **some** places.

It's becoming abundantly clear that the future of computing is in a wide variety of form factors, and they're getting smaller. iPads, tablets/slates, iPhones, Android Phones, Microsoft phones, etc. are all widely available. Even Microsoft's own Windows CE devices don't support the Silverlight we know and love. These new types of mobile devices are showing us that the future it not just staring at a 19" screen. Our own Silverlight front-end is not only un-optimized for these devices, but worse yet, it doesn't work, period.

So is the HTML story better? I believe it is. Let's examine my original reasons for going to Silverlight:

*   **It's the cool thing to do **- I believe this gap is closing. jQuery and other animation and scripting tools are making cross platform development reliable and easy to develop. The proliferation of web standards has been helpful as well.
*   **Perceived fast development** - My mistake here was thinking that since we didn't have to deal with HTML, CSS, and JavaScript issues, we would be able to develop much quicker. The reality is that the time we would have spent on those issues is now spent dealing with another layer of misdirection. We now have to get the data from our database to the web server, but then we have to get it to the client. This is all while managing the subtleties of RIA services and LINQ to SQL objects. ASP.NET MVC removes one layer of mapping and complexity (we can _optionally_ add layers obviously).
    On notable exception to this is our scheduling interface. We're using the wonderful [Telerik scheduler](http://demos.telerik.com/silverlight/#Scheduler/FirstLook), which really shows when Silverlight can shine compared to an equivalent HTML page.
*   **User interface performance** - Silverlight wins this one. We're doing some amazing things with layout transforms that really wows our customers. The easy animations will be about the same amount of work in JavaScript, but the more complex animations will likely be easier in Silverlight.  

Most of my reasons make common scenarios a wash (or possibly in favor of Silverlight). However, there are reasons that I'm avoiding Silverlight going forward:

*   **It doesn't run well on Linux, CE, iPad, etc** - This is huge. Unless you have a captive audience, you'll want to make sure that your application runs on the newest devices. HTML is the only sure bet.*   **Memory leaks/issues** - This one really irks me. I'm sure that there are issues in our code that cause some leaks, and I'm sure some can be attributed to this [seemly unsolvable issue](http://forums.silverlight.net/forums/t/171739.aspx). We have a screen that stays open on a touchscreen, and it consumes all the memory on the machine within half a day. The bottom line is that these simply don't happen in HTML.
*   **Initial load hit** - I know there are ways to mitigate this in Silverlight by spreading your application over multiple XAP files. However, HTML is the better choice for slow connections. The slow speed is spread throughout the screens, instead of switching between fast and slow.  

In conclusion, all of the amazing reasons that I went with Silverlight have faded, and now I'm left with the reality of a platform that will never achieve 100% accessibility. There are plenty of situations where Silverlight may be the perfect fit, but next time I wont be as quick to lean toward Silverlight without serious consideration as to the potential audience and goals.