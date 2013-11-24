---
layout: post
title: Unit Testing a LINQ to SQL or EF Query
date: 2009-04-09
tags: ["LINQ","unit testing"]
---

I was writing a slightly non-trivial method to query a database to find a record matching a certain time range. It quickly became clear that it would be nice to write some automated unit tests against it. Integration tests would be less than ideal because of the execution time and complexity. I ended up with a way to test the code without jumping through too many hoops.

**IEnumerable vs IQueryable**

First, you need to understand the purpose of IEnumerable and IQueryable. IEnumerable defines a stream of objects that can be retrieved sequentially. It's implemented for nearly every type of list, and it's an integral part of LINQ. There are now methods included such as "Where" and "Select" that let us filter, sort, and manipulate lists of data in interesting yet simple ways. This can also be referred to as LINQ to objects.

IQueryable inherits from IEnumerable, and is designed to be translatable into a query. IQueryable is typically used to build an expression tree that **represents** the requested operations. The operations are not actually executed until the expression tree is evaluated and used.

As an example, let's say I have a database with a table and entities called DateRange. Suppose I cast the DateRange entityset (which implements IQueryable&lt;DateRange&gt;) as IEnumerable&lt;DateRange&gt;. When I call LINQ expressions on that IEnumerable, the underlying query is run immediately, which effectively causes all of the data from that table to be retrieved. If I use IQueryable without casting, my operations get turned into SQL that gets executed when I actually try to iterate through the data (probably using ToList() or foreach). It's obviously preferable to have the query run in SQL since it can more efficiently filter the data.

**The Problem**

As I mentioned earlier, I recently starting writing a data access method that started to contain some non-trivial logic. Whenever I see logic, I want to be able to unit test it! I ended up pulling out the logic into its own static method. This method takes in IEnumerable&lt;DateRange&gt;, which can also accept IQueryable&lt;DateRange&gt; (because of the inheritance, you'll recall). Then, I simply use the AsQueryable method in IEnumerable. This ends up building the needed expression tree that can be translated into a SQL query, but it also lets me test against an in memory collection.
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:fa00aac0-6c39-4e4b-bc9f-a7781d500240" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public static DateRange FindRelativeToDate(IEnumerable&lt;DateRange&gt; enumerable, DateTime reference, int periodOffset)
{
	//Build as an expression tree, if possible, otherwise enumerate
	var queryable = enumerable.AsQueryable();

	//Now put in all the logic

	var reference2 = reference.AddDays(-1);

	var initialRange = from bp in queryable
		 where reference &gt;= bp.Start &amp;&amp; reference2 &lt; bp.End
		 select bp;

	var currentDateRange = initialRange.First();

	if(periodOffset == 0)
		return currentDateRange;

	var newRange = from bp in queryable
		select bp;

	if (periodOffset &gt; 0)
	{
		newRange = newRange.Where(x =&gt; x.Start &gt;= currentDateRange.Start);
		newRange = newRange.OrderBy(x =&gt; x.Start);
	}
	else
	{
		newRange = newRange.Where(x =&gt; x.End &lt;= currentDateRange.End);
		newRange = newRange.OrderByDescending(x =&gt; x.Start);
	}

	return newRange.Skip(Math.Abs(periodOffset)).Take(1).FirstOrDefault();
}</pre></div>

In my unit test class, I can define a list of sample data. I took real data from the database to make the tests as close to reality as possible:

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:04d1e3b3-50b1-48e5-931a-eb3c96fa191e" class="wlWriterEditableSmartContent"><pre name="code" class="c#">private static readonly List&lt;DateRange&gt; _DateRanges = new List&lt;DateRange&gt;
{
	new DateRange {Start = new DateTime(2009, 1, 1), End = new DateTime(2009, 1, 30)},
					new DateRange {Start = new DateTime(2009, 1, 31), End = new DateTime(2009, 3, 01)},
					new DateRange {Start = new DateTime(2009, 3, 2), End = new DateTime(2009, 3, 31)},
					new DateRange {Start = new DateTime(2009, 4, 1), End = new DateTime(2009, 4, 30)},
};</pre></div>

Now, I can easily test the static class I wrote (this is 1 of 9+ real tests):

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:44884bb7-a315-4cd2-a693-f699e9d4e34a" class="wlWriterEditableSmartContent"><pre name="code" class="c#">[TestMethod]
public void FindRelativeToDate_MiddleOfDateRange_ContainingDateRange()
{
	var result = DateRangeRepository.FindRelativeToDate(_DateRanges, new DateTime(2009, 3, 15), 0);
	Assert.AreEqual(_DateRanges[2], result);
}</pre></div>

The only thing that is left to do is wire up the repository method so that it calls my static method. This is a thin wrapper layer that will actually get used in production. If you run profiler, you'll see that the query expression is being evaluated and converted into an efficient SQL expression.

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:ad5a6773-4fc7-435a-b3f1-f68cc877ff64" class="wlWriterEditableSmartContent"><pre name="code" class="c#">public DateRange FindRelativeToDate(DateTime reference, int periodOffset)
{
	var ctx = dbEntities;
	return FindRelativeToDate(ctx.DateRangeSet, reference, periodOffset);
}</pre></div>

**Limitations/Conclusion**

Unfortunately, this method of testing a repository doesn't scale easily. If you start working with multiple entity sets that are combined with join operations, this technique is next to impossible to use. You'll see the most benefit when working with a single entity type, and need to test logic in your repository method.

One thing you need to be aware of, is that LINQ to SQL and Entity Framework don't implement every IQueryable/IEnumerable method. This means that you could potentially make calls on the in-memory collection that will then fail when you use the actual database. Fortunately, these problems can usually be detected fairly quickly.