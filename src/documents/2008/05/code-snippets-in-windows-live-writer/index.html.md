---
layout: post
title: Code Snippets in Windows Live Writer
date: 2008-05-21
---

I was asked how I insert code snippets with Windows Live Writer. I actually did it the hard way. I wrote a Windows Live Writer plug-in, and then I found out someone had already [done the same thing](http://www.codeplex.com/wlwSyntaxHighlighter).

I originally got scared away from it because when I switch to the HTML view in Live Writer, it shows up like this:

	<div class="wlWriterEditableSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:19d17d14-ac74-45e7-9276-5c6a3031b09d" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><DIV class=dp-highlighter>
	<DIV class=bar>
	<DIV class=tools><A onclick="dp.sh.Toolbar.Command('ViewSource',this);return false;" href="about:blank#">view plain</A><A onclick="dp.sh.Toolbar.Command('CopyToClipboard',this);return false;" href="about:blank#">copy to clipboard</A><A onclick="dp.sh.Toolbar.Command('PrintSource',this);return false;" href="about:blank#">print</A><A onclick="dp.sh.Toolbar.Command('About',this);return false;" href="about:blank#">?</A></DIV></DIV>
	<OL class=dp-xml>
	<LI class=alt><SPAN><SPAN>test&nbsp;&nbsp;</SPAN></SPAN></LI></OL></DIV><PRE class=xml style="DISPLAY: none" name="code">test</PRE>

That is just unacceptable. Fortunately, I realized that it just renders that _temporarily,_ so that you can see a better preview of what it will actually look like on your site.

When you post it, it still has the annoying **div** above the **pre**, but I can live with that. All of the other added tags are not there, and you just get your code wrapped in a nice **pre**. I'm assuming it's there so that it recognizes that as a code block if you want to edit it later.

I like the [SyntaxHighlighter](http://code.google.com/p/syntaxhighlighter/) code because it uses JavaScript to parse apart the code and add in the appropriate styles. It's a nice separation between content and presentation.

I do recommend that if you use the [SyntaxHighlighter](http://code.google.com/p/syntaxhighlighter/), that you combine the JavaScript files into one, and then run it through a JavaScript compressor. That will minimize file sizes and page requests.

For example, in this blog, I simply include this in each page:

	<link href='http://www.young-technologies.com/sh/SyntaxHighlighter.css' rel='stylesheet' type='text/css'/>
	<script src='http://www.young-technologies.com/sh/sh.js' type='text/javascript'></script></pre></div>

Before the body tag, I then use this code:

	<script type='text/javascript'>
		dp.SyntaxHighlighter.ClipboardSwf = 'http://www.young-technologies.com/sh/clipboard.swf';
		dp.SyntaxHighlighter.HighlightAll('code');
	</script>

This has been working great on my site. Hope that helps you out!