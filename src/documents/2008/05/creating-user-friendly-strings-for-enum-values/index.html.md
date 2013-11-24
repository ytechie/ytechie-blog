---
layout: post
title: Creating user friendly strings for enum values
date: 2008-05-01
tags: ["c#"]
---

In this post, I'll show you how to create a custom attribute for enum values to assign extra information to an enum. In this case, we'll be associating a user friendly display name.

![Order Status Screenshot](order-status-screenshot.gif) 

In .NET, enums are basically a list of constant values. It's a way to assign code friendly names to a group of values. For example, an order status:
  <pre class="c-sharp" name="code">enum OrderStatus
{
	NewOrder = 1,
	Processing = 2,
	Shipped = 3
}</pre>

In the above example, the numeric values are optional, they will be assigned automatically if you don't supply them.

What if you want to display the enum values in a drop down list, so that an admin can change the status of an order? One option is to loop through the enum, and display the code value (&quot;NewOrder, &quot;Processing&quot;, etc.). Another option is to have a &quot;switch&quot; statement or a &quot;for&quot; statement that allows you to hard code a user friendly value.

Another option is to create a custom attribute to add additional meta data:

<pre class="c-sharp" name="code">public class EnumValueDataAttribute : Attribute
{
	private string _name;
	public string Name
	{
		get{ return _name; }
		set{ _name = value; }
	}
}</pre>

Now we can use the attribute to the enum I showed you previously:

<pre class="c-sharp" name="code">enum OrderStatus
{
	[EnumValueData(Name=&quot;New Order&quot;)]
	NewOrder = 1,
	[EnumValueData(Name=&quot;In Process&quot;)]
	Processing = 2,
	[EnumValueData(Name=&quot;Shipped&quot;)]
	Shipped = 3
}</pre>

Now we can create a method that gets the data in a useful format:

<pre class="c-sharp" name="code">public static Dictionary<int, string> GetListItems(Type enumType)
{
	if (!enumType.IsEnum)
		throw new ApplicationException(&quot;GetListItems does not support non-enum types&quot;);
	Dictionary&lt;int, string&gt; list = new Dictionary&lt;int, string&gt;();
	foreach(FieldInfo field in enumType.GetFields(BindingFlags.Static ' BindingFlags.GetField ' BindingFlags.Public))
	{
		int value;
		string display;
		value = (int)field.GetValue(null);
		display = Enum.GetName(enumType, value);
		foreach(Attribute currAttr in field.GetCustomAttributes(true))
		{
			EnumValueDataAttribute valueAttribute = currAttr as EnumValueDataAttribute;
			if (valueAttribute != null)
				display = valueAttribute.Name;
		}
		list.Add(value, display);
	}
	return list;
}</pre>

Notice that the method will also work even if the &quot;EnumValueData&quot; attribute is missing, so you don't have to supply it for every value.

Based off of this code, you could easily create additional fields to associate with enum values. Basically what we're doing is creating a simple database table in our code. You'll have to decide if this is a good idea for your project.