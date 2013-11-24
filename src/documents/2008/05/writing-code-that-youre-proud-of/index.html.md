---
layout: post
title: Writing code that you're proud of
date: 2008-05-16
tags: ["software development"]
---

Almost every time that someone shows me a snippet of their code, I hear a comment like this:

*   &quot;This isn't finished, I have a lot of cleanup to do&quot;*   &quot;I wrote this code a long time ago, it's not very good&quot;*   &quot;Ignore all these bugs, I haven't had time to fix them yet&quot;  

We've all done it. It's very rare that I hear a developer that is truly proud of their code.

![Copyright](istock-000005549387xsmall.jpg)

So why aren't you proud of your code? Part of the reason is that we often combine planning with writing code. I know that purists don't like that, but the reality is that there are so many details in software that _perfect_ planning is impossible.

The other reason is that we get our code working, and keep telling ourselves that we'll go back and clean it up later. Then you tell yourself &quot;why fix it if it isn't broken?&quot; You move on to the next task, and the cycle continues.

Common things that are overlooked:

*   Proper exception handling and failure modes*   Properly disposing of unmanaged resources (IDisposable)*   Inefficient coding style*   Missing documentation*   Well thought out architecture*   Comprehensive unit tests & code coverage
*   Following established coding standards
*   Simplifying to minimize LoC to maintain  

This post was inspired by a number of personal projects that I'm releasing as open source. I found myself doing a lot of cleanup work before uploading the source. I'm regretting not spending more time on it when I had written it.

So here is my challenge for you. Write code that you're proud of! Do a personal code review before checking in your code. Then do a peer code review. If you're embarrassed by the code you've written, go back and fix it. It's commonly known that fixing the problems early on will have massive returns in the long run.