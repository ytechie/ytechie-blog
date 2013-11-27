---
layout: post
title: SQL Server NULL values and "Order By" order
date: 2008-05-19
tags: ["sql"]
---

I have a few tables that contain a column called "Order", which is used to sort by when retrieving the data. The purpose is to keep the data in a certain order when displayed to the end user.
<table><tbody>
<tr><td>Black Linen</td><td>NULL</td></tr>
<tr><td>Navy Blue Linen</td><td>NULL</td></tr>
<tr><td>Dark Green Linen</td><td>NULL</td></tr>
<tr><td>Burgundy Linen</td><td>NULL</td></tr>
<tr><td>Ivory Vellum</td><td>NULL</td></tr>
<tr><td>Grey Felt</td><td>NULL</td></tr>
<tr><td>Natural Linen</td><td>NULL</td></tr>
<tr><td>White Coated Two Sides</td><td>1</td></tr>
<tr><td>White Cast Coated One Side</td><td>2</td></tr>
<tr><td>White SemiGloss Coated One Side</td><td>3</td></tr>
<tr><td>White Smooth</td><td>4</td></tr>
<tr><td>White Linen</td><td>5</td></tr>
</tbody></table>  

The problem is that SQL Server puts null values above non-null values when doing an "order by". To reverse this behavior, this was the most elegant and efficient solution that I found:

	Select FooValue
	From foos
	Order by (Case When [Order] Is Null Then 1 Else 0 End), [Order]

I found information about the [original problem here](http://cfsilence.com/blog/client/index.cfm/2006/2/21/TSQL-Dealing-with-Null-Values-in-an-Order-By-Clause), and the solution was from [Tim](http://www.zeroesque.com/) in the comments. Thanks!