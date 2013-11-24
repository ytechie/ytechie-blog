---
layout: post
title: Virtual Machines (IaaS) in the Azure Cloud–Outline
date: 2013-07-19
---

I've recently taken some time to deep dive into the Azure IaaS / VM offering, and created an outline with my notes. I'm posting my findings here in case they are useful to anyone.

*   Intro
        *   IaaS - Infrastructure as a service
    *   VM - Virtual machine
    *   Provision a VM without worrying about underlying hardware
    *   Can &quot;magically&quot; create new machines for scaling
    *   Runway to the cloud for existing apps*   Models
        *   Full control of the operating system
            *   This means you'll need to maintain the OS including patches, etc.*   Designed for IT pros to not need developers
    *   These are virtual machines, not VM Roles. If you heard the term &quot;VM Role&quot;, they're gone. VM's have state.*   Management
        *   [Manage.windowsazure.com](http://manage.windowsazure.com)
            *   Live ID's to log in, possible to configure AD, but not trivial*   Think through how subscriptions will be structured
    *   Think through your dev/test environment
    *   [Command line tools](https://www.windowsazure.com/en-us/downloads/?fb=en-us)
    *   You can get some information through the [server manager in visual studio](http://msdn.microsoft.com/en-us/library/windowsazure/jj131259.aspx)
    *   [REST APIs](http://msdn.microsoft.com/en-us/library/windowsazure/ee460799.aspx)
            *   Useful for custom automation*   There are environment deployment tools available such as the [Azure Knife plug-in for Chef](http://www.opscode.com/partners/microsoft/)*   VM sizing/pricing
        *   [Pricing grid](http://www.windowsazure.com/en-us/pricing/details/virtual-machines/)
    *   [Sizing grid](http://msdn.microsoft.com/en-us/library/windowsazure/dn197896.aspx)
    *   Extra small is shared, and should typically only be used for testing, or non-time critical workloads
    *   Prices don't include EA discounts, 6/12 month agreement discounts, or pre-pay discounts
    *   If you are ever going to use an A6/A7 instance, create it FIRST, so that they can be in the same rack
    *   For a detailed architectural overview of Azure, check out the [presentation by Mark Russinovich from Build 2013](http://channel9.msdn.com/Events/TechEd/NorthAmerica/2013/WAD-B402)
    *   In general, it is better to scale out instead of scaling up. You have more expandability when scaling out because you just stand up additional VM's. You'll hit a ceiling if trying to scale up individual machines.
    *   Use your free Azure time included with your MSDN for individual Dev/Test
            *   Up to $150 at highly reduced rates
        *   [http://www.windowsazure.com/en-us/pricing/member-offers/msdn-benefits/](http://www.windowsazure.com/en-us/pricing/member-offers/msdn-benefits/)
        *   Free dev/test licensing with MSDN as always*   Creating
        *   Images
            *   There are a number of stock images available including various OS's and applications
        *   To use, choose &quot;From Gallery&quot; when creating a new VM
        *   Windows Server 2012 and above are Azure optimized
        *   Images that you created will show up in the gallery under &quot;My Images&quot;*   Custom Images
            *   You can sysprep a machine that is already in Azure, and convert it into an image
        *   Your images will be available in the gallery under &quot;My images&quot;
        *   [Can upload a VHD](http://www.windowsazure.com/en-us/manage/windows/common-tasks/upload-a-vhd/)
                *   Up to 128GB VHD is allowed
            *   Create image
            *   Sysprep image before upload
            *   Need VHD, VHDX does not work (to convert, &quot;Actions&quot; pane, choose &quot;edit disk&quot;)
            *   VHD must be &quot;fixed size&quot;, not &quot;dynamically expanding&quot;
            *   Upload using Add-AzureVhd cmdlet*   Disks
        *   When to use each type
            *   C: drive is persistent, uses storage as a backing store
        *   D: is a temporary drive. Very fast, but is deleted if the machine needs to be migrated.*   Data Disks
            *   The size of the machine affects data disk use cases
                *   Larger machines give you more available bandwidth
            *   Larger machines allow a higher number of disks*   Performance &amp; scaling
                *   The temp disk is fast, but volatile
            *   Attach multiple disks and stripe data between them to increase throughput*   Disk performance varies significantly from on premise solutions, so test performance early
    *   [Storage whitepaper](http://download.microsoft.com/download/D/2/0/D20E1C5F-72EA-4505-9F26-FEF9550EFD44/Performance%20Guidance%20for%20SQL%20Server%20in%20Windows%20Azure%20Virtual%20Machines.docx)*   Accessing
        *   When viewing the VM, click &quot;Connect&quot; for an RDP file
    *   Alternatively, run the remote desktop client, use the DNS name or the public virtual IP
            *   You must add/view the endpoint for RDP, this works like NAT
        *   Personally, I like to obscure port numbers to avoid port-sniffers looking for common endpoints*   Pay only for what you use
        *   Shutdown within the VM does NOT stop billing
    *   Shutting down from Azure will deallocate the machine, and stop billing
    *   Used to round up to the hour
    *   Stopped machines would incur charges
    *   Billing is per-minute, with no rounding up
    *   If you shutdown, reboot, or crash a VM, it will still incur costs
    *   Shutting down a VM from PowerShell or the management portal will shut down and deallocate the machine and will not incur costs.*   Affinity groups
        *   [http://social.technet.microsoft.com/wiki/contents/articles/7916.importance-of-windows-azure-affinity-groups.aspx](http://social.technet.microsoft.com/wiki/contents/articles/7916.importance-of-windows-azure-affinity-groups.aspx)
    *   Right now, they're just a convenience, but optimizations can be made around the following:
            *   Keeps application components in the same data center, in the same cluster
        *   Reduces latency
        *   Lowers costs by avoiding cross-datacenter communications*   Cloud service containers
        *   [Endpoints &amp; Load balancing](https://www.windowsazure.com/en-us/manage/windows/common-tasks/how-to-load-balance-virtual-machines/)
    *   Custom probes
    *   Use to group servers into an application
    *   When a VM is created, a cloud service is automatically created.
    *   Be sure to specify the cloud service when creating a VM. You cannot move it later.*   Networking
        *   Using internal IP's bypasses the load balancer
    *   IP's are assigned via DHCP, but the lease is virtually infinite
    *   Rebooting a machine will cause it to get the same IP
    *   Deallocating a machine will get a new IP address and lease
    *   VPN
            *   Allows your cloud infrastructure to be an extension of your on premise network
        *   Site-to-site
                *   Supports certain brands of routers
            *   Can VPN to a Windows Server RAS*   Point-to-site
                *   Individual machines can VPN in to the cloud and get access to that network*   Availability
        *   Use availability sets to tell Azure to create update domains and fault domains to keep your application running during updates and failures.
    *   Availability set provides a 99.95% SLA
    *   [http://blogs.technet.com/b/yungchou/archive/2011/05/16/window-azure-fault-domain-and-update-domain-explained-for-it-pros.aspx](http://blogs.technet.com/b/yungchou/archive/2011/05/16/window-azure-fault-domain-and-update-domain-explained-for-it-pros.aspx)
    *   Update domains
            *   Represents groups of resources that will be updated together
        *   Host OS updates honor service update domains
        *   5 update domains by default, can bump up to 20*   Fault domains
            *   Avoids single points of failure
        *   Represent groups of resources anticipated to fail together i.e. Same rack, same server
        *   Fabric spreads instances across fault at least 2 fault domains*   Procedure for Host OS updates:
            1.  Remove guest from load balancer
        2.  Issue shutdown command
        3.  Host updates and reboots
        4.  Guest booted
        5.  Guest added back to the load balancer