---
layout: post
title: Reading an octet stream post in ASP.NET
date: 2008-04-15
---

I'm using [Adobe Flex](http://www.adobe.com/products/flex/) to take a [snapshot of some controls](http://dougmccune.com/blog/2007/06/11/imagesnapshot-class-in-flex-3-sdk/). I turn the PNG encoded bitmap data into a ByteArray. I then send the data to the server, through an ASP.NET page. On the Flex side of things, I send the data over with the following code:
  <pre class="javascript" name="code">var req:URLRequest = new URLRequest();
req.method = URLRequestMethod.POST;
req.data = snapshot.data;
req.contentType=&quot;application/octet-stream&quot;;
req.url = &quot;snapshotuploadhandler.aspx&quot;;

var loader:URLLoader = new URLLoader;
loader.load(req);</pre>

I assumed this code was incorrect, but it was actually the code in the receiving page. Instead of checking the &quot;Files&quot; property on the request object, I needed to read the InputStream on the request. Here is the working code: 

<pre class="c-sharp" name="code">if (Request.ContentLength > 0)
{
    byte[] buffer = new byte[Request.ContentLength];
    using (BinaryReader br = new BinaryReader(Request.InputStream))
        br.Read(buffer, 0, buffer.Length);
    return buffer;
}</pre>