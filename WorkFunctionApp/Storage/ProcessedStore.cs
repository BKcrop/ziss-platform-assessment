using System.Collections.Generic;
using WorkFunctionApp.Model;

namespace WorkFunctionApp.Storage
{
    public static class ProcessedStore
    {
        public static List<WorkItem> Items { get; } = new();
    }
}