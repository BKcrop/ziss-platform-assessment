using Azure.Messaging.ServiceBus;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;

var host = new HostBuilder()
    .ConfigureFunctionsWorkerDefaults()
    .ConfigureServices(services =>
    {
        var serviceBusConnection =
            Environment.GetEnvironmentVariable("ServiceBusConnection")
            ?? throw new InvalidOperationException("ServiceBusConnection not configured.");

        services.AddSingleton(new ServiceBusClient(serviceBusConnection));
    })
    .Build();

host.Run();