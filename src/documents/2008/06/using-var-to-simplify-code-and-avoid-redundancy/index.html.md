---
layout: post
title: Using "var" to simplify code and avoid redundancy
date: 2008-06-25
tags: ["c#","productivity"]
---

You've probably already heard of the new &quot;var&quot; keyword that you can use to declare variables in your .NET code. I wanted to clear up some quick myths and give a quick overview of when it's most valuable.

If you haven't heard of it, you can now use this syntax:
  <pre class="c-sharp" name="code">var c = new Cat();</pre>

Instead of this:

<pre class="c-sharp" name="code">Cat c = new Cat();</pre>

As Jeff Atwood mentioned, it's a [great way to avoid redundancy](http://www.codinghorror.com/blog/archives/001136.html). It's obvious that you're creating a &quot;Cat&quot; object, why do you have to say it twice?

The most important thing to realize, is that it's NOT a var like in JavaScript or other languages ([DIM in VB](http://www.hanselman.com/blog/BackToBasicsVarDim.aspx)). It really is 100% a &quot;Cat&quot; object, complete with intellisense. The generated IL would be no different than specifying the type when you declare it. **It's simply a compiler trick**.

Another important thing to remember is that you the assignment must be combined with the declaration. If that wasn't the case, readability would be very poor.

<pre class="c-sharp" name="code">var myName = &quot;Jason&quot;; //Allowed
var yourName; //Not allowed
yourName = &quot;Bob&quot;; //Glad you can't do this</pre>

What are some really good examples of when it ideally should be used:

<pre class="c-sharp" name="code">List&lt;Dictionary&lt;int, string&gt;&gt; customers = new List&lt;Dictionary&lt;int, string&gt;&gt;(); //Yuck!
var customers = new List&lt;Dictionary&lt;int, string&gt;&gt;(); //Yay!

OrderRepository orderRepo = (OrderRepository)ctx.GetObject(&quot;orderRepository&quot;); //Yuck!
var orderRepo = (OrderRepository)ctx.GetObject(&quot;orderRepository&quot;); //Yay!

string name = &quot;Jason Young&quot;; //Kinda yucky
var name = &quot;Jason Young&quot;; //Kinda better</pre>

As you can see, those examples have obvious redundancy. Using the &quot;var&quot; keyword increases readability, and makes it easier to change if needed.

There are certainly times when its use is questionable. In the following example, I'm calling a function that returns some data. Since I'm not explicitly defining the type that is being returned from that function, I have to do some digging to figure out the type being returned. In this case, you'll have to define the correct way to handle it in your coding standards.

<pre class="c-sharp" name="code">var data = GetData();</pre>

Another potential readability issue comes up in the following case. You might not want to use the &quot;Circle&quot; specific methods (Circle inherits from Shape).

<pre class="c-sharp" name="code">Shape s = GetCircle(); //I see what you're doing
var s = GetCircle(); //Do you want a shape, or a circle?</pre>

Aside from a couple of decisions that need to be made in your organization, I think this is a great addition, and should make our lives as developers a little bit easier. It's just another tool for our toolbelt. With great power comes great responsibility