---
layout: post
title: Adding social tech site buttons to Blogger
date: 2008-04-24
tags: ["blogging"]
---

[ObiShawn](http://www.obishawn.com) asked me how I added the buttons at the end of each post for the social tech sites. You can look at the end of this post to see what I mean.

It's simple!

Edit the HTML for your template (Layout -> Edit HTML), click on 'Expand Widget Templates". Look for this code:

	<p><data:post.body/></p>

Immediately after that code, add this:

	<p><a expr:href='&quot;http://www.dotnetkicks.com/submit/?url=&quot; + data:post.url + &quot;&amp;title=&quot; + data:post.title' expr:id='data:widget.instanceId + &quot;_kickit&quot;' rel='nofollow'><img alt='Submit this story to DotNetKicks' expr:src='&quot;http://www.dotnetkicks.com/Services/Images/KickItImageGenerator.ashx?url=&quot; + data:post.url'/></a>
	<br/>
	<script type='text/javascript'>
	var dzone_url = &#39;<data:post.url/>&#39;;
	var dzone_title = &#39;<data:post.title/>&#39;;
	var dzone_style = &#39;2&#39;;
	</script>
	<script defer='defer' src='http://widgets.dzone.com/widgets/zoneit.js' type='text/javascript'> </script>
	<br/>
	<script type='text/javascript'>
	digg_url = &quot;<data:post.url/>&quot;;
	digg_title = &quot;<data:post.title/>&quot;;
	digg_skin = &quot;compact&quot;;
	</script>
	<script defer='defer' src='http://digg.com/tools/diggthis.js' type='text/javascript'/>
	</p>

That's the exact code I'm using in my template at the time of this post. It's not visually perfect, but it works.