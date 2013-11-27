---
layout: post
title: Managing the number of output assemblies
date: 2008-06-02
tags: ["software-development"]
---

A while back I had a discussion with a coworker about whether to have a few number of DLL's (.NET assemblies), or a lot, each with just a little bit of functionality. He ended up with some assemblies that had as few as one class.

For example, let's say you're writing an order management system (this is a completely fake example). Do you put everything into one assembly (like the left column), or do you separate out everything as fine grained as possible (like the right column). Or do you use an option somewhere in the middle?

<table><tbody><tr><td>YTech.OrderManagement.dll</td>
<td>       
* YTech.OrderManagement.WidgetReport.dll<br />
* YTech.OrderManagement.BlueSlider.dll<br />
* YTech.OrderManagement.GreenTextbox.dll<br />
* YTech.OrderManagement.OrderEntryScreen.dll
</td></tr></tbody></table>  

In most languages, such as .NET, your namespaces can easily be organized independently of your assemblies. This means that you can have a DLL for each class if you want, or cram everything together into one giant assembly.

So how do you choose? The good news is, you might not have to make that decision right now. My recommendation is to start by favoring a small number of assemblies (or even 1), and don't play the "[what if?](http://www.ytechie.com/2008/05/dont-play-the-what-if-game/)" game. As assemblies are needed independently, it's fairly easy to split them up.

If you have multiple projects, you'll probably want to define clear layers of code. For example, you might have separate assemblies for the following:

*   Code that is common to all projects in your company
*   Code that is common to the set of projects that belong to a similar functional group. For example, you might be working on reports that share common reporting functionality.
*   Code that is specifically designated as a framework for a certain application.  

### Fewer Assemblies

When you use fewer assemblies, you can drastically reduce compile time. There is quite a bit of overhead to compile a single project within visual studio. If you have to continually build your solution, a high number of solutions **will** slow you down. I've actually seen this have a fairly high impact.

Using fewer assemblies means that you'll spend less time setting up and maintaining project files. This could mean big time savings if you have to add references or compiler constants to all of your projects.

Assemblies also have a certain amount of overhead. Multiple assemblies will decrease your ratio of code to overhead. That translates into more data for the application to read and manage. For situations where the assemblies are local, this is a moot point. For remote applications, the combination of the latency and the overhead can double the amount of data that must be retrieved.

In your build process, more assemblies can make your installer harder to maintain. You'll end up spending more time synchronizing your required DLL list with the build script.

### Many assemblies

Of course, there _are_ times when more assemblies does make sense. If you're writing an application that does not have a fast connection to the assemblies, you probably don't want to make the user wait for the large ones to load. In that case, you should try to optimize the assemblies based on what a typical user would use. For example, the main form of an application might be the first assembly, and reporting functionality might be another. The user shouldn't have to wait for reporting functionality if they are unlikely to use it. If they do use it, the assembly can be downloaded and used on demand.

Depending on your release and patch policy, using multiple assemblies might make it easier to manage patches. Once you replace a DLL, it's difficult to manage it if you have to replace it again to give the user a different fix. For a single assembly, the number of patched DLL's could start to multiply. For example, if you have 3 fixes, they could be applied in 8 different ways (2^3);

In summary, make sure you at least consider the following factors:

*   Speed that the assemblies can be obtained by the application
*   Latency of the connection to the assembly location
*   Code maintenance overhead
*   The typical of functionality the user would use (vs rarely used screens or functionality)
*   Patch/release policy
*   Solution & project management
*   Build management
*   Installer management