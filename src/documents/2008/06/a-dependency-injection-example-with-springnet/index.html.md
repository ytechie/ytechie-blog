---
layout: post
title: A Dependency Injection example with Spring.NET
date: 2008-06-13
tags: ["c#","productivity","unit testing"]
---

As requested, here is a real world example of how I used [dependency injection](http://www.ytechie.com/2008/06/i-finally-get-the-point-of-inversion-of-control.html) to simplify a project, increase modularity, and subsequently increase testability.

Here's the project. I have a successful website called [SimpleTracking.com](http://www.SimpleTracking.com) which allows you to [track packages](http://www.SimpleTracking.com) using a simple, common user interface. It also allows you to track pages using RSS.

Here is a list of features:

*   Supports multiple shippers, including FedEx, DHL, and USPS. The tracking number is resolved to one of them, and if a tracking number could belong to more than one, they are called simultaneously, and the one that returns the results is used.*   Results are cached to avoid overusing the shippers servers*   Errors are handled appropriately  

I boiled the design into a tree of classes:

&#160;![image](image1.png) 

To greatly simply the design, I decided that each module would implement a common interface. After all, they all take in a tracking number, and return tracking data. Here is the ITracker interface:
  <pre class="c-sharp" name="code">public interface ITracker
{
	TrackingData GetTrackingData(string trackingNumber);
}</pre>

Simple enough? **Every **class in the diagram above implements the same interface. If I want to add additional functionality, such as logging for example, I can simply add a class to the chain, and implement the same interface.

Now I can wire it up with Spring.NET:

<pre class="xml" name="code">&lt;object name=&quot;postUtility&quot; type=&quot;YTech.ShipperInterface.Tracking.Http.PostUtility, YTech.ShipperInterface&quot; /&gt;

&lt;!-- The trackers that actually do the work --&gt;
&lt;object name=&quot;uspsTracker&quot; type=&quot;YTech.ShipperInterface.Usps.Tracking.UspsTracker, YTech.ShipperInterface&quot;&gt;
	&lt;constructor-arg ref=&quot;postUtility&quot; /&gt;
	&lt;!-- Code removed for readability... --&gt;
&lt;/object&gt;
&lt;object name=&quot;fedexTracker&quot; type=&quot;YTech.ShipperInterface.FedEx.Tracking.FedexTracker, YTech.ShipperInterface&quot;&gt;
	&lt;constructor-arg ref=&quot;postUtility&quot; /&gt;
	&lt;!-- Code removed for readability... --&gt;
&lt;/object&gt;
&lt;object name=&quot;dhlTracker&quot; type=&quot;YTech.ShipperInterface.Dhl.Tracking.DhlScreenScrapeTracker, YTech.ShipperInterface&quot;&gt;
	&lt;constructor-arg ref=&quot;postUtility&quot; /&gt;
&lt;/object&gt;
&lt;object name=&quot;simulationTracker&quot; type=&quot;YTech.ShipperInterface.Tracking.Simulation.SimulationTracker, YTech.ShipperInterface&quot; /&gt;

&lt;!-- Combine all of the other trackers into one stream --&gt;
&lt;object name=&quot;multiTracker&quot; type=&quot;YTech.ShipperInterface.Tracking.MultiTracker, YTech.ShipperInterface&quot;&gt;
	&lt;constructor-arg&gt;
		&lt;list element-type=&quot;YTech.ShipperInterface.Tracking.ITracker, YTech.ShipperInterface&quot;&gt;
			&lt;ref object=&quot;simulationTracker&quot; /&gt;
			&lt;!-- Order these by popularity --&gt;
			&lt;ref object=&quot;fedexTracker&quot; /&gt;
			&lt;ref object=&quot;uspsTracker&quot; /&gt;
			&lt;ref object=&quot;dhlTracker&quot; /&gt;
		&lt;/list&gt;
	&lt;/constructor-arg&gt;
&lt;/object&gt;

&lt;!-- Cache the upstream tracking data --&gt;
&lt;object name=&quot;cacheTracker&quot; type=&quot;YTech.ShipperInterface.Tracking.CacheTracker, YTech.ShipperInterface&quot;&gt;
	&lt;constructor-arg ref=&quot;multiTracker&quot; /&gt;
&lt;/object&gt;

&lt;!-- Handle errors by logging them, and returning a special ErrorTrackingData object --&gt;
&lt;object name=&quot;MainTracker&quot; type=&quot;YTech.ShipperInterface.Tracking.ErrorHandlerTracker, YTech.ShipperInterface&quot;&gt;
	&lt;constructor-arg ref=&quot;cacheTracker&quot; /&gt;
&lt;/object&gt;</pre>

Now in my code, this is all I have to do:

<pre class="c-sharp" name="code">var ctx = ContextRegistry.GetContext();
var tracker = (ITracker)ctx.GetObject(&quot;MainTracker&quot;);
var td = tracker.GetTrackingData(&quot;my tracking number&quot;);</pre>

Every piece I've written is fully testable. I even created a class that posts data to a remote web server, and returns the response. This allows me to completely test the tracker classes. They don't care if they're hitting against a real server, or an in memory request/response mock class.

I have nearly 100% test coverage, and making changes to the site is a breeze.

The next step is to convert the actual web project to an MVC project so that I can unit test the actual page functionality.

Hopefully I've given a good example of how inversion of control can be a really good thing. Have any more questions about the architecture? Feel free to leave a comment.

Note: I haven't replaced the code on the live SimpleTracking.com site yet, but I plan on upgrading in the next couple of weeks.