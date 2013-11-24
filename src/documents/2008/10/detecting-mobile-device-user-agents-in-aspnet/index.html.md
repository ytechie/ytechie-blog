---
layout: post
title: Detecting mobile device user agents in ASP.NET
date: 2008-10-14
tags: ["asp.net"]
---

If you're developing a mobile version of your website, usability should be one of your top priorities. Most sites will detect if you're using a mobile device, and automatically redirect you to the mobile version. I'm going to show you how to do this in ASP.NET.

**Detecting a mobile device based on user agent**

The first issue I ran into was coming up with a reliable way to determine if the device is a mobile device based on its user agent. My first urge was to use the detection built into ASP.NET:
    <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:b0d3e005-fefb-4f13-b3b6-cea039c742fd" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">Request.Browser.IsMobileDevice</pre></div>

I immediately lost any trust in this property after it failed to correctly identify Opera Mobile on my Windows Mobile phone. I suspect something similar will happen with the iPhone.

After browsing the [dozens of common mobile device user agents](http://www.zytrax.com/tech/web/mobile_ids.html), I came up with this method:

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:c3b4bae2-2e0f-40ba-957c-d6bc0bc88552" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public static bool IsMobile(string userAgent)
{
	userAgent = userAgent.ToLower();

	return userAgent.Contains("iphone") '
		 userAgent.Contains("ppc") '
		 userAgent.Contains("windows ce") '
		 userAgent.Contains("blackberry") '
		 userAgent.Contains("opera mini") '
		 userAgent.Contains("mobile") '
		 userAgent.Contains("palm") '
		 userAgent.Contains("portable");
}</pre></div>

I realize this method isn't perfect, but I believe it will correctly identify 99% of the mobile devices out there. You simply pass in the user agent, which is easy to get:

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:0cfecb22-f6ae-42fa-960c-c1597a6dc510" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">Request.UserAgent</pre></div>

If you want to be a little more precise, you can come up with your own method by looking at the [list of mobile agents](http://www.zytrax.com/tech/web/mobile_ids.html), or you can use an updated list of mobile devices with detailed specifications. You can find that type of list [here](http://wurfl.sourceforge.net/).

Have a better way to do it? Have a common device that my method doesn't work for? Please let me know in the comments!