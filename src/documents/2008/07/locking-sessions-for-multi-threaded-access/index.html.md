---
layout: post
title: Locking sessions for multi-threaded access
date: 2008-07-10
---

I recently ran into a situation where I needed to upload some small files from a Flex client application to an ASP.NET web server. I decided to store the uploaded files in the users session while they were in the checkout process. Once the user confirms their order, the images are read from the session and stored to the database.

Here is the original code from the page that accepts each uploaded file, and adds it to a Dictionary in the collection:

	if (Session[SESSION_ORDER_FILES] == null)
	{
		//Our dictionary hasn't been created, so we do it now
		files = new Dictionary<string, byte[]>();
		Session[SESSION_ORDER_FILES] = files;
	}
	else
	{
		//The dictionary has already been created, just load it
		files = (Dictionary<string , byte[]>) Session[SESSION_ORDER_FILES];
	}

	//If we have the "_clearPrevious" flag, that means all
	//of the files should be removed from this users session
	if (_clearPrevious)
		files.Clear();
	
	//If the file name is the same, replace it
	if (files.ContainsKey(_fileName))
		files.Remove(_fileName);
	
	files.Add(_fileName, bytes);

The problem is that we ended up with missing images. The client was sending them, but when the user confirmed their order they were missing images in the session. Since ASP.NET will process page requests in multiple threads, **the session can be accessed in multiple threads**!

Now, we need to find a way to lock them. I questioned whether ASP.NET would give me the same session object each time, or a new instance representing the same session. I whipped up this code in a test page. It saves the previous session reference to the session. I know it's a little strange, but since no serialization happens with the session, it gave me a good way to know if the previous session object and the current session object were **the same instance**.

	const string SESS_SESS = "test";
	var currSessionObj = Session[SESS_SESS];
	
	if(currSessionObj == null)
		//First page load
		Session[SESS_SESS] = Session;
	else
		lblText.Text = (Session[SESS_SESS] == Session).ToString();

The result of this page was **false**. That means you most certainly do **get a new session instance each time**. Keep in mind that I'm not saying it's a different session, the object you're accessing the session with simply changes.

### What does this mean?

This means that you have to be careful when there is a chance that you're working with session objects in multiple pages, or in a page that could be accessed multiple times simultaneously. Thankfully, there are only a few real-world scenarios where this would be a large concern.

As with any other kind of multi-threaded code, be careful if you're checking the session, and then performing an action based on the result. In that case, you'll need to lock a global object that is available to all threads that could access that code. Here is an example:

	lock(Global.SessionLock)
	{
		if(Session["foo"] == null)
			Session["foo"] = new Bar();
	}

In your Global class, you'll need this field: 

	static object SessionLock = new object();