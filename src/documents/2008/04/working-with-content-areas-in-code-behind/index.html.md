---
layout: post
title: Working with content areas in code behind
date: 2008-04-24
---

In my master page, I have a ContentPlaceHolder defined:
  <pre class="xml" name="code"><asp:ContentPlaceHolder runat=&quot;server&quot; ID=&quot;AfterScripts&quot;>
&lt;/asp:ContentPlaceHolder&gt;</pre>

In the page, I have the content defined:

<pre class="xml" name="code">&lt;asp:Content runat=&quot;server&quot; ID=&quot;conTrackingScripts&quot; ContentPlaceHolderID=&quot;AfterScripts&quot;&gt;
    &lt;!-- Blah --&gt;
&lt;/asp:Content&gt;</pre>

Unfortunately, this code does not work:

<pre class="c-sharp" name="code">conTrackingScripts.Visible = false;</pre>

The error given is &quot;The name 'conTrackingScripts' does not exist in the current context. A quick Google search shows that many others have had the same issue. The solution is to use the following code instead:

<pre class="c-sharp" name="code">(Master as MasterPage).FindControl(&quot;AfterScripts&quot;).Visible = false;</pre>

Substitute the name of your master page for &quot;MasterPage&quot;, and the name of your ContentPlaceHolder for &quot;AfterScripts&quot; in the above code

It appears that you cannot edit properties on the content, you have to edit the ContentPlaceHolder directly.