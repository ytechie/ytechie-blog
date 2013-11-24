---
layout: post
title: Extension Methods & Single Responsibility Principle
date: 2009-01-26
---

Extension methods were a new feature in .NET 3.0 (they are also supported by the 2.0 CLR). The single responsibility principle (SRP) is a strategy for structuring our code to make it more maintainable and testable. In this post, I'm going to discuss how we can use extension methods to make our code easier to read and satisfy the idea behind SRP.

As I mentioned, extension methods were a new feature in .NET 3.0, and they're [compatible with the 2.0 CLR](http://www.danielmoth.com/Blog/2007/05/using-extension-methods-in-fx-20.html). They're backwards compatible because they're simply a compiler trick. In fact, you may already have methods that are only one step away from being considered extension methods.

Here is a method that is **not an extension method** (we'll come back to those in a bit):

	public static Report GenerateReport(ReportData data)
	{
		//Create a report from the report data
	}

A method like this is useful because it avoids cluttering another class with unrelated functionality. Imagine the opposite situation in which case the report data class is responsible for the data in the report, as well as the formatting of the report. The [single responsibility principle](http://en.wikipedia.org/wiki/Single_responsibility_principle) tells us that we should separate the operations so that each class has only one reason to change. In practice, I have personally seen the advantages in code maintainability, readability, and testability. I won't delve deeply into the supporting information in this post.

So how do extension methods come into play? As I mentioned, they're simply a compiler trick. If we wanted to convert the aforementioned static method into an extension method, we simply add the "this" keyword before the first parameter, which is the type that our method is acting on:

	public static Report GenerateReport(this ReportData data)
	{
		//Create a report from the report data
	}

Now we've added an additional way to call our method:

	var reportData = new ReportData();

	//Old way of calling - still works in either case
	var r = GenerateReport(reportData);
	//New way of calling with extension method
	var r = reportData.GenerateReport();

Our method still works the way it always did when it was static, but now we have an additional way to call it. It's also important to note that the extension method doesn't have any extra permissions in regards to accessing the other class. It has to use its publicly exposed interface. In fact, if we wanted to rely simply on the interface instead of the implementation, we could modify our extension data to work on an interface such as IReportData.

The entire reason that extension methods exist is to make the calling syntax easier to read. The driving force was the new LINQ functionality. In particular, chaining the old static method syntax quickly becomes cumbersome.

The new extension method syntax allows us to make the calling code more elegant, and yet organize our methods so that there are clear boundaries between the pieces of functionality that we're wiring together. Extension methods are obviously not always the best way to follow SRP, but they certainly give you a new tool in your toolbox.