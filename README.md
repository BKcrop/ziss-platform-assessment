# Platform Engineer Assessment

## Overview

This solution demonstrates a cloud-native event-driven platform built on Microsoft Azure using Infrastructure as Code, CI/CD automation, observability, and secure authentication practices.

The platform exposes HTTP APIs through Azure API Management, publishes work requests to Azure Service Bus, and processes messages asynchronously using Azure Functions.

---

## Architecture

```text
Client
  |
  v
Azure API Management
  |
  v
Azure Function (HTTP Trigger)
  |
  v
Azure Service Bus Queue
  |
  v
Azure Function (Service Bus Trigger)
  |
  v
Processed Store
```

### Components

| Component            | Purpose                         |
| -------------------- | ------------------------------- |
| Azure API Management | API Gateway                     |
| Azure Function App   | HTTP and Service Bus processing |
| Azure Service Bus    | Asynchronous messaging          |
| Application Insights | Monitoring and logging          |
| Azure Monitor        | Alerting                        |
| Azure Key Vault      | Secret management               |
| Managed Identity     | Secure authentication           |
| Terraform            | Infrastructure provisioning     |
| GitHub Actions       | CI/CD automation                |

---

## API Endpoints

### Health Checks

```http
GET /health/live
GET /health/ready
```

### Work Endpoints

```http
GET /work
POST /work
```

### Sample Request

```json
{
  "name": "Assessment Test"
}
```

---

## Repository Structure

```text
.
??? .github
?   ??? workflows
?       ??? platformci.yml
?       ??? platformcd.yml
?
??? infra
?   ??? providers.tf
?   ??? variables.tf
?   ??? outputs.tf
?   ??? servicebus.tf
?   ??? functionapp.tf
?   ??? keyvault.tf
?   ??? apim.tf
?   ??? monitoring.tf
?   ??? environments
?       ??? dev.tfvars
?       ??? prod.tfvars
?
??? WorkFunctionApp
?   ??? Triggers
?   ??? Model
?   ??? Storage
?   ??? Program.cs
?   ??? host.json
?
??? README.md
```

---

## Infrastructure Deployment

Terraform provisions:

* Resource Group
* Storage Account
* Azure Function App
* Service Bus Namespace
* Service Bus Queue
* Application Insights
* Log Analytics Workspace
* Azure Key Vault
* Azure API Management
* Azure Monitor Alerts
* Role Assignments

---

## CI Pipeline

The CI pipeline performs:

1. Source checkout
2. .NET restore
3. Build
4. Unit tests
5. Trivy security scan
6. Publish Function package
7. Publish artifacts

Artifact outputs:

* Function Application Package
* Terraform Infrastructure Package

---

## CD Pipeline

The CD pipeline performs:

1. Environment selection
2. Azure OIDC authentication
3. Terraform plan
4. Manual approval
5. Terraform apply
6. Function deployment
7. Health validation

Supported environments:

* dev
* prod

---

## Security

The solution follows security best practices:

* GitHub OIDC Federated Credentials
* Managed Identity
* No secrets stored in source code
* Azure Key Vault integration
* Role-based access control (RBAC)

---

## Monitoring & Observability

* Application Insights
* Azure Monitor Alerts
* Structured Function logging
* Health endpoints
* Service Bus retry handling

---

## Reliability Considerations

* Service Bus retry policy
* Dead-letter queue support
* Health probes
* Environment-specific deployments
* Infrastructure as Code
* Repeatable deployments

---

## Known Limitations

* Processed items are stored in-memory for demonstration purposes.
* Persistence layer can be replaced with Azure Table Storage, Cosmos DB, or Azure SQL.
* APIM policies are intentionally simplified for assessment purposes.

---

## Author

Platform Engineer Assessment Submission
