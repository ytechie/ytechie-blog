* Satya Keynote
    * "Amplify their capability"
    * Inclusive design
    * IoT, AI
    * Intelligent edge
    * Extending the Microsoft graph
    * [Project Emma ](https://www.youtube.com/watch?v=k9Rm-U9havE)
* IoT
    * Edge -> IoT Hub -> ASA -> ML
    * Bring ASA, ML, and functions to the edge
    * Use the exact same logic used in Azure, in the edge
        * Package in Docker containers
        * [https://github.com/azure/iot-edge](https://github.com/azure/iot-edge)
    * Sam George presentation:
        * [https://channel9.msdn.com/Events/Build/2017/C9C001](https://channel9.msdn.com/Events/Build/2017/C9C001)
* Bots
    * Cortana Channel
    * [http://adaptivecards.io/](http://adaptivecards.io/)
* Cortana
    * Harmon Kardon, HP, Intel all announced hardware
    * Skills in public preview
    * Make Skype calls
* Machine Learning
    * Real time ML video processing on the edge demo:
        * [http://www.popularmechanics.com/technology/infrastructure/news/a26456/microsoft-machine-learning-vision/](http://www.popularmechanics.com/technology/infrastructure/news/a26456/microsoft-machine-learning-vision/)
    * ND VM instances with Nvidia P40 GPUs
        * Optimized for deep learning
        * 3,840 CUDA cores
        * 12 teraflops
        * 24GB GDDR5
    * Custom vision services
        * Train with your own images
        * [https://azure.microsoft.com/en-us/services/cognitive-services/custom-vision-service/](https://azure.microsoft.com/en-us/services/cognitive-services/custom-vision-service/)
        * [https://www.customvision.ai](https://www.customvision.ai)
    * Story remix: [Introducing Story Remix in Windows 10](https://www.youtube.com/watch?v=kh0be6z-Zl8)
* Azure
    * Azure console
    * Azure mobile app
        * With integrated Azure shell!
    * Data platform:
        https://blogs.technet.microsoft.com/dataplatforminsider/2017/05/10/serving-ai-with-data-a-summary-of-build-2017-data-innovations/
    * DocDB -> Cosmos DB
        * [https://docs.microsoft.com/en-us/azure/cosmos-db/introduction](https://docs.microsoft.com/en-us/azure/cosmos-db/introduction)
        * Multiple API's
            * Table storage
            * DocumentDB
            * MongoDB
            * Gremlin
        * Gigabytes to petabytes
        * Millions of transactions / sec
        * Turnkey global distribution
        * Elastic scale
        * 99.99% SLA in a single region. SLA's for availability, latency, throughput, and consistency.
        * Local emulator
        * 5 consistencies:
            * [https://docs.microsoft.com/en-us/azure/documentdb/documentdb-consistency-levels](https://docs.microsoft.com/en-us/azure/documentdb/documentdb-consistency-levels)
        * Graph database
            * Gremlin interface
            * Build on TinkerPop with Cosmos backend
        * Technical details:
            * [https://azure.microsoft.com/en-us/blog/a-technical-overview-of-azure-cosmos-db/](https://azure.microsoft.com/en-us/blog/a-technical-overview-of-azure-cosmos-db/)
    * MySQL and PostreSQL as a managed service:
        * [https://azure.microsoft.com/en-us/services/postgresql/](https://azure.microsoft.com/en-us/services/postgresql/)
    * Serverless / functions
        * VS2017 tooling support
            * Requires VS2017 Preview
        * App Insights integration
        * One of the services moving to the IoT edge
    * Accelerated networking
        * Public preview of Accelerated Networking for Windows VMs.
            * Public Preview for Windows is available on VMs with 8 or
            * more cores in most regions.
        * [https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-create-vm-accelerated-networking](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-create-vm-accelerated-networking)
    * Azure Data Lake tools for VSCode:
        * [https://blogs.msdn.microsoft.com/azuredatalake/2017/05/12/ga-azure-data-lake-tools-for-visual-studio-code-vscode/](https://blogs.msdn.microsoft.com/azuredatalake/2017/05/12/ga-azure-data-lake-tools-for-visual-studio-code-vscode/)
* Windows
    * Windows 10 on 500 million devices
    * Fall Creators Update
        * Fluent design: [Microsoft Fluent Design System](https://www.youtube.com/watch?v=vcBGj4R7Fo0)
            * Light – Light helps enable the ability to draw someone’s
                * attention, or more clearly guide them through their
                * navigations
            * Depth – Depth helps us understand how things relate to
                * each other when they’re within a more layered,
                * physical environment
            * Motion – Motion is a powerful way to establish context
                * and imply relationships between content in natural,
                * subtle and delightful ways
            * Material – Material can help take full advantage of the
                * available screen space to celebrate content. It can
                * also bring a sense of lightweight, ephemeral user
                * experience
            * Scale – Scale allows us expand our toolbox for more
                * dimensions, inviting innovation across new device form
                * factors
        * Cloud clipboard:
            * [https://thenextweb.com/apps/2017/05/11/microsofts-cloud-clipboard-lets-copy-paste-devices/](https://thenextweb.com/apps/2017/05/11/microsofts-cloud-clipboard-lets-copy-paste-devices/)
        * Windows 10s
            * Store apps only
            * Centennial apps work but no side-load
        * OneDrive placeholders:
            * [https://blogs.office.com/2017/05/11/introducing-onedrive-files-on-demand-and-additional-features-making-it-easier-to-access-and-share-files/](https://blogs.office.com/2017/05/11/introducing-onedrive-files-on-demand-and-additional-features-making-it-easier-to-access-and-share-files/)
        * Timeline - similar to handoff between devices
* Windows Story Remix: [Introducing Story Remix in Windows 10](https://www.youtube.com/watch?v=kh0be6z-Zl8)
* Modernize codebase
    * .NET Standard for UWP available later this year
* Microsoft Graph
    * Adding user activities:
        * [https://github.com/Microsoft/project-rome](https://github.com/Microsoft/project-rome)
* Windows store
    * Full uwp support in mobile center
    * iTunes in the Windows store
    * Spotify in the Windows store
* Narrator developer mode to put yourself in their shoes
* Adaptive cards:
    * [http://adaptivecards.io/](http://adaptivecards.io/)
* Win 10 on ARM
    * [https://channel9.msdn.com/Events/Build/2017/P4171](https://channel9.msdn.com/Events/Build/2017/P4171)
    * Using Qualcomm hardware today
        * Shipping with real devices - 2 in 1's, laptops, etc.
* BASH
    * SUSE and Fedora coming
* Mobile center adding support for UWP
    * CI/CD pipeline
* VR
    * Controller announced: [Tools for Traveling Through a New Reality](https://www.youtube.com/watch?v=1nlcdDNOdm8)
* .NET
    * Debug snapshots in production
    * VS for Mac GA
        * [https://blogs.msdn.microsoft.com/visualstudio/2017/05/10/visual-studio-for-mac-now-generally-available/](https://blogs.msdn.microsoft.com/visualstudio/2017/05/10/visual-studio-for-mac-now-generally-available/)
        * Visual Studio
            * [https://blogs.msdn.microsoft.com/visualstudio/2017/05/12/a-lap-around-python-in-visual-studio-2017/](https://blogs.msdn.microsoft.com/visualstudio/2017/05/12/a-lap-around-python-in-visual-studio-2017/)
    * Xamarin live player
        * No mac needed
        * Install phone app, deploy to that
        * [https://www.xamarin.com/live](https://www.xamarin.com/live)
        * Pair with QR code
    * .NET standard 2.0
        * The set of API's that work in all .NET implementations
        * .NET Core implements these standards
        * Added 20,000 API's since last June
        * 70% of existing Nuget code will run on .NET standard
            * Exceptions usually take a platform dependency
    * XAML Standard
        * Based on Xamarin Forms
        * Share code between Xamarin forms and UWP


Other Resources:

* [https://blogs.technet.microsoft.com/stbnewsbytes/2017/05/11/cloud-platform-release-announcements-for-may-11-2017/](https://blogs.technet.microsoft.com/stbnewsbytes/2017/05/11/cloud-platform-release-announcements-for-may-11-2017/)
* [https://blogs.technet.microsoft.com/stbnewsbytes/2017/05/10/cloud-platform-release-announcements-for-may-10-2017/](https://blogs.technet.microsoft.com/stbnewsbytes/2017/05/10/cloud-platform-release-announcements-for-may-10-2017/)
* [https://channel9.msdn.com/Events/Build/2017](https://channel9.msdn.com/Events/Build/2017)
