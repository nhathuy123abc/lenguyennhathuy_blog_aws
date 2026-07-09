---
title: "AWS CloudWatch"
date: 2024-01-01
weight: 12
chapter: false
pre: " <b> 5.12. </b> "
---

Amazon CloudWatch is used to monitor logs and trace the request flow of the Lambda functions in SmartCV. This section covers how to standardize logging and enable tracing for the project.

#### Standardizing Logs with AWS Lambda Powertools

Instead of logging as free-form text (which is hard to filter/search), SmartCV uses the **AWS Lambda Powertools** library to standardize logs into **JSON** format, making filtering and searching on CloudWatch much more effective.

1. In the Lambda code, declare a **Logger** object with the service name `"SmartCV"` to categorize and identify the project's logs:

```python
from aws_lambda_powertools import Logger

logger = Logger(service="SmartCV")
```

2. Attach the `@logger.inject_lambda_context` decorator to `lambda_handler` to automatically log contextual information such as Request ID, timestamp, and execution environment:

```python
@logger.inject_lambda_context
def lambda_handler(event, context):
    logger.info("Processing request", extra={"event": event})
    ...
```

![Example of structured JSON log on CloudWatch](/images/5-Workshop/5.12-CloudWatch/image9.png)
**Figure 5.12.1** — Structured JSON log displayed on CloudWatch Logs Insights.

#### Configuring Log Retention and Tracing in CDK

In the CDK infrastructure definition file for the Lambda functions, configure two additional properties:

```typescript
const smartcvFunction = new lambda.Function(this, 'SmartCVFunction', {
  // ... other properties
  logRetention: logs.RetentionDays.ONE_MONTH, // 30 days, optimizes storage cost
  tracing: lambda.Tracing.ACTIVE,             // Enables AWS X-Ray
});
```

- **`logRetention: 30 days`**: automatically deletes logs older than 30 days, avoiding unnecessary long-term log storage costs.
- **`Tracing.ACTIVE`**: integrates **AWS X-Ray**, allowing you to trace the detailed path of a request across multiple services (API Gateway → Lambda → DynamoDB/Bedrock), which is useful for debugging performance issues or errors.

![Configuring logRetention and Tracing in CDK](/images/5-Workshop/5.12-CloudWatch/image10.png)
**Figure 5.12.2** — Configuring `logRetention` and `tracing` in CDK.

#### Viewing Traces in AWS X-Ray

1. Access the **CloudWatch** service → **X-Ray traces** (or open the **X-Ray** service directly).
2. Select a specific trace to view detailed processing time across each service (Service Map).

![Service Map on AWS X-Ray](/images/5-Workshop/5.12-CloudWatch/image11.png)
**Figure 5.12.3** — Service Map on AWS X-Ray showing the request flow through API Gateway, Lambda, and downstream services.

{{% notice note %}}
CloudWatch Log Groups are automatically created with the name `/aws/lambda/<function-name>` and are **not automatically deleted** when you delete the Lambda function. When cleaning up resources in section [5.13](../5.13-cleanup/), remember to also delete these Log Groups to avoid ongoing log storage costs.
{{% /notice %}}
