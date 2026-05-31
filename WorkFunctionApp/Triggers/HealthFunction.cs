using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using System.Net;
using WorkFunctionApp.Constant;

namespace WorkFunctionApp.Triggers
{


    public class HealthFunction
    {
        [Function("HealthLive")]
        public HttpResponseData HealthLive(
            [HttpTrigger(
            AuthorizationLevel.Anonymous,
            "get",
            Route = "health/live")]
        HttpRequestData req)
        {
            var response = req.CreateResponse(HttpStatusCode.OK);

            response.WriteString("Healthy");

            return response;
        }

        [Function("HealthReady")]
        public HttpResponseData HealthReady(
            [HttpTrigger(
            AuthorizationLevel.Anonymous,
            "get",
            Route = "health/ready")]
        HttpRequestData req)
        {
            var response = req.CreateResponse(HttpStatusCode.OK);

            response.WriteString("Ready");

            return response;
        }
    }
}