---
title: "Workshop Introduction"
date: 2024-01-01
weight: 1
chapter: false
pre: " <b> 5.1. </b> "
---

#### Background

**Group project successfully developed and deployed at:** [**https://smartcvknight.click/**](https://smartcvknight.click/)

In an increasingly competitive labor market, a candidate often has to send resumes to multiple companies simultaneously to increase their chances of finding a suitable job. However, managing the application process is still primarily done manually through spreadsheets or personal notes, making it difficult to track application status, interview schedules, CV submission times, and milestones to complete such as sending thank-you emails or following up after interviews.

Besides, many candidates do not have enough experience to evaluate the quality of their resumes. Identifying the strengths and weaknesses of a CV or adjusting the content for specific job positions often takes a lot of time and relies on the advice of experienced individuals.

Stemming from these needs, the **SmartCV** project was built to help job seekers manage their entire application process on a single platform, while integrating **Amazon Bedrock** to analyze CV content and provide AI-based suggestions for improvement.

To meet the requirements for scalability, high availability, and cost optimization, the system is deployed using the **AWS Serverless Architecture** model, leveraging powerful services from the AWS ecosystem.

#### Architecture Overview

The SmartCV system is built on a Serverless architecture on AWS, integrating core services: Amplify Hosting and Route 53 for Frontend, Cognito and API Gateway for authentication and API management, EventBridge and Lambda for logic processing, DynamoDB for data storage, S3 for file storage, Bedrock for AI tasks, SES for sending emails, and CloudWatch for system monitoring.

![SmartCV Architecture Overview](/images/5-Workshop/5.1-Introduction/5.1.jpg)
**Figure 5.1.1** — Overall architecture of the SmartCV system with full AWS Serverless services: Amplify Hosting, Route 53, Cognito, API Gateway, EventBridge, Lambda, DynamoDB, S3, Bedrock (AI LLM), SES, and CloudWatch.

![AWS account identity and deployment Region information](/images/5-Workshop/5.1-Introduction/5.2.jpg)
**Figure 5.1.2** — AWS account configuration interface (e.g., 'HNTNhan') and the selected Region 'Asia Pacific (Singapore)' serving as the central location to deploy all server services for the system in this workshop.

{{% notice tip %}}
**Unify the Region from the start:** Select the **`Asia Pacific (Singapore)`** Region (or `ap-southeast-1` as shown in the console, see Figure 5.1.2) in the top right corner of the AWS Console and keep this Region unchanged for **all** services in the Workshop (DynamoDB, S3, Cognito, Lambda, API Gateway, EventBridge, Bedrock). Region mismatch between services is the most common cause of integration errors.
{{% /notice %}}

#### Environment Preparation

Before you begin, please prepare:
* An active AWS account with permissions to create resources (IAM, Lambda, DynamoDB, S3, Cognito, API Gateway, EventBridge, SES, Bedrock, Amplify).
* **Node.js** (version 18+) installed on your machine to build the Frontend source code and Lambda Layer.
* The SmartCV project source code downloaded to your machine (the root directory containing `lambdas/`, `api/openapi.yml`, `scripts/build_layer.sh`, and the React Frontend).
* **Important:** Complete the "Enable Model Access" step for Amazon Bedrock in section [5.11](../5.11-bedrock/) **before** configuring Lambda in section 5.5, to avoid access permission errors when Lambda calls Bedrock.