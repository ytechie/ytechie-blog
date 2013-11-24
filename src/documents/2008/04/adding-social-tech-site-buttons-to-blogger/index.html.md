---
layout: post
title: Adding social tech site buttons to Blogger
date: 2008-04-24
tags: ["blogger","blogging"]
---

[ObiShawn](http://www.obishawn.com) asked me how I added the buttons at the end of each post for the social tech sites. You can look at the end of this post to see what I mean.

It's simple!

Edit the HTML for your template (Layout -&gt; Edit HTML), click on &quot;Expand Widget Templates&quot;. Look for this code:
  <pre class="xml" name="code">&lt;p&gt;&lt;data:post.body/&gt;&lt;/p&gt;</pre>

Immediately after that code, add this:

<pre class="xml" name="code">
&lt;p&gt;&lt;a expr:href='&amp;quot;http://www.dotnetkicks.com/submit/?url=&amp;quot; + data:post.url + &amp;quot;&amp;amp;title=&amp;quot; + data:post.title' expr:id='data:widget.instanceId + &amp;quot;_kickit&amp;quot;' rel='nofollow'&gt;&lt;img alt='Submit this story to DotNetKicks' expr:src='&amp;quot;http://www.dotnetkicks.com/Services/Images/KickItImageGenerator.ashx?url=&amp;quot; + data:post.url'/&gt;&lt;/a&gt;
&lt;br/&gt;
&lt;script type='text/javascript'&gt;
var dzone_url = &amp;#39;&lt;data:post.url/&gt;&amp;#39;;
var dzone_title = &amp;#39;&lt;data:post.title/&gt;&amp;#39;;
var dzone_style = &amp;#39;2&amp;#39;;
&lt;/script&gt;
&lt;script defer='defer' src='http://widgets.dzone.com/widgets/zoneit.js' type='text/javascript'&gt; &lt;/script&gt;
&lt;br/&gt;
&lt;script type='text/javascript'&gt;
digg_url = &amp;quot;&lt;data:post.url/&gt;&amp;quot;;
digg_title = &amp;quot;&lt;data:post.title/&gt;&amp;quot;;
digg_skin = &amp;quot;compact&amp;quot;;
&lt;/script&gt;
&lt;script defer='defer' src='http://digg.com/tools/diggthis.js' type='text/javascript'/&gt;
&lt;/p&gt;
</pre>

That's the exact code I'm using in my template at the time of this post. It's not visually perfect, but it works.