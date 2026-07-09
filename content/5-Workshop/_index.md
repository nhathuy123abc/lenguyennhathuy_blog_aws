---
title: "Workshop"
date: 2024-01-01
weight: 5
chapter: false
pre: " <b> 5. </b> "
---

# AI-Powered Job Application Tracking and Optimization System

#### Project Overview

Welcome to the **SmartCV** deployment Workshop – an AI-powered job application tracking and optimization system built on the **AWS Serverless Architecture**. The project helps users manage job applications, track recruitment statuses, store Resumes and Cover Letters, and uses AI models on **Amazon Bedrock** to analyze profiles, provide feedback, and suggest improvements to enhance the chances of getting hired.

In practice, the system is deployed using Infrastructure as Code (AWS CDK) to automate infrastructure provisioning. However, in this Workshop, all AWS services will be configured using the **Click-Ops** method through the AWS Management Console, helping learners clearly understand the role of each service and how components in a Serverless architecture connect with each other.

{{% notice tip %}}
**Select a Region from the start:** The entire Workshop uses the same Region — **`ap-southeast-1` (Singapore)** is recommended. Before starting, select this Region in the top right corner of the AWS Console and keep it unchanged throughout for all services (DynamoDB, S3, Cognito, Lambda, API Gateway, EventBridge, Bedrock).

**Enable Bedrock Model Access first:** Since the Lambda in section 5.5 will call Amazon Bedrock, you should complete the "Enable Model Access" step in section **5.10** *before* doing section 5.5, to avoid an `AccessDeniedException` error when testing Lambda.
{{% /notice %}}

After completing the Workshop, participants will achieve:
* An understanding of Cloud-Native and Serverless architectures on the AWS platform.
* A grasp of the deployment process for Amazon DynamoDB, Amazon S3, Amazon Cognito, AWS Lambda, Amazon API Gateway, Amazon EventBridge, Amazon SES, Amazon Bedrock, and AWS Amplify.
* The successful build of the SmartCV system: managing applications, uploading Resumes, authenticating users, sending reminder emails, tracking application progress, and analyzing profiles using AI.
* An understanding of how to integrate a React Frontend with a Serverless Backend on AWS.

#### Contents

1. [Workshop Introduction](5.1-Introduction/)
2. [Amazon DynamoDB](5.2-DynamoDB/)
3. [Amazon S3](5.3-S3/)
4. [Amazon Cognito](5.4-Cognito/)
5. [AWS Lambda](5.5-Lambda/)
6. [Amazon SES](5.6-SES/)
7. [Amazon API Gateway](5.7-APIGateway/)
8. [Amazon EventBridge](5.8-EventBridge/)
9. [AWS Amplify](5.9-Amplify/)
10. [Amazon Route 53](5.10-Route53/)
11. [Amazon Bedrock](5.11-Bedrock/)
12. [AWS CloudWatch](5.12-CloudWatch/)
13. [Dọn dẹp tài nguyên](5.13-Cleanup/)
