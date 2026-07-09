---
title: "Proposal"
date: 2026-06-01
weight: 2
chapter: false
pre: " <b> 2. </b> "
---


# SmartCV – AI-Powered Job Application Tracker
## AWS Serverless Solution for Tracking and Analyzing the Job Search Journey

### 1. Project Overview (4-Member Team)
SmartCV is an AI-powered job application tracking platform built entirely on AWS with a serverless architecture. The application allows users to record their entire application process, analyze data to discover trends (which resume version has the highest response rate, which channel is most effective, which company size is the best fit), and receive personalized coaching from Amazon Bedrock through a chat interface. The system also sends daily reminder emails and weekly summaries with AI-generated suggestions.

### 2. Problem Statement
*Current Problem*
Job seekers typically track applications using spreadsheets or scattered notes, with no systematic analysis. They don't know which resume version is most effective, which channel yields more interviews, or how many opportunities they've missed by failing to follow up on time. Third-party tools like LinkedIn or ATS trackers are often complex, expensive, or lack personalized analytics.

*The Solution*
SmartCV uses AWS DynamoDB for storing application data, AWS Lambda & API Gateway as a serverless backend, Amazon Cognito for user authentication, Amazon S3 for PDF resume storage, Amazon Bedrock (Nova Lite) for AI coaching via chat, and Amazon SES for automated email delivery. The frontend is built with React + Vite and deployed via AWS Amplify/GitHub Pages. The entire infrastructure is defined using AWS CDK (Infrastructure as Code).

*Core Benefits:*
Time Optimization: Reduces manual resume management time by 80% compared to Excel through automation.
Higher Success Rate: AI-powered data analysis identifies resume bottlenecks, and follow-up reminders ensure no interview opportunity is missed.
Personalization: AI Coaching from Bedrock provides in-depth, personalized application strategies for each user.

*ROI Analysis:*
Ultra-low Cost: Leverages AWS Free Tier; operational cost is only ~$0.20–$0.50/month.
Break-even Value: Saving just 2 hours/week pays for itself. Low operational costs save budget.
Opportunity Value: Significantly shortens job search duration, delivering major financial benefit through earlier employment.



### 3. Solution Architecture
SmartCV's architecture is built on an optimized Serverless model on AWS, ensuring automatic scalability at low cost. The system uses React and Vite for the Frontend interface, deployed directly via AWS Amplify — which integrates Amazon CloudFront for global content delivery. The backend is designed with API Gateway connecting to logic-processing functions in AWS Lambda, using Amazon DynamoDB to store application data and Amazon S3 for PDF resume management. The AI Coaching feature is integrated through Amazon Bedrock, while Amazon SES handles sending reminder emails and periodic reports. The entire infrastructure is managed as code (IaC) via AWS CDK with an automated CI/CD pipeline.


![SmartCV Architecture](/images/2-Proposal/sodokientruc.jpg)

- *Amazon Cognito*: User authentication (sign-up/sign-in).
- *API Gateway*: REST API endpoint for the frontend.
- *AWS Lambda*: 6 handler functions: applications, insights, settings, notes, followup, digest.
- *Amazon DynamoDB*: Stores application data, notes, and settings.
- *Amazon S3*: Stores users' PDF resumes.
- *Amazon Bedrock*: AI coaching (chat & weekly summary).
- *Amazon SES*: Daily follow-up reminder emails & weekly digest emails.
- *AWS Amplify / GitHub Pages*: Hosts the React frontend.
- *AWS CDK*: Infrastructure as Code.
- *GitHub Actions*: Automated CI/CD deployment.
- *EventBridge*: Scheduled triggers for Lambda digest & follow-up.



*Component Design*
- *Frontend Layer (User Interface)*: React + Vite interface deployed via AWS Amplify. Users log in through Amazon Cognito, manage job applications on a Kanban board, view an analytics dashboard, and chat with the AI Coach.
- *API Layer (Request Handling)*: Amazon API Gateway receives all requests from the frontend, validates JWT tokens from Cognito, and routes them to the appropriate Lambda function.
- *Logic Layer (Lambda Functions)*: 6 Python Lambda functions handle all business logic:
  - `applications`: CRUD for job applications, filtering/searching.
  - `insights`: Calculates patterns, response rates, calls Bedrock for AI chat.
  - `settings`: Manages weekly goals and streaks.
  - `notes`: Timeline-based notes for each job application.
  - `followup`: Scans DynamoDB daily, sends SES reminder emails.
  - `digest`: Aggregates weekly data, calls Bedrock to generate suggestions, sends digest email.
