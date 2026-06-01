# Platform Engineer Assessment

## Overview

This solution demonstrates a cloud-native, event-driven platform built on Microsoft Azure using Infrastructure as Code (Terraform), CI/CD automation, observability, secure authentication, and asynchronous messaging patterns.

The platform exposes HTTP APIs through Azure API Management, publishes work requests to Azure Service Bus, and processes messages asynchronously using Azure Functions.

Azure Functions were selected as the compute platform because the workload is event-driven and benefits from native HTTP and Service Bus trigger integrations. While Azure Container Apps was listed as the preferred compute option in the assessment, Azure Functions satisfy the alternative Azure compute requirement while reducing operational complexity.

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

### Architecture Flow

1. Client submits a work request through Azure API Management.
2. Azure Function receives the request and publishes a message to Azure Service Bus.
3. Service Bus decouples request ingestion from processing.
4. A background Azure Function processes messages asynchronously.
5. Processed items are stored and exposed through the API.
6. Application Insights and Azure Monitor provide observability and alerting.

---

## Components

| Component | Purpose |
|------------|------------|
| Azure API Management | API Gateway and API exposure |
| Azure Function App | HTTP and Service Bus processing |
| Azure Service Bus | Asynchronous messaging |
| Application Insights | Monitoring, telemetry, and logging |
| Azure Monitor | Alerting and operational monitoring |
| Azure Key Vault | Secret management |
| Managed Identity | Secure authentication |
| Terraform | Infrastructure provisioning |
| GitHub Actions | CI/CD automation |

---

## Design Decisions

### Why Azure Functions?

Azure Functions were chosen because:

- Native support for HTTP triggers
- Native support for Service Bus triggers
- Automatic scaling
- Reduced infrastructure management
- Well-suited for event-driven workloads

For a production implementation requiring container portability, custom runtimes, or microservice hosting, the same architecture could be deployed using Azure Container Apps with Azure Container Registry and KEDA-based queue scaling.

### Why Service Bus?

Azure Service Bus was selected to:

- Decouple API requests from processing
- Improve resiliency
- Support retries and dead-letter handling
- Enable independent scaling of producers and consumers

---

## API Endpoints

### Health Endpoints

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

### Expected Behaviour

#### POST /work

- Accepts a work request
- Publishes a message to Azure Service Bus
- Returns an Accepted response

#### GET /work

- Returns processed items

#### GET /health/live

- Returns application liveness status

#### GET /health/ready

- Returns application readiness status

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
?   ??? dev.tfvars
?   ??? prod.tfvars
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

Terraform provisions the following Azure resources:

- Resource Group
- Storage Account
- Azure Function App
- Service Bus Namespace
- Service Bus Queue
- Application Insights
- Log Analytics Workspace
- Azure Key Vault
- Azure API Management
- Azure Monitor Alerts
- Managed Identity
- RBAC Role Assignments

Infrastructure is fully reproducible and environment-specific.

---

## CI Pipeline

The CI pipeline performs:

1. Source checkout
2. .NET restore
3. Application build
4. Unit test execution
5. Trivy security scan
6. Function package generation
7. Artifact publishing

### Published Artifacts

- Function Application Package
- Terraform Infrastructure Package

---

## CD Pipeline

The CD pipeline performs:

1. Environment selection
2. Azure authentication using GitHub OIDC
3. Terraform plan
4. Manual approval gate
5. Terraform apply
6. Function deployment
7. Post-deployment validation

### Supported Environments

- dev
- prod

---

## Security

The solution follows Azure security best practices:

- GitHub OIDC Federated Credentials
- Managed Identity authentication
- No secrets stored in source code
- Azure Key Vault integration
- Role-Based Access Control (RBAC)
- Principle of Least Privilege

---

## Monitoring & Observability

The platform includes:

- Application Insights
- Azure Monitor Alerts
- Structured Function Logging
- Health Endpoints
- Service Bus Retry Handling
- Centralized Telemetry Collection

### Example Alert

- Function Failure Count exceeds threshold
- Failed Request Rate exceeds threshold

---

## Reliability Considerations

The implementation includes:

- Service Bus retry policy
- Dead-letter queue support
- Health probes
- Environment-specific deployments
- Infrastructure as Code
- Repeatable deployments
- Decoupled processing architecture

---

## Scaling Considerations

### Current Implementation

Azure Functions automatically scale based on:

- HTTP traffic
- Service Bus message volume

### Future Enhancements

Potential production improvements:

- Persistent storage using Azure SQL, Cosmos DB, or Table Storage
- Distributed tracing using OpenTelemetry
- Advanced APIM policies
- Multi-region deployment
- Containerized deployment using Azure Container Apps

---

## Known Limitations

- Processed items are stored in-memory for demonstration purposes.
- Data is not persisted across Function App restarts.
- APIM policies are intentionally simplified for assessment purposes.
- Azure Container Apps and ACR deployment were not implemented because Azure Functions were selected as the compute platform.

---

## Deployment Steps

### Infrastructure Deployment

```bash
terraform init
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```

### Application Deployment

Application deployment is performed automatically through GitHub Actions.

---

## Author

**Balaji**

Platform Engineer Assessment Submission