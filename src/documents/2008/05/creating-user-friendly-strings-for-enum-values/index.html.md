---
layout: post
title: Creating user friendly strings for enum values
date: 2008-05-01
---
In this post, I'll show you how to create a custom attribute for enum values to assign extra information to an enum. In this case, we'll be associating a user friendly display name.

![Order Status Screenshot](order-status-screenshot.gif) 

In .NET, enums are basically a list of constant values. It's a way to assign code friendly names to a group of values. For example, an order status:

	enum OrderStatus
	{
		NewOrder = 1,
		Processing = 2,
		Shipped = 3
	}

In the above example, the numeric values are optional, they will be assigned automatically if you don't supply them.

What if you want to display the enum values in a drop down list, so that an admin can change the status of an order? One option is to loop through the enum, and display the code value ("NewOrder, "Processing", etc.). Another option is to have a "switch" statement or a "for" statement that allows you to hard code a user friendly value.

Another option is to create a custom attribute to add additional meta data:

	public class EnumValueDataAttribute : Attribute
	{
		private string _name;
		public string Name
		{
			get{ return _name; }
			set{ _name = value; }
		}
	}

Now we can use the attribute to the enum I showed you previously:

	enum OrderStatus
	{
		[EnumValueData(Name="New Order")]
		NewOrder = 1,
		[EnumValueData(Name="In Process")]
		Processing = 2,
		[EnumValueData(Name="Shipped")]
		Shipped = 3
	}

Now we can create a method that gets the data in a useful format:

	public static Dictionary<int, string> GetListItems(Type enumType)
	{
		if (!enumType.IsEnum)
			throw new ApplicationException("GetListItems does not support non-enum types");
		Dictionary<int, string> list = new Dictionary<int, string>();
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
	}

Notice that the method will also work even if the "EnumValueData" attribute is missing, so you don't have to supply it for every value.

Based off of this code, you could easily create additional fields to associate with enum values. Basically what we're doing is creating a simple database table in our code. You'll have to decide if this is a good idea for your project.