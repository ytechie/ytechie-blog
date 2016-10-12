---
layout: post
title: Transport Agnostic Cloud to Device Messaging with IoT Hub
date: 2016-10-12
---

The Azure IoT hub provides an easy and secure way to not only send data from a device to the cloud, but for the cloud to send data to a device.

**Device to Cloud**

Sending a message from a device to the cloud is as simple as

`await deviceClient.SendEventAsync(message);`

You can find a more complete example in the [GitHub repository I created for the code that runs on the Raspberry Pi in my office.](https://github.com/ytechie/jasons-office-iot)

**Cloud to Device**

Receiving data from the cloud is a little more tricky. The pattern used by the IoT hub is to have the client always establish an outbound connection. This has major advantages outside of the scope of this article.

The biggest challenge is that the `DeviceClient.ReceiveAsync()` method is deceptively simple, and is unfortunately a leaky abstraction. The behavior of the method changes based on whether we're using AMQP, HTTP, or MQTT.

When using **HTTP** to check for a message, the response is received immediately. If you put this into a `while(true)` loop, you'll be hammering the IoT hub repeatedly, and you'll be wasting bandwidth.

In contrast, when you use **AMQP** to check for a message, the connection is held open as long as possible (with a configurable timeout), and returns a message immediately when one becomes available.

It is possible to specify the transport when creating our device client:

`var deviceClient = DeviceClient.Create(hubHostname, auth, TransportType.Http1);`

Let's take a look how we can use a pattern that will work for both types of patterns, polling and "hold and wait":

    while (true)
    {
        Console.WriteLine("Polling for message...");
        var preCheckTime = DateTime.UtcNow;
        var message = await _client.ReceiveAsync();
        if (message == null)
        {
            //Check if we got a null back in a short amount of time
            if (preCheckTime > DateTime.UtcNow.AddSeconds(-5))
            {
                //The amount of time to wait between polls
                await Task.Delay(TimeSpan.FromSeconds(2));
            }
        }
        else
        {
            RaiseEventReceived(message); //A method I created to raise an event
            await _client.CompleteAsync(message);
            //Immediately call again to drain the queue
        }
    }

Basically, we're checking if we get a `null` message "quickly". In the code above, if we get `null` back in less than 5 seconds, we assume that we should wait to poll again. If `ReceiveAsync` blocks for more than 5 seconds, or if we get a message, we know we can check for another message immediately.