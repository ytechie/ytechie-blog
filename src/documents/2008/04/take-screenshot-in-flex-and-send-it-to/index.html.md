---
layout: post
title: Take a screenshot in Flex and send it to ASP.NET
date: 2008-04-22
---

In Adobe Flex 3, you can get a bitmap image of any control by using this code (you'll need to import &quot;mx.graphics.ImageSnapshot&quot;):
  <pre class="javascript" name="code">var snapshot:ImageSnapshot =  ImageSnapshot.captureImage(backgroundCanvas);</pre>

By default, it uses PNG encoding.

If you want to then send this image to the server, use this code:

<pre class="javascript" name="code">var req:URLRequest = new URLRequest();
req.method = URLRequestMethod.POST;
req.data = snapshot.data;
req.contentType=&quot;application/octet-stream&quot;;
req.url = &quot;snapshotuploadhandler.aspx&quot;;
var loader:URLLoader = new URLLoader;
loader.load(req);</pre>

Reading the uploaded file is easy using ASP.NET:

<pre class="c-sharp" name="code">private byte[] readPostedFile()
{
   if (Request.ContentLength > 0)
   {
       byte[] buffer = new byte[Request.ContentLength];
       using (BinaryReader br = new BinaryReader(Request.InputStream))
           br.Read(buffer, 0, buffer.Length);
       return buffer;
   }
   else
   {
       return null;
   }
}</pre>