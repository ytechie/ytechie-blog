---
layout: post
title: Using C# Yield for Readability and Performance
date: 2009-02-03
---

I must have read about "yield" a dozen times. Only recently have I began to understand what it does, and the real power that comes along with it. I'm going to show you some examples of where it can make your code more readable, and potentially more efficient.

To give you a **very** quick overview of how the yield functionality works, I first want to show you an example without it. The following code is simple, yet it's a common pattern in the latest project I'm working on.

	IList<string> FindBobs(IEnumerable<string> names)
	{
		var bobs = new List<string>();
	
		foreach(var currName in names)
		{
			if(currName == "Bob")
				bobs.Add(currName);
		}
	
		return bobs;
	}

Notice that I take in an IEnumerable<string>, and return an IList<string>. My general rule of thumb has been to be as lenient as possible with my input, and as strict as possible with my output. For the input, it clearly makes sense to use IEnumerable if you're just going to be looping through it with a _foreach_. For the output, I try to use an interface so that the implementation can be changed. However, I chose to return the list because the caller may be able to take advantage of the fact that I already went through the work of making it a list.

The problem is, my design isn't chainable, and it's creating lists all over the place. In reality, this probably doesn't add up to much, but it's there nonetheless.

Now, let's take a look at the "yield" way of doing it, and then I'll explain how and why it works:

	IEnumerable<string> FindBobs(IEnumerable<string> names)
	{
		foreach(var currName in names)
		{
			if(currName == "Bob")
				yield return currName;
		}
	}

In this version, we have changed the return type to IEnumerable<string>, and we're using "yield return". Notice that I'm no longer creating a list. What's happening is a little confusing, but I promise it's actually incredibly simple once you understand it.

When you use the "yield return" keyphrase, .NET is wiring up a whole bunch of plumbing code for you, but for now you can pretend it's magic. When you start to loop in the calling code (not listed here), this function actually gets called over and over again, but each time it resumes execution where it left off.

**Typical Implementation**

1.  Caller calls function
2.  Function executes and returns list
3.  Caller uses list

**Yield Implementation**

1.  Caller calls function
2.  Caller requests item
3.  Next item returned
4.  Goto step #2

Although the execution of the yield implementation is a little more complicated, what we end up with is an implementation that **"pulls"** items one at a time instead of having to build an entire list before returning to the client.

In regards to the syntax, I personally think the yield syntax is simpler, and does a better job conveying what the method is actually doing. Even the fact that I'm returning IEnumerable tells the caller that its only concern should be that it can "foreach" over the return data. **The caller can now make their own decision** if they want to put it in a list, possibly at the expense of performance.

In the simple example I provided, you might not see much of an advantage. However, you'll avoid unnecessary work when the caller can "short-circuit" or cancel looping through all of the items that the function will provide. When you start chaining methods using this technique together, this becomes more likely, and the amount of work saved can possibly multiply.

Ayende has a great example of [using yield for a slick pipes & filters implementation](http://ayende.com/Blog/archive/2008/01/05/Pipes-and-filters-The-IEnumerable-appraoch.aspx). He even has a [version that is multi-threaded](http://ayende.com/Blog/archive/2008/01/06/Pipes-and-filters-The-multi-threaded-version.aspx) which I find very intriguing.

One of my first reservations with using yield was that there is a potential performance implication. Since c# is keeping track of what is going on in what is essentially a state machine, there is a bit of overhead. Unfortunately, I can't find any information that demonstrates the performance impact. I do think that the potential advantages I mentioned should outweigh the overhead concerns.

###Conclusion

Yield can make your code more efficient and more readable. It's been around since .NET 2.0, so there's not much reason to avoid understanding and using it.

You can find detailed information about [how the yield keyword works under the hood here](http://startbigthinksmall.wordpress.com/2008/06/09/behind-the-scenes-of-the-c-yield-keyword/).

Have you been using yield in interesting ways? Have you ever been bitten by using it? Leave a comment and let me know!