---
layout: post
title: Slick inline trace logging in ASP.NET
date: 2009-03-03
---

I'm going to show you a slick way to configure [log4net](http://logging.apache.org/log4net/index.html) to your trace log, and then make it extremely simple to view the trace log for a page **while** viewing that page. Ultimately, we'll end up with something that looks like this:

![page-tracing](pagetracing-thumb.png) 

It may be difficult to see from the screenshot, but I'm looking at a standard ASP.NET page, but there is tracing information at the bottom. This tracing information is the same information you would see if you configured tracing your _web.config_, and then used the _trace.axd_ page. However, we're displaying it right along with the page request. To allow tracing to be enabled with a simple URL parameter, you can add the following code into your _Global.asax_ file:

	protected void Application_BeginRequest(object s, EventArgs e)
	{
		if (Context.Request.QueryString["trace"] == "true")
			Context.Trace.IsEnabled = true;
	}

Of course in a public environment, it may be wise to add security or at least obfuscate the parameter. The trace information contains server information that may be helpful to someone trying to compromise the server.

Now that we have tracing information, how can we get our log messages to show up? Log4net provides an appender for logging to the ASP.NET tracing feature:

	<appender name="AspNetTraceAppender"
		type="log4net.Appender.AspNetTraceAppender">
		<layout type="log4net.Layout.PatternLayout">
			<conversionPattern
				value="[Thread #%thread] %-5level - %message%newline" />
		</layout>
	</appender>

Don't forget to wire up the adapter so that log4net knows to use it:

	<root>
		<level value="DEBUG" />
		<appender-ref ref="AspNetTraceAppender" />
	</root>

Now, in your code, you can simply log messages as you normally would:

	_log.Debug("Loading User Data");

###Conclusion

I've found this type of configuration very useful in my ASP.NET applications. It lets me analyze how long each portion of the page generation is taking so that I can find bottlenecks. It also motivates me to write a fair amount of logging, since I'll see a benefit during development, as well as after deploying it into the wild.