---
layout: post
title: Value type comparison pitfall with == vs Equals
date: 2009-02-11
---

I recently ran into a situation that momentarily confused me, because it was non-intuitive to me at first. I'm working on a class that tracks changes made in UI controls in Silverlight, and I wrote code similar to the following:

	private void checkChanges(UIElement control)
	{
		object oldValue = getOldValue(control);
		object newValue = getNewValue(control);
	
		if(oldValue == newValue)
			return;
	
		Debug.WriteLine("The value has changed");
	}

The data type I was working with in this case was a _DateTime_, which happens to be Struct, which is a [value type](http://msdn.microsoft.com/en-us/library/34yytbws.aspx). I know that this code works as expected:

	DateTime time1 = DateTime.Parse("1-1-09");
	DateTime time2 = DateTime.Parse("1-1-09");
	
	//This is true
	Assert.IsTrue(time1 == time2);

The code above works because I'm comparing 2 _DateTime_ structures. The original code does not work because **the structures are being boxed**, in other words, they're wrapped in objects. When you use "==" on two objects, it's comparing the memory references, determining if they're the same instance. In this case, the _DateTime_ objects are each boxed into separate boxes.

The workaround is to use the "Equals" method which exists on all objects, and is overridden for the most common framework elements you'll use. For example, _DateTime_ overrides ._Equals_ to determine if the date/times are equivalent.

So if I wanted to fix my original code, it would look like this:

	private void checkChanges(UIElement control)
	{
		object oldValue = getOldValue(control);
		object newValue = getNewValue(control);
	
		if(oldValue.Equals(newValue))
			return;
	
		Debug.WriteLine("The value has changed");
	}

Of course this problem applies to all values types such as int, double, and any custom structs you may have created.

It goes without saying that this pitfall is not an issue when you're working with reference types, because they have no need to be boxed.