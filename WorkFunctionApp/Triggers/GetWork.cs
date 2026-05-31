using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using System.Net;
using System.Threading.Tasks;
using WorkFunctionApp.Storage;
using WorkFunctionApp.Constant;

namespace WorkFunctionApp.Triggers
{

	public class GetWorkFunction
	{
		[Function("GetWork")]
		public async Task<HttpResponseData> Run(
			[HttpTrigger(AuthorizationLevel.Function, "get", Route = "work")]
		HttpRequestData req)
		{
			var response = req.CreateResponse(HttpStatusCode.OK);

			await response.WriteAsJsonAsync(ProcessedStore.Items);

			return response;
		}
	}
}