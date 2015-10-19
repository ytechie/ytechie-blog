---
layout: post
title: DotNetKicks Blogger integration that actually works!
date: 2008-04-09
---

I found a couple of posts describing how to embed the DotNetKicks &quot;kick it&quot; button into your blogger template:

*   [How to automatically embed DotNetKicks "kick it" links into your Blogger posts.](http://frogsbrain.blogspot.com/2007/07/how-to-automatically-embed-dotnetkicks.html)
*   [DotNetKicks integration into the "New" Blogger.com](http://www2.john.rummellcc.com/2007/03/dotnetkicks-integration-into-new.html)  

However, they DON'T work! It took me a little while to figure it out, because that code was working for the people that posted it. It turns out that they were posting the code in a blog post, and they were not encoding it so that it would show up correctly for the browser.

![Blogger](blogger-logo.png) 

This is the actual code that you need in your template:

	<p><a expr:href='&quot;http://www.dotnetkicks.com/submit/?url=&quot; + data:post.url + &quot;&amp;title=&quot; + data:post.title' expr:id='data:widget.instanceId + &quot;_kickit&quot;' rel='nofollow'><img alt='Submit this story to DotNetKicks' expr:src='&quot;http://www.dotnetkicks.com/Services/Images/KickItImageGenerator.ashx?url=&quot; + data:post.url'/></a></p>

**NOT** this:

	<p><a expr:href='"http://www.dotnetkicks.com/submit/?url=" + data:post.url + "&title=" + data:post.title' expr:id='data:widget.instanceId + "_kickit"'><img alt='Submit this story to DotNetKicks' expr:src='"http://www.dotnetkicks.com/Services/Images/KickItImageGenerator.ashx?url=" + data:post.url'/></a></p>

I tested the corrected code, and it's working great!

Frog's Brain has great instructions how to use this code:

> To add the tag into your post template go to the Template tab under your Blogger accounts Customization section. Select "Edit HTML" and check the "Expand Widget Templates" check box. Scan the template until you find a line that looks something like `<p><data:post.body/></p>`. That is where the Blogger templating engine inserts the body of your post. I inserted my tag to appear directly below the body of my posts but you can play around with whatever position you like by using the "Preview" button. You'll have to save the template to apply the changes when you are satisfied.