- *Data Layer (Storage)*: Amazon DynamoDB stores all data (applications, settings, notes) with a single-table design partitioned by `userId`. Amazon S3 stores PDF resumes uploaded by users.
- *AI Layer (Artificial Intelligence)*: Amazon Bedrock (Amazon Nova Lite) receives application data context from Lambda and generates personalized coaching responses for each user.
- *Notification Layer (Email)*: Amazon SES sends daily follow-up emails and weekly digest emails. Amazon EventBridge schedules automatic Lambda triggers.
- *Infrastructure Layer (IaC & CI/CD)*: AWS CDK defines the entire infrastructure as TypeScript code. GitHub Actions automatically runs tests and deploys on every new commit.

### 4. Technical Implementation

*Implementation Phases*
The project has two parts — building the AWS backend and developing the React frontend — each following 4 phases:
1. *Research and Architecture Design*: Analyze requirements, design the AWS Serverless architecture diagram, assign tasks among 4 team members.
2. *Cost Estimation and Feasibility Check*: Use AWS Pricing Calculator to estimate costs, check Free Tier limits, and adjust service choices if needed.
3. *Core Infrastructure and Feature Development*: Deploy CDK Stack, develop Lambda functions, connect DynamoDB, S3, API Gateway, and integrate Cognito.
4. *Advanced Feature Development, Testing & Deployment*: Integrate Amazon Bedrock for AI coaching, Amazon SES for automated email, write unit tests and integration tests, CI/CD via GitHub Actions, push to production.

*Technical Requirements*
- *Backend (Lambda + DynamoDB)*: Python 3.12, AWS CDK (TypeScript), boto3, Pydantic for data validation, AWS Lambda Powertools for logging/tracing. DynamoDB single-table design, partition key by `userId`.
- *Frontend (React + Vite)*: TypeScript, React 18, TailwindCSS, React Query for server state management, React Router, AWS Amplify (Cognito SDK) for authentication.
- *AI Coaching*: Amazon Bedrock Converse API with the Amazon Nova Lite model. Lambda passes the full application data context into the prompt so AI can provide personalized advice.
- *Automated Email*: Amazon SES sends HTML emails. Amazon EventBridge Scheduler triggers the `followup` Lambda daily (07:00 UTC) and the `digest` Lambda weekly (Sunday 08:00 UTC).



### 5. Timeline & Milestones
*Internship Period (April – July 2026): 12 Weeks*

| Phase | Activities |
|---|---|
| (Weeks 1–2) | Get familiar with AWS and core services (IAM, S3, Lambda, API Gateway, DynamoDB, Cognito, CloudWatch, Bedrock). Research Serverless architecture, set up the development environment, upgrade hardware, and install project tools. |
| (Weeks 3–6) | Analyze system requirements, design AWS architecture, create architecture diagrams, design DynamoDB schema (Single-Table Design), select technologies, build Infrastructure as Code with AWS CDK, and adjust architecture based on mentor feedback. |
| (Weeks 7–10) | Deploy AWS Serverless infrastructure, develop Backend with Lambda, API Gateway, Cognito, and DynamoDB; integrate Amazon Bedrock for AI-powered CV analysis; develop the React interface, connect Frontend to Backend, test features, and optimize system performance. |
| (Weeks 11–12) | Finalize the entire project, deploy the application to AWS, perform end-to-end testing, fix bugs, optimize user experience, complete technical documentation, prepare the internship report, and demo the system in the production environment. |
| Post-Deployment | Continue research and development for 1 year: add advanced AI features, optimize AWS costs, improve performance, strengthen security, and scale the system to serve more users. |

### 6. Budget Estimation
![AWS Infrastructure Costs](/images/2-Proposal/budget_estimation.png)

*Development Cost:* None — all 4 team members use AWS Free Tier and local dev environments.

### 7. Risk Assessment
| Risk | Severity | Probability | Mitigation |
|---|---|---|---|
| Bedrock unavailable in region | High | Medium | Use Nova Lite (no geo-restrictions); have rule-based coaching as fallback |
| Bedrock budget overrun | Medium | Low | Set AWS Budget Alert; limit `maxTokens` per call |
| SES emails going to spam | Medium | Medium | Request SES production access; configure SPF/DKIM |
| API security vulnerability | High | Low | All endpoints require Cognito JWT; full input validation |
| DynamoDB hot partition | Low | Low | Partition key by `userId`; use on-demand capacity mode |


### 8. Expected Outcomes
*Technical Improvements*: Users have complete data and analytics to make strategic decisions in their job search journey, fully replacing manual Excel-based tracking.
*Long-term Value*: Accumulated data over time makes AI coaching increasingly accurate. The serverless architecture can be easily scaled to serve more users in the future.