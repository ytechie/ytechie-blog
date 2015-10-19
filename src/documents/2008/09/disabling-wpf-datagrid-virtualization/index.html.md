---
layout: post
title: Disabling WPF DataGrid Virtualization
date: 2008-09-03
---

Recently, Microsoft [released a DataGrid](http://www.codeplex.com/wpf/Release/ProjectReleases.aspx?ReleaseId=14963) for WPF (Windows Presentation Foundation). I've been getting my feet wet in WPF, because I think it's the long term direction that Microsoft is pushing UI design into.

The DataGrid they released is only a CTP, not an official release. However, I needed something that worked now, not later for the utility I'm writing. I created a list of data, and bound it to the grid, only to watch my bound ComboBoxes lose their mind as I scrolled up and down. After ripping out my hair, I found a simple solution (for the DataGrid issue, not the lost hair). I added this attribute to my DataGrid declaration:

	VirtualizingStackPanel.VirtualizationMode="Standard"

By default, the DataGrid is configured to virtualize it's contained controls. That means that as you scroll, the rendered [controls are reused, and avoids constantly generating containers](http://blogs.msdn.com/vinsibal/archive/2008/05/14/recycling-that-item-container.aspx).

I've seen this behavior in [Adobe Flex](http://www.adobe.com/products/flex/), and it's a useful feature to have, especially when memory is a concern. A real world example is the Outlook message list. If you have 10,000 items sitting in your inbox (I've seen it!), you don't want to wait while your computer busily tries to display things you can't see.

Back to the issue I had. There is either a bug in the DataGrid with ComboBox items, or there I am doing something wrong in my XAML. Either scenario is certainly plausible. When new versions of the DataGrid are released, I'll have to give them a try. For now, this fix works great.