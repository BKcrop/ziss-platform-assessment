using System;

namespace WorkFunctionApp.Model
{
    public class WorkItem
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string Name { get; set; }
        public DateTime ProcessedAt { get; set; }
    }
}