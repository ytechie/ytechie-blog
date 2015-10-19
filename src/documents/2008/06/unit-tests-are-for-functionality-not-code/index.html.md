---
layout: post
title: Unit tests are for functionality, not code!
date: 2008-06-12
---

[Shawn](http://blog.obishawn.com/) has an interesting post where he talks about [why 100% unit test coverage should be one of your goals](http://blog.obishawn.com/2008/06/why-you-should-have-100-code-test.html). I agree 100%. I'm not sure why anyone would say that you shouldn't be testing your properties. Don't you want to make sure they work?

![Unit-Testing](unit-testing.jpg) 

The prevailing philosophy in regards to unit testing is writing your tests before your code. In practice, this happens a lot less than it should. Why _should_ we write our unit tests first?

* Writing your unit tests first makes you **design pieces of your software from the clients perspective**. After all, you're writing your code to be consumed. The code itself is not important, it's what it does for other code.
* **Unit tests are meant to test functionality, NOT code!** That means if you write your unit tests after the fact, you're probably not focusing on the functionality. You might be trying to come up with edge cases that might not even matter to the client. It's harder to come up with good unit tests after the code is written, because you're not necessarily looking at it from the clients perspective, or from the perspective of the required functionality.  

There are two valid ways to increase code coverage:

*   **Write additional tests** - This only makes sense if you forgot to write the test initially. Since you're tests are verifying functionality, why don't you already have a test for this particular piece of functionality?*   **Remove the untested code** - In a perfect world, this is what you would always do. After all, your tests verify that your code has a certain set of functionality. If you have untested code, that code isn't needed. Why keep code you don't need?  

Here is the basic process I recommend:

1.  Come up with a rough design in your head
2.  Write unit tests to test a required piece of functionality
3.  Write the code to provide that functionality
4.  Verify that the unit tests pass, fix the code as necessary
4.  Refactor as necessary
5.  Run a code coverage tool, and get as close to 100% as possible using one of the methods I mentioned previously.
6.  Go to #2 and repeat as necessary