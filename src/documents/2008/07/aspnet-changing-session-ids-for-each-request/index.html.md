---
layout: post
title: ASP.NET Changing Session ID's for each request
date: 2008-07-30
---

I ran into an issue where ASP.NET was changing the Session.SessionId for every request from the same user. A quick Google search revealed 2.3 million pages. I'll summarize one of the main reasons this can happen, and discuss 2 ways to fix it.

![Hand-Counting](hand-counting-thumb.jpg)

I've been working on a search function for a website I'm working on. We're taking the [Lean software approach](http://en.wikipedia.org/wiki/Lean_software_development) and implementing an extremely basic search for now. We're going to track the searches that users are making, and will have the data we'll need to make a better search in the next version.

In order to know if users are making multiple searches, we're storing the ASP.NET session ID with the search record in the database. Much to my dismay, every search request resulted in a different value in _Session.SessionId_.

The problem lies in the fact that ASP.NET is trying to be extremely efficient storing sessions for users. **If ASP.NET doesn't have a reason to remember who you are, it won't**. If you think about it, that can save a tremendous amount of work by avoiding session management.

If you want to tell ASP.NET that you want it to track user sessions, you can do one of 2 things:

1.  Store something in the session. If you store something in the users session, ASP.NET will be forced to associate that data with your current visit. Example code: `Session["foo"] = "bar";`
2.  Simply by handling the _Session_Start_ event in your _Global.asax_. The presence of this method will tell ASP.NET to track sessions, even if there is no data in the session.

	public void Session_Start(object sender, EventArgs e)
	{
	}