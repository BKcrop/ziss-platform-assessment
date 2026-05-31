using Azure.Messaging.ServiceBus;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using System;
using System.Text.Json;
using System.Threading.Tasks;
using WorkFunctionApp.Model;
using WorkFunctionApp.Storage;
using WorkFunctionApp.Constant;

namespace WorkFunctionApp.Triggers
{

    public class WorkProcessor
    {
        private readonly ILogger<WorkProcessor> _logger;

        public WorkProcessor(
            ILogger<WorkProcessor> logger)
        {
            _logger = logger;
        }

        [Function("WorkProcessor")]
        public async Task Run(
            [ServiceBusTrigger(
            "%WorkQueueName%",
            Connection = "ServiceBusConnection")]
        string message)
        {
            try
            {
                var item =
                    JsonSerializer.Deserialize<WorkItem>(message);

                if (item != null)
                {
                    item.ProcessedAt = DateTime.UtcNow;

                    ProcessedStore.Items.Add(item);

                    _logger.LogInformation(
                        "Processed item {Id}",
                        item.Id);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(
                    ex,
                    "Failed processing Service Bus message");

                throw;
            }

            await Task.CompletedTask;
        }
    }
}