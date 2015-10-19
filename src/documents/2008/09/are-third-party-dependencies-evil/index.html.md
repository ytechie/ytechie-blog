---
layout: post
title: Are third party dependencies evil?
date: 2008-09-10
---

I recently posted about a problem I had with the [Microsoft CTP DataGrid I was using](http://www.ytechie.com/2008/09/disabling-wpf-datagrid-virtualization/). I quickly got a response from Odi from Xceed, [asking why I wasn't using theirs](http://www.ytechie.com/2008/09/disabling-wpf-datagrid-virtualization/). Good question, and deserves it's own blog post.

[![xceed DataGrid](image.png)](http://xceed.com/Grid_WPF_Intro.html) 

The truth is, I've been burned by third party controls in the past. In general, third party controls work _great_ when used in the sterile lab environment. The problem is, it seems like every project I work on has some requirements that tend to break them.

For example, a recent website I worked on had a requirement that every page had to have an HTML extension, even though every page was an ASPX page. Depending on how it's implemented, many third party controls just couldn't handle it. In fact, it's hard enough to get the core ASP.NET functionality working properly with some features such as postbacks. Adding poorly written third party components would have made things worse.

Ok, so why is it alright to use Microsoft's controls instead of something from a third party? In **my experience**, the code the Microsoft gives you tends to be lacking in real functionality, but is usually very reliable. Even when they've had an issue, there was enough support to get a work-around, and probably a fix in the next service pack. Microsoft products tend to get better over time, and without any upgrade fees. They are a well established business with a **guaranteed audience**.

![The 500 lb Gorilla](image-thumb.png)

Let's take the .NET TextBox as an example. Ever run into a situation where you've found it to be unreliable? I haven't. I have run into a situation where a third party alternative had all the bells and whistles you could think of, but had some major issues. You push the up arrow and the application bombs. Darn. You could only use it in a certain way, or it wouldn't work at all.

**[K.I.S.S - Keep it simple, stupid](http://en.wikipedia.org/wiki/KISS_principle)**

Is this a rule, or a good practice to follow? Depends what you need. I use third party dependencies all the time. I typically only use them if they're in widespread use, mature, and under current development so I know fixes will be round the corner. For example, here are a couple of great ones that I recommend:

* Log4net
* NHibernate
* RhinoMocks
* Spring.NET  

If you're curious what criteria I use when looking for a third party control, be sure to check out my post about [10 things to look for when evaluating third party controls](http://www.ytechie.com/2008/04/10-things-to-look-for-when-searching-for-net-controls/).

In general, I think [Joel has a good guideline](http://www.joelonsoftware.com/articles/fog0000000007.html):

  > If it's a core business function -- do it yourself, no matter what.

I've tried desperately to come up with a great example of when his rule doesn't work. At one of my previous jobs, I wrote a lot of reports using complex charting. We had a great third party charting library, but we always had strange ways of working around its interface. It's probably the best example that I might have to counter his rule, but it probably wouldn't have taken any more time if we had written the charting ourselves.

### Conclusion

If you need a quick and dirty simple control, and it's already part of your toolbox in Visual Studio, just use it. If you outgrow it, or have some special requirements, see what is out there. In my case, I think the Xceed grid would have been overkill. Microsoft will fix their bugs, and my application will only get better. If you need a grid that does more than display some simple data, take a look at what Xceed or another vendor offers. Their control has certainly been around the block, and looks like it has a lot more features.