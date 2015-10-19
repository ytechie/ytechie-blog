---
layout: post
title: Using the Luhn algorithm to validate credit cards
date: 2008-04-16
---

Today's post is inspired by [this blog post](http://www.diffio.com/post/Credit-card-validation---regular-expressions.aspx). The author posted a number of regular expressions for the different types of credit cards. I'm sure there are cases when they are useful, but there is typically a better way!

The [Luhn algorithm](http://en.wikipedia.org/wiki/Luhn_algorithm) was designed exactly for the purpose of validating credit cards. It's basically a checksum check for the exact purpose of verifying that a credit card number was entered correctly. It does not pick up all errors, but it's perfectly fine for real world use.

The best part is that we can easily use the Luhn algorithm in an ASP.NET validator. To do so, you'll first need to add the Luhn JavaScript to your page. You can use a scriptblock on your page, or put it in a separate js file and include it. The script that I have tested and use is available on [this site](http://www.brainjar.com/js/validation/default2.asp).

Here is an outline of the JavaScript you could use:
  <pre class="javascript" name="code">function ccValidator(sender, args)
{
    var ccString = args.Value.replace(&quot;-&quot;, &quot;&quot;);
    args.IsValid = luhn_check(ccString);
}
function luhn_check(s)
{
    //Insert Luhn algorithm here.
    //Example at: http://www.brainjar.com/js/validation/default2.asp
}</pre>

The next step is to add an ASP.NET validator:

<pre class="xml" name="code"><asp:CustomValidator
    runat=&quot;server&quot;
    ControlToValidate=&quot;txtCCNumber&quot;
    ClientValidationFunction=&quot;ccValidator&quot;
    ErrorMessage=&quot;Invalid credit card number&quot;
    Display=&quot;Dynamic&quot;
    EnableClientScript=&quot;true&quot; /></pre>

You'll need to change the &quot;ControlToValidate&quot; property to match the TextBox control that you're validating.

Now you'll have a validator that can check the credit card number in real time, before a postback! You'll still need to determine how you're going to do validation on the server if the client doesn't support client-side validation.

There is only one other thing worth mentioning. If you're running an e-commerce site, you typically want to avoid any issues that could cause you to lose an order. Over-validating is one of them. In many cases, even if the credit card does not get charged successfully, you should let the order go through. You can then contact the user and try to correct the situation. It might just be worth the sale!