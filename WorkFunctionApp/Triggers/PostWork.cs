using System.IO;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Azure.Messaging.ServiceBus;
using WorkFunctionApp.Constant;

namespace WorkFunctionApp.triggers
{

    public class PostWorkFunction
    {
        private readonly ServiceBusClient _serviceBusClient;

        public PostWorkFunction(ServiceBusClient serviceBusClient)
        {
            _serviceBusClient = serviceBusClient;
        }

        [Function("PostWork")]
        public async Task<HttpResponseData> Run(
            [HttpTrigger(AuthorizationLevel.Function, "post", Route = "work")]
        HttpRequestData req)
        {
            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();

            var sender = _serviceBusClient.CreateSender("workqueue");

            await sender.SendMessageAsync(
                new ServiceBusMessage(requestBody));

            var response = req.CreateResponse(System.Net.HttpStatusCode.Accepted);

            await response.WriteStringAsync("Message queued successfully.");

            return response;
        }
    }

}