---
layout: post
title: Azure in Plain English
date: 2015-09-20
---

**I'm currently working on this post. It will change over the next few days**.

Recently I saw a great page called [Amazon Web Services in Plain English](https://www.expeditedssl.com/aws-in-plain-english). I searched for the Azure equivalent, and as it turns out, one doesn't exist! Time to set that straight.

The most interesting thing about this exercise is that Azure services are actually named fairly well. For each of the official names, it was extremely difficult to come up with a better name.

## Base Services

<table>
	<tr>
		<td>**Azure Service**</td>
		<td>**Could be Called**</td>
		<td>**Use this to...**</td>
		<td>**Like AWS...**</td>
	</tr>
	
 <tr><td>Virtual Machines</td><td>Virtual Servers</td><td>Move existing VM to the cloud without changing them. You manage the entire OS.</td><td>EC2</td></tr>
 <tr><td>Cloud Services</td><td>Managed Virtual Machines</td><td>Run applications on virtual machines that you don't have to manage, but can partially manage.</td><td>&nbsp;</td></tr>
 <tr><td>Batch</td><td>Azure Distributed Processing</td><td>Work on a large chunk of data by divvying it up between a whole bunch of machines.</td><td>&nbsp;</td></tr>
 <tr><td>RemoteApp</td><td>Remote Desktop for Apps</td><td>Expose non-web apps to users. For example, run Excel on your iPad.</td><td>AppStream</td></tr>
 <tr><td>Web Apps</td><td>Web Site Host</td><td>Run websites (.NET, Node.js, etc.)  without managing anything extra. Scale automatically and easily.</td><td>Elastic Beanstalk</td></tr>
 <tr><td>Mobile Apps</td><td>Mobile App Accelerator</td><td>Quickly get an app backend up and running.</td><td>&nbsp;</td></tr>
 <tr><td>Logic Apps</td><td>Visio for Doing Stuff</td><td>Chain steps together to get stuff done.</td><td>&nbsp;</td></tr>
 <tr><td>API Apps</td><td>API Host</td><td>Host your API's without any of the management overhead.</td><td>&nbsp;</td></tr>
 <tr><td>API Management</td><td>API Proxy</td><td>Expose an API and off-load things like billing, authentication, and caching.</td><td>API Gateway</td></tr>

</table>

## Mobile

<table>
	<tr>
		<td>**Azure Service**</td>
		<td>**Could be Called**</td>
		<td>**Use this to...**</td>
		<td>**Like AWS...**</td>
	</tr>
 
 <tr><td>Notification Hubs</td><td>Notification Blaster</td><td>Send notifications to all of your users, or groups of users based on things like zip code. All platforms.</td><td>SNS</td></tr>
 <tr><td>Mobile Engagement</td><td>Mobile Psychic</td><td>Track what users are doing in your app, and customize experience based on this data.</td><td>&nbsp;</td></tr>
 
</table>

## Storage

<table>
	<tr>
		<td>**Azure Service**</td>
		<td>**Could be Called**</td>
		<td>**Use this to...**</td>
		<td>**Like AWS...**</td>
	</tr>
 
 <tr><td>SQL Database</td><td>Azure SQL</td><td>Use the power of a SQL Server cluster without having to manage it.</td><td>RDS</td></tr>
 <tr><td>Document DB</td><td>Azure NoSQL</td><td>Use an unstructured JSON database without having to manage it.</td><td>Dynamo DB</td></tr>
 <tr><td>Redis Cache</td><td>Easy Cache</td><td>Cache files in memory in a scalable way.</td><td>Elasticache</td></tr>
 <tr><td>Storage Blobs</td><td>Cloud File System</td><td>Store files, virtual disks, and build other storage services on top of.</td><td>S3</td></tr>
 <tr><td>Azure Search</td><td>Index & Search</td><td>Add search capabilities to your website, or index data stored somewhere else.</td><td>CloudSearch</td></tr>
 <tr><td>SQL Data Warehouse</td><td>Structured Report Database</td><td>Store all of your company's data in a structured format for reporting.</td><td>RedShift</td></tr>
 <tr><td>Azure Data Lake</td><td>Unstructured Report Database</td><td>Store all of your company's data in any format for reporting.</td><td>&nbsp;</td></tr>
 <tr><td>HDInsight</td><td>Hosted Hadoop</td><td>Do Hadoopy things with massive amounts of data.</td><td>&nbsp;</td></tr>
 <tr><td>Machine Learning</td><td>Skynet</td><td>Train AI to predict the future using existing data. Examples include credit card fraud detection and Netflix movie recommendations.</td><td>&nbsp;</td></tr>
 <tr><td>Stream Analytics</td><td>Real-time data query</td><td>Look for patterns in data as it arrives.</td><td>&nbsp;</td></tr>
 <tr><td>Data Factory</td><td>Azure ETL</td><td>Orchestrate extract, transform, and load data processes.</td><td>Data Pipeline</td></tr>
 <tr><td>Event Hubs</td><td>IoT Ingestor</td><td>Ingest data at ANY scale inexpensively.</td><td>&nbsp;</td></tr>
 
 </table>

## Networking

<table>
	<tr>
		<td>**Azure Service**</td>
		<td>**Could be Called**</td>
		<td>**Use this to...**</td>
		<td>**Like AWS...**</td>
	</tr> 
 
 <tr><td>Virtual Network</td><td>Private Network</td><td>Put machines on the same, private network so that they talk to each other directly and privately. Expose services to the internet as needed.</td><td>&nbsp;</td></tr>
 <tr><td>ExpressRoute</td><td>Fiber to Azure</td><td>Connect privately over an insanely fast pipe to an Azure datacenter. Make your local network part of your Azure network.</td><td>Direct Connect</td></tr>
 <tr><td>Load Balancer</td><td>Load Balancer</td><td>Split load between multiple services, and handle failures.</td><td>&nbsp;</td></tr>
 <tr><td>Traffic Manager</td><td>Datacenter Load Balancer</td><td>Split load between multiple datacenters, and handle datacenter outages.</td><td>&nbsp;</td></tr>
 <tr><td>DNS</td><td>DNS Provider</td><td>Run a DNS server so that your domain names map to the correct IP addresses.</td><td>Route53</td></tr>
 <tr><td>VPN Gateway</td><td>Virtual Fiber to Azure</td><td>Connect privately to an Azure datacenter. Make your local network part of your Azure network.</td><td>&nbsp;</td></tr>
 <tr><td>Application Gateway</td><td>Web Site Proxy</td><td>Proxy all of your HTTP traffic. Host your SSL certs. Load balance with sticky sessions.</td><td>&nbsp;</td></tr>
 <tr><td>CDN</td><td>CDN</td><td>Make your sites faster and more scalable by putting your static files on servers around the world close to your end users.</td><td>Cloudfront</td></tr>
 <tr><td>Media Services</td><td>Video Processor</td><td>Transcode video and distribute and manage it on the scale of the Olympics.</td><td>Elastic Transcoder</td></tr>

</table>

## Management

<table>
	<tr>
		<td>**Azure Service**</td>
		<td>**Could be Called**</td>
		<td>**Use this to...**</td>
		<td>**Like AWS...**</td>
	</tr> 

 <tr><td>Azure Resource Manager</td><td>Declarative Configuration</td><td>Define your entire Azure architecture as a repeatable JSON file and deploy all at once.</td><td>CloudFormation</td></tr>
</table>

## Developer

<table>
	<tr>
		<td>**Azure Service**</td>
		<td>**Could be Called**</td>
		<td>**Use this to...**</td>
		<td>**Like AWS...**</td>
	</tr> 

 <tr><td>Application Insights</td><td>App Analytics</td><td>View detailed information about how your apps (web, mobile, etc.) are used.</td><td>Mobile Analytics</td></tr>
 <tr><td>Service Fabric</td><td>Cloud App Framework</td><td>Build a cloud optimized application that can scale and handle failures inexpensively.</td><td></td></tr>
</table>
