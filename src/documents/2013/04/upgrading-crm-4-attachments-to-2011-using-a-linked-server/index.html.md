---
layout: post
title: Upgrading CRM 4 Attachments to 2011 Using a Linked Server
date: 2013-04-12
---

We ran into a situation where our CRM 4 database would take **days** to upgrade to 2011\. It turns out we had accumulated over 150GB of attachments from CRM tracked emails. In order to drastically speed up the migration process, we decided to truncate **ActivityMimeAttachment** the table prior to the upgrade process. I then wrote SQL scripts to pull the data over _after_ the conversion using the [linked server](http://msdn.microsoft.com/en-us/library/ms188279.aspx) functionality in SQL Server. The advantage is that data can be pulled even while one or both of the systems are in use.

If you're not familiar with linked servers, it's a useful feature that allows you to set up one SQL Server database to connect to another and access both within the same query or script. To link a server, you'll want to go to the _destination_ server, and log in. You can actually link either direction, I just chose to write the script for the destination server. The source server you'll be linking must have the proper permissions set up. In this case, since the migration process was temporary, so I created a temporary sysadmin account. I was then able to link the source server with this SQL (if it's not obvious, there are some tokens you need to substitute):
  <pre class="sql" name="code">Exec sp_addlinkedserver '{source_server}', 'SQL Server';
Exec sp_addlinkedsrvlogin '{source_server}', 'false', null, '{source_server_user}', '{source_server_password}';</pre>

Once the servers are linked, you can start pulling over the data. This is where things get really hairy. In CRM 4, the **ActivityMimeAttachment** table stored all of the attachments and the associated metadata. In CRM 2011, this information is split apart, and there are extra columns that we need to supply data for. First, we'll need to populate the **Attachments** table:

<pre class="sql" name="code">Insert Into Attachment
Select Body, [Subject], FileSize, MimeType, [FileName], Null as 'VersionNumber',
	ActivityMimeAttachmentId as 'AttachmentId'
From {source_server}.{source_crm_database_name}.dbo.ActivityMimeAttachment</pre>

After that, we can pull over the metadata. One piece of information that we're missing is the "solutionId". I sent a test email from 2011 and inspected the row it inserted to get the solutionId.

<pre class="sql" name="code">Insert into ActivityMimeAttachment
Select AttachmentNumber, ActivityMimeAttachmentId, Null as [VersionNumber],
	{solution_id} as SolutionId, ama.ActivityMimeAttachmentId as 'AttachmentId',
	Null as 'SupportingSolutionId', ActivityTypecode as 'ObjectTypeCode',
	0 as 'IsManaged', 0 as 'ComponentState', '1900-01-01 00:00:00.000' as 'OverwriteTime',
	(newid()) as 'ActivityMimeAttachmentIdUnique', ama.ActivityId as 'ObjectId'
From {source_server}.{source_crm_database_name}.dbo.ActivityPointerBase apb
Join {source_server}.{source_crm_database_name}.dbo.ActivityMimeAttachment ama
	on ama.ActivityId = apb.ActivityId</pre>

When you're ready to unlink the source server, use the drop commands:

<pre class="sql" name="code">Exec sp_droplinkedsrvlogin '{source_server}', null
Exec sp_dropserver '{source_server}'</pre>

At this point, I was concerned that the script may crash and/or run out of memory. To avoid this possibility, I decided to pull the data over in batches. I won't get into the specifics, but you can reference my complete script below. From a high-level, I'm adding a column to the source table to mark rows that I'm pulling over, and what the migration state is. I made it nullable so that it doesn't affect normal CRM operations.

<pre class="sql" name="code">Declare @LinkedServerUser Varchar(Max)
Declare @LinkedServerPassword Varchar(Max)

Set @LinkedServerUser = {linked_server_user};
Set @LinkedServerPassword = '{linked_server_password}';

Print 'Linking Remote Server...'
Exec sp_addlinkedserver '{linked_server}', 'SQL Server';
Exec sp_addlinkedsrvlogin '{linked_server}', 'false', null, @LinkedServerUser, @LinkedServerPassword;
Go

/*
Create a column in the source database to track which rows have been converted.

Values:
--1=Queued to move to attachments
--2=Moved to attachments
--3=Queued to move to mime attachments
--4=Fully migrated
*/
EXECUTE {linked_server}.{crm_database_name}.dbo.sp_executesql
	N'Alter Table ActivityMimeAttachment Add T_Processed Int'
Go

Declare @SolutionId UniqueIdentifier
Set @SolutionId = '{solution_id}';

Declare @Rows Int

Print 'Copying attachments...'
Set @Rows = 1
While(@Rows &gt; 0)
Begin
	--Queue up records we haven't moved
	Update Top (1000)
	{linked_server}.{crm_database_name}.dbo.ActivityMimeAttachment
	Set T_Processed = 1
	Where T_Processed Is Null

	Insert Into Attachment
	Select Body, [Subject], FileSize, MimeType, [FileName], Null as 'VersionNumber',
		ActivityMimeAttachmentId as 'AttachmentId'
	From {linked_server}.{crm_database_name}.dbo.ActivityMimeAttachment
	Where T_Processed = 1

	Set @Rows = @@RowCount
	RAISERROR ('Attachment Rows Updated...', 0, 1) WITH NOWAIT

	--Mark the records as moved
	Update {linked_server}.{crm_database_name}.dbo.ActivityMimeAttachment
	Set T_Processed = 2
	Where T_Processed = 1
End

Print 'Copying attachment metadata...'
Set @Rows = 1
While(@Rows &gt; 0)
Begin
	--Queue up records we haven't moved
	Update Top (1000)
	{linked_server}.{crm_database_name}.dbo.ActivityMimeAttachment
	Set T_Processed = 3
	Where T_Processed = 2

	Insert into ActivityMimeAttachment
	Select AttachmentNumber, ActivityMimeAttachmentId, Null as [VersionNumber],
		@SolutionId as SolutionId, ama.ActivityMimeAttachmentId as 'AttachmentId',
		null as 'SupportingSolutionId', ActivityTypecode as 'ObjectTypeCode',
		0 as 'IsManaged', 0 as 'ComponentState', '1900-01-01 00:00:00.000' as 'OverwriteTime',
		(newid()) as 'ActivityMimeAttachmentIdUnique', ama.ActivityId as 'ObjectId'
	From {linked_server}.{crm_database_name}.dbo.ActivityPointerBase apb
	Join {linked_server}.{crm_database_name}.dbo.ActivityMimeAttachment ama
		on ama.ActivityId = apb.ActivityId
	Where ama.T_Processed = 3

	Set @Rows = @@RowCount
	RAISERROR ('ActivityMimeAttachment Rows Updated...', 0, 1) WITH NOWAIT

	--Mark the records as moved
	Update {linked_server}.{crm_database_name}.dbo.ActivityMimeAttachment
	Set T_Processed = 4
	Where T_Processed = 3
End

Print 'Dropping temp column'
EXECUTE {linked_server}.{crm_database_name}.dbo.sp_executesql  N'Alter Table ActivityMimeAttachment Drop Column T_Processed'

Print 'Unlinking remote server...'
Exec sp_droplinkedsrvlogin '{linked_server}', 'sa'
Exec sp_droplinkedsrvlogin '{linked_server}', null
Exec sp_dropserver '{linked_server}'

Print 'Migration complete.'</pre>