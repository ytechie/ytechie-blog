---
layout: post
title: Disable constraints in "After Insert" trigger
date: 2008-04-23
tags: ["sql"]
---

I have a table that stores extra information (Users) that gets associated with the &quot;aspnet_Membership&quot; table in my application. Since my table references the membership table, I have a foreign key for referential integrity.

I added a trigger to the membership table so that rows automatically get inserted into my table. The problem is, the trigger violates the foreign key constraint! Here is the trigger code:
  <pre class="sql" name="code">Create Trigger dbo.Trigger_CreateExtraUserRecord ON aspnet_Users
After Insert
As
Begin
    Set Nocount On
    Insert Into tfs_Users
    (MembershipUserId)
    Select UserId From inserted
End</pre>

As you can see, it's an &quot;After Insert&quot; trigger, so the first insert will be done at this point (I have verified that).

It must be using some kind of transaction, and the foreign key is violated because it's not committed.

The solution (not perfect, but it works), is to use this before the insert to disable the foreign key check:

<pre class="sql" name="code">Alter Table tfs_Users Nocheck Constraint All</pre>

And use this after:

<pre class="sql" name="code">Alter Table tfs_Users Check Constraint All</pre>

Instead of disabling all constraints, you could also specify the constraint name, which would obviously be better in most cases.

Does anyone have a better explanation for this behavior?