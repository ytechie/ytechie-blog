---
layout: post
title: LINQ to SQL & Entity Framework Pitfalls
date: 2009-09-30
tags: ["c#","entity framwork","LINQ","sql"]
---

In my last post describing the [differences between LINQ to objects and LINQ to SQL](http://www.ytechie.com/2009/09/understanding-linq-and-linq-to-sql-and-ef.html), I mentioned how LINQ to SQL and Entity Framework "interpret" your LINQ code, and create the corresponding SQL. Forgetting this fact is extremely dangerous, because LINQ to SQL and other object relational mappers are extremely leaky abstractions. LINQ is obviously a wonderful technology, but this post will be talking about some potential pitfalls you may run into.

**SQL Query Complexity Disproportional to LINQ Complexity**

Recall the example from my last post:
  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:5641d3eb-6590-4d9a-8cac-c0db294cd564" class="wlWriterEditableSmartContent"><pre name="code" class="c#">//Query Syntax:
from device in Devices
where device.Type != null
select device.DeviceId

//SQL Syntax:
SELECT [t0].[DeviceId]
FROM [Devices] AS [t0]
WHERE [t0].[Type] IS NOT NULL</pre></div>

In this case, LINQ to SQL has done something wonderful. It's saved us from having to understand or worry about the translation of syntax between C# and SQL. Now, what happens when we write something a little more advanced, such as a nested group by?

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:62df480a-95e2-4910-95b5-9ec5eb45f0be" class="wlWriterEditableSmartContent"><pre name="code" class="c#">from d in Devices
group d by d.CZone into czoneGroup
select new { Key = czoneGroup.Key, val = from d2 in czoneGroup
	group d2 by d2.LZone into lzoneGroup
	select lzoneGroup.Key }</pre></div>

And the corresponding SQL:

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:f50bc355-9467-4d6a-9aaa-63ff31cecff9" class="wlWriterEditableSmartContent"><pre name="code" class="c#">SELECT [t0].[CZone] AS [Key]
FROM [Devices] AS [t0]
GROUP BY [t0].[CZone]
GO

DECLARE @x1 Int = 3
SELECT [t0].[LZone]
FROM [Devices] AS [t0]
WHERE ((@x1 IS NULL) AND ([t0].[CZone] IS NULL)) OR ((@x1 IS NOT NULL) AND ([t0].[CZone] IS NOT NULL) AND (@x1 = [t0].[CZone]))
GROUP BY [t0].[LZone]
GO

DECLARE @x1 Int = 1
SELECT [t0].[LZone]
FROM [Devices] AS [t0]
WHERE ((@x1 IS NULL) AND ([t0].[CZone] IS NULL)) OR ((@x1 IS NOT NULL) AND ([t0].[CZone] IS NOT NULL) AND (@x1 = [t0].[CZone]))
GROUP BY [t0].[LZone]
GO

//Reminaing SQL removed....</pre></div>

What just happened? Our innocent nested join has turned into a monster! This is an example of a query that is simple to do in LINQ, but has no translation to a simple SQL statement. Instead of just bombing, the LINQ to SQL engine comes up with a solution that a user may not have written themselves. A typical SQL developer may have looked for a different approach.

_Side note: In the nested group-by, notice that LINQ to SQL uses multiple queries. This differs from the Entity Framework approach, which uses outer joins to achieve the same effect._

Does it matter? The answer isn't so simple. In this simplified example, the performance impact is minimal. Unfortunately, with a large amount of data in this type of query, you could start to experience terrible performance. I personally saw a nested query that was only a few lines of code turn into a 27 page SQL statement. The SQL statement was technically correct, but took seconds to execute, when it should have taken a fraction of a second.

One simple solution that I have found to be very effective, yet not intuitive, is breaking apart the initial query and forcing it to execute using the ToList() method. You'll have to have a decent "where" clause to avoid excessive amounts of data being returned. Once we have the raw data, LINQ to objects will provide us the same set of tools to further manipulate our data. For instance, here is a modified version of the example presented earlier:

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:fe1b1c69-41cf-42f9-9ab2-feed64283c70" class="wlWriterEditableSmartContent"><pre name="code" class="c#">//Simple &amp; fast initial query from the database
var rawData = (from d in Devices
where d.Location = 'B3').ToList();

//This operation happens "disconnected"
var results = from d in rawData
group d by d.CZone into czoneGroup
select new { Key = czoneGroup.Key, val = from d2 in czoneGroup
	group d2 by d2.LZone into lzoneGroup
	select lzoneGroup.Key };</pre></div>

The reason this works well is that it's taking advantage of the strength of SQL Server, which is to query data, and the strength of .NET, which is to process and manipulate data.

**LINQ Abstracting Away Problems it Can't Solve**

Here is a simplified version of a query I saw recently:

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:6b58a736-2368-485e-ad30-4726c9267ae1" class="wlWriterEditableSmartContent"><pre name="code" class="c#">int sum = (from d in Devices
where 1 == 2 &amp;&amp; d.CZone != null
select d.CZone.Value).Sum()</pre></div>

To make it extremely clear what I'm trying to accomplish, I put "1 == 2" in the "where" clause, so that no rows match the condition. The "Sum()" method returns the type that it's acting on. For example, if you're summing integers, the result is an integer. If you're summing nullable integers, the result is a nullable integer. This is perfectly valid LINQ. This is effectively the SQL that is generated (I simplified it for clarity):

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:812469c5-0cb0-4c63-8c15-c81123a09de7:8e0404af-4082-4891-80e6-4e96545bd024" class="wlWriterEditableSmartContent"><pre name="code" class="sql">Select SUM(CZone)
From Devices
Where 1 = 2</pre></div>

Since the result of this SQL statement is NULL, it can't be converted back to an integer. The exception is "_InvalidOperationException: The null value cannot be assigned to a member with type System.Int32 which is a non-nullable value type._"

When the LINQ is translated to SQL, there is no such operation as converting a nullable value to a non-nullable, so the ".Value" operation is ignored. This would be fine if the sum function still expected a nullable return type, but it's now expecting an integer. When it can't find any rows to return, it tries to return NULL. Since it's trying to package up a NULL value into a standard integer type, it has no choice but to throw an exception.

**Conclusion**

Getting started with LINQ is fairly straightforward, but you can't forget the fact that whatever query you're writing must be converted into a SQL statement, and the results must be converted back to data that is understandable to .NET. Every LINQ query you write should be checked with a tool such as [LINQPad](http://www.linqpad.net/) to ensure that the SQL is efficient, and matches what you expect.

Also keep in mind that when you upgrade your data provider, your queries can change. For example, converting a statement from LINQ to SQL to Entity Framework can generate different SQL queries, just as updating to a newer version of the same ORM can.