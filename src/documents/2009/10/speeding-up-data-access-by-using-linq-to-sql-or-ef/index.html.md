---
layout: post
title: Speeding up data access by using Linq to SQL or EF
date: 2009-10-26
---

Recall that LINQ based object relational mappers (ORM) use expression trees to effectively translate your C# (or other language) LINQ code into SQL. Many DBA's and developers that don't fully understand this technology are often quick to discredit it. I'm going to show how significant performance, simplicity, and clarity can be gained by using Linq to SQL.

A recent DBA asked me the question "I thought inline SQL was bad, so why are we using it again?" LINQ may *smell* like inline SQL, but it is not. Let's first take a look at some simple LINQ that is easy to read: 

	from d in Devices
	where d.CZone == 4
	&& d.Type == "X"
	select d.Id

So how is this different than inline SQL? To be technical, you're writing a query against a data model, with full intellisense. You're also writing a provider agnostic query. This same query can be performed against SQL Server, Oracle, or even the Facebook API if there was a supporting framework in place. We now have a truly unified query architecture.

Let's keep taking about this simple LINQ query, and see how you would write it if you didn't want to use LINQ. Most developers before the days of LINQ would probably use a stored procedure. Stored procedures are great. They're efficient, reusable, and easily updatable. Here is what it may look like:

	Create Procedure GetMyStuff
	As
	Select Id
	From Devices
	Where CZone = 4
	And Type = 'X'
	Select Id
	GO

A nice, simple SQL query. There are a few disadvantages that may not be immediately apparent:

* If you need a second, similar query, you have to either have to create and maintain two stored procedures. As an alternative, you could modify the stored procedure to operate differently based on a parameter. Both of these options are not idea, but LINQ does give us an alternative that I'll discuss in a bit.
* You don't get intellisense when you're writing your code.
* You have to be concerned with two different "programming" paradigms, and also have to manually manage the translation in both directions.

Now, let's take our example to the other end of the spectrum, which will help show where LINQ can really shine where straight SQL does not. This example is a query for a search page. I set up a simple ASPX page to demonstrate. Here is a sample of the user interface:

![image](image_thumb1.png)

The user enters a number of search criteria, and the results are displayed. I literally coded this in under 5 minutes. If you're used to using stored procedures to retrieve this type of data, think about how you would go about creating this. You have a couple of options that I'm aware of:

* Write a separate stored procedure for every combination of parameters. In this case that would be 7 stored procedures. This would certainly not be ideal.
* Write a single stored procedure that can handle each parameter as nullable parameters, and use "Where @Param Is Null Or Param = @Param". This option is easy, but has some potential performance implications.
* Write a single stored procedure that can handle each parameter as nullable parameter, and "If" statements to handle each scenario. This would be time consuming an error prone.

In LINQ, we're able to **dynamically build up a query**. For the search example, my LINQ looks like this:

	var dataContext = new DataClassesDataContext();
	
	var query = (IQueryable&lt;Device&gt;) dataContext.Devices;
	
	if (txtCZone.Text.Length &gt; 0)
	    query = query.Where(device =&gt; device.CZone == int.Parse(txtCZone.Text));
	if (txtUCZone.Text.Length &gt; 0)
	    query = query.Where(device =&gt; device.UCZone == int.Parse(txtUCZone.Text));
	if (txtLZone.Text.Length &gt; 0)
	    query = query.Where(device =&gt; device.LZone == int.Parse(txtLZone.Text));
	
	dgResults.DataSource = query.ToList();
	dgResults.DataBind();

And of course we can use the query syntax instead (replacing lines 5-10 above):

	if (txtCZone.Text.Length &gt; 0)
		query = from device in query where device.CZone == int.Parse(txtCZone.Text) select device;
	if (txtUCZone.Text.Length &gt; 0)
		query = from device in query where device.UCZone == int.Parse(txtUCZone.Text) select device;
	if (txtLZone.Text.Length &gt; 0)
		query = from device in query where device.LZone == int.Parse(txtLZone.Text) select device;

The result is that the SQL code is specifically written to support only the parameters that the user has entered. No extra SQL, and no specific SQL to maintain. Remember that LINQ can be chained together without querying the underlying data. The actual querying of the data only occurs when enumerating the results, using an operation like "ToList()".

To support paging we need to run 3 different types of underlying queries. Here is where LINQ is really going to shine. We can use the same base query for all of these operations, and not have to worry about the drastically different underlying SQL statements.

1. **Result count** - Simply by calling the ".Count()" method, we can retrieve the number of rows the query will return in total. The underlying SQL will be a simple and efficient _Count_ operation.
2. **Page n query** - By utilizing _Skip_ and _Take_, any page within the results can be queried. The work of generating a common table expression is handled for you.
3. **First page query** - If the underlying provider has an optimization for using the SQL _TOP_ command, the first page of data you query will be able to avoid a common table expression. This has the advantage of being more efficient when the first (and often most common) page of results is displayed.

###Real-world Results

I initially ran into this in a real application that was primarily used to search through a large table of records. It had originally used the stored procedure approach, and was causing the entire system to slow down to the point of being unusable. Thanks to LINQ, we were able to make the search usable. In fact, the results were drastic:

<table border="1" cellspacing="0" cellpadding="2" width="309" align="center"><tbody>
    <tr>
      <td valign="top" width="66">&#160;</td>

      <td valign="top" width="136">**Stored Procedure** </td>

      <td valign="top" width="105">**LINQ to SQL** </td>
    </tr>

    <tr>
      <td valign="top" width="66">**Reads**</td>

      <td valign="top" width="136">Over 4,000,000 </td>

      <td valign="top" width="105">8948 </td>
    </tr>

    <tr>
      <td valign="top" width="66">**Duration**</td>

      <td valign="top" width="136">3249ms </td>

      <td valign="top" width="105">189ms </td>
    </tr>
  </tbody></table>

In addition to the improved performance, the code was easier to maintain. The stored procedure was extremely cluttered, had large _where_ clauses, and even contained two nearly identical copies of the query. One for calculating the count, and one for paging support.

###Conclusion

LINQ gives us much more than "inline SQL". It gives us a unified query syntax, delayed execution, query expression building, and dynamically created SQL output. Additionally, the generated queries are optimized based on the exact query being performed instead of making generic SQL that is optimized for multiple scenarios. 