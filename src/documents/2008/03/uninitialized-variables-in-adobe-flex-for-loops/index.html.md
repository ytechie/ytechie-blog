---
layout: post
title: Uninitialized variables in Adobe Flex "for" loops
date: 2008-03-31
---

	for(var j:int; j < editAreas.length; j++)
	    trace("doing something");

What's wrong with this ActionScript code? This was a block of code that I fixed while tracking down a nasty bug. c# would have never let me do this.

![image](no-bugs.png)

Basically, the "j" variable starts out at 0 in the method. That's fine, because it's what I would normally expect. The problem is that I have it declared inside another loop, so this loop initializer is run multiple times. The second time around, "j" maintains it's value. It could start at 5 next time. The loop still partially works, if the length of the arrays get longer each time. It's a bit odd that the "j" variable is never created more than once. I'm guessing it's a compiler optimization.

This loop was used in a drawing routine for images. If you had an image in the first drawing area, the first image in the consecutive drawing areas would never be drawn.

It should be obvious, but please don't forget to initialize your "for" loop variables.