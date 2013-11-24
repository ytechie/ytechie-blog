---
layout: post
title: Generic Method Overloading Selection Pitfall
date: 2009-01-02
---

Recently I ran into a very unexpected behavior when working with an overloaded generic method. Basically, the selection process for overloaded versions of generic methods is different than their non-generic counterparts.

First, lets look at how a regular overloaded method signature is matched. Consider the following methods:
 <div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:93ce4982-b9d1-4a90-891e-0e71847a8cb5" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public void a(object obj)
{}

public void a(IEnumerable enumerable)
{}</pre></div>

If we call the method "a" with a class that implements IEnumerable such as an array or a List, the **second** version will be called. Basically, the compiler matches the method that is the most specific.

Now, consider the generic versions of the same methods:

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:4a55c4aa-2141-459a-8169-26b62ab9c29f" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">public void a&lt;T&gt;(T obj)
{}

public void a&lt;T&gt;(IEnumerable&lt;T&gt; enumerable)
{}</pre></div>

Now, if we pass in a generic list such as "List&lt;string&gt;", you might expect the second version to be called. Unfortunately, you would be **wrong**. The first version of the method is called. There are two ways to force the second version to be used:

<div class="wlWriterSmartContent" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:bbf00244-70e4-43b8-b0c2-a52d16268774" style="padding-right: 0px; display: inline; padding-left: 0px; float: none; padding-bottom: 0px; margin: 0px; padding-top: 0px"><pre name="code" class="c#">a((IEnumerable&lt;string&gt;)new List&lt;string&gt;());
a&lt;string&gt;(new List&lt;string&gt;());</pre></div>

As you can see, you can either cast the generic list specifically to a generic IEnumerable, or you can specify the type parameter on the generic method.

What you're seeing is a subtle difference in the way method overloading is handled with generic methods vs non-generic methods. Standard method overloading picks the match at compile time, and chooses the most specific, or "best" match. When you don't specify a type parameter for a generic call, it type inference to determine the correct signature to call. Unfortunately, it chooses the most direct route, not the most specific match.

**Workarounds**

I've already mentioned the ways that you can work around this issue by modifying the way that you make the call to the generic method. Unfortunately, you're relying on knowledge that the caller must have. If you want to avoid ambiguity, do not use standard method overloading. You can see that the authors of Linq to SQL must have ran into the same issue. Take a look at "[InsertOnSubmit](http://msdn.microsoft.com/en-us/library/system.data.linq.itable.insertonsubmit.aspx)" vs "[InsertAllOnSubmit](http://msdn.microsoft.com/en-us/library/system.data.linq.itable.insertallonsubmit.aspx)". If it was easy to use method overloading for that scenario, that would have been a great opportunity for simplification.

**Conclusion**

I recommend being very careful when overloading generic methods. There are a lot of hidden side-effects that can occur. I also recommend checking out another post, which talks about the [effects of overloading non-generic methods with generic methods](http://shiman.wordpress.com/2008/07/07/generic-method-overload-a-trap-for-c-net-library-developers/). Don't be ambiguous when writing code that other developers may call. Make your code easy to use, but also clear as to which code path will be taken.