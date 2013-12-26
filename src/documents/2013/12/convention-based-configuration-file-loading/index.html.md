---
layout: post
title: Convention-Based Configuration File Loading
date: 2013-12-26
---
I'm working on a modular project with numerous services and processes that all work and communicate together, which requires a fair amount of configuration. In my IoC configuration, my code was starting to get ugly due to the need to manually inject constructor parameters for things like port numbers, timeouts, addresses, etc.:

    container.RegisterType<ReceiverController>(
        new TransientLifetimeManager(), new InjectionConstructor(dataCollectorQueueName, typeof(IDatasourceRecordSerializer)));

Every class that required configuration (in this case, `dataCollectorQueueName`) required an explicit registration line since the parameters are ambiguous to an IoC container. I use IoC containers as a productivity tool, and they have very little value unless I can automatically [wire-up dependencies by convention](http://blogs.msdn.com/b/agile/archive/2013/03/12/unity-configuration-registration-by-convention.aspx).

I created a method that loads a JSON file and maps it to a class instance at run-time based on a specified naming convention. You can include the configuration files in your project, or store them anywhere you like. In my case, I've included them in my project and set them to copy to the output folder. When the code is used in production, the files can easily be edited. This could even be extended to watch the files at runtime and make configuration changes on-the-fly.

Here is the code:

	public static void LoadFromConfigurationFile(IUnityContainer container, string file, string classNameConvention)
	{
	    var fileName = Path.GetFileNameWithoutExtension(file);
	    var className = string.Format(classNameConvention, fileName);

	    var types = new List<Type>();
	    foreach (var assembly in AppDomain.CurrentDomain.GetAssemblies())
	    {
	        try
	        {
	            var t = assembly.GetTypes();
	            types.AddRange(t);
	        }
			// http://haacked.com/archive/2012/07/23/get-all-types-in-an-assembly.aspx/
	        catch (ReflectionTypeLoadException ex)
	        {
	            types.AddRange(ex.Types);
	        }
	    }

	    var matchingTypes = types.Where(x => x != null && x.Name == className).ToList();
	    if (matchingTypes.Count == 0)
	        return;
	    if (matchingTypes.Count > 1)
	        throw new Exception(string.Format("Multiple types found with the name '{0}'", className));

	    var type = matchingTypes.First();
	    if (container.IsRegistered(type))
	        return;

	    var configJson = File.ReadAllText(file);
	    var deserialized = JsonConvert.DeserializeObject(configJson, type);

	    //Naming the instance BREAKs the resolving
	    container.RegisterInstance(type, deserialized, new ContainerControlledLifetimeManager());
	}

Here is process:

1. Read the name of the file. This is important for our convention.
2. Using the `classNameConvention`, determine what class name we're looking for. I'm using "{0}Configuration".
3. Load all available types.
4. Find the class with the name that matches our convention.
5. Deserialize the configuration file into the type we're mapping to. I'm using [JSON.NET](https://json.codeplex.com/).
6. Register the object with our IoC container. I'm using [Unity](https://unity.codeplex.com/).

Then, to turn this into a one-liner in my application, I created a method that iterates through all the files in a folder, mapping their configuration data by calling our original method.

    public static void LoadConfigurations(IUnityContainer container, string configurationFilesPath, string classNameConvention)
    {
        var configurationFiles = Directory.GetFiles(configurationFilesPath);
        foreach (var file in configurationFiles)
        {
            LoadFromConfigurationFile(container, file, classNameConvention);
        }
    }

Here is what a configuration file can look like (DataCollector.json):

	{
		"Port": 1234,
		"MsmqQueueName": "DataCollectorQueue"
	}

And the corresponding class. Notice the name follows our convention.

    public class DataCollectorConfiguration
    {
        public int Port { get; set; }
        public string MsmqQueueName { get; set; }
    }

Now, any class that needs configuration data from this class simply requires it in the constructor:

	public class Foo
	{
		public Foo(DataCollectorConfiguration config)
		{
			//We have our configuration here!
		}
	}

### Application Configuration

The auto-registration that Unity (and other IoC) provides will auto-wire configuration classes to any classes that need it. Very little code is required:

	container.RegisterTypes(
        AllClasses.FromAssembliesInBasePath(),
        WithMappings.FromAllInterfaces,
        WithName.Default,
        WithLifetime.ContainerControlled);

This makes creating new classes simple and fast. We just define what our dependencies are in our constructor signature, and we allow them to be supplied to us. That's the core idea behind dependency injection. No need to worry about both the consumer and producer of the object instances. We can focus on the logic of the class we're creating.

### Problems in Paradise

I ran into a fairly significant issue/bug with Unity. After registering my configuration classes, the auto-registration in Unity would overwrite my configuration instances. Unity is actually supposed to throw a `DuplicateTypeMappingException` when auto-registration is trying to register a class that is already registered. In short, Unity was allowing me to shoot myself in the foot.

The solution was to filter the type list that Unity was using. First, I created a testable extension method that would allow me to filter a type list based on an existing type list:

    public static IEnumerable<Type> ExcludeTypes(this IEnumerable<Type> applyToTypes, IEnumerable<Type> excludeTypes)
    {
        return applyToTypes.Where(x => !excludeTypes.Contains(x));
    }

I was then able to switch the auto-registration code from `AllClasses.FromAssembliesInBasePath()` to `AllClasses.FromAssembliesInBasePath().ExcludeTypes(registeredTypes)`:

    var registeredTypes = container.Registrations.Select(x => x.MappedToType);

    container.RegisterTypes(
        AllClasses.FromAssembliesInBasePath().ExcludeTypes(registeredTypes),
        WithMappings.FromAllInterfaces,
        WithName.Default,
        WithLifetime.ContainerControlled);

### Conclusion

I wrapped up my configuration blocks in classes, making the entire system modular and easy to use. Now I can focus on adding code to solve business problems, not worrying about wire-up. The code I use to build a new service in the application simply has to initialize its configuration using code like this:

    _container = new UnityContainer();
    ConfigurationLoader.LoadConfigurations(_container, ".\\Configuration\\", "{0}Configuration");
    FrameworkContainer.RegisterTypes(_container);
    //Register any other modules needed for additional functionality
    DataCollectorContainer.RegisterTypes(_container);