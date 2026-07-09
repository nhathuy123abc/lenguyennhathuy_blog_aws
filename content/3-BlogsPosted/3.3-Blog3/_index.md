---
title: "Blog 3"
date: 2026-06-25
weight: 3
chapter: false
pre: " <b> 3.3. </b> "
---

# Building a Priority-Based Messaging System with Amazon MQ and AWS App Runner

Hello everyone in the FCAJ group.
While researching asynchronous message processing architectures on AWS, I came across a highly detailed and practical architecture document. I would like to summarize and analyze the key technical aspects of this design for everyone's reference and discussion.

### 1. The Challenge of Message Processing in Large-scale Systems
Organizations constantly need message processing systems capable of prioritizing critical business operations while handling routine tasks efficiently. Especially when dealing with low-latency tasks—such as urgent orders from high-value customers or critical system alerts—prioritizing urgent messages is mandatory. The challenge lies in routing messages based on priority to honor business rules while providing real-time feedback to users.

### 2. Architectural Solution Overview
To solve this without adding operational complexity, AWS proposes a solution using fully managed services. This architecture allows engineering teams to focus on business logic rather than infrastructure management, and is composed of three core services:
* **Amazon MQ:** Serves as the message broker for Apache ActiveMQ. It provides message prioritization queuing, supports the JMS protocol for enterprise applications, and ensures high availability via automatic failover.
* **AWS App Runner:** A fully managed container application service for serverless compute. It offers automatic scaling based on traffic and automatic building/deployment of containerized applications.
* **Amazon DynamoDB:** A NoSQL database delivering single-digit millisecond performance to store state data.

![Architecture Diagram](/images/3-BlogsPosted/blog3-diagram1.png)

### 3. Routing Mechanism and Latency Pipelines
The system implements intelligent routing based on three levels of JMS message priority to guarantee critical messages are processed immediately:
* **High-Priority Path:** Messages in this category bypass any configured latency and are queued immediately with a JMS priority of 9.
* **Standard-Priority Path:** Messages undergo a pre-configured delay before entering the queue with a JMS priority of 4.
* **Low-Priority Path:** These messages are only processed after all higher-priority messages, corresponding to a JMS priority of 0.

This architecture implements configurable delay processing at the application level. Asynchronous delay processing manages a thread pool for concurrent execution and handles errors gracefully using a two-tier retry mechanism for maximum reliability.

![Standard Priority Message Processing Flow](/images/3-BlogsPosted/blog3-diagram2.png)

*The standard priority message processing path handles messages with configurable delays utilizing JMS asynchronous processing. The message waits for the specified delay before entering the Amazon MQ queue where it is processed.*

### 4. Real-time Responsiveness
The solution provides real-time status updates so users can track the progress of their requests. The system uses **Amazon DynamoDB Streams** for change data capture (CDC). This stream triggers an **AWS Lambda** function to push updates to a **React** front-end application via **Amazon API Gateway WebSocket** connections.

### 5. Security Standards and Troubleshooting
The AWS documentation highlights several security practices for production environments:
* **Network Isolation:** Provisioning a Virtual Private Cloud (VPC) with private subnets for Amazon MQ, isolating the message broker from direct internet access. Security groups are configured with least-privilege access rules, such as only allowing port 61617 for ActiveMQ SSL connections from AWS App Runner.
* **Access Control and Encryption:** AWS recommends enforcing least-privilege IAM policies to ensure App Runner only accesses specific DynamoDB tables and Amazon MQ queues. Additionally, data encryption must be enabled at rest using AWS KMS and in transit using SSL/TLS connections.

During operation, if messages are not processed in the correct priority order, system engineers should verify that the JMS priority is configured correctly using the `message.setJMSPriority()` parameter (or equivalent `message.set`). Additionally, ensure that `CLIENT_ACKNOWLEDGE` mode is configured correctly, and inspect the concurrent consumer settings on the queues.

Applying this architecture using Infrastructure as Code (IaC) ensures consistent deployments across multiple environments, from development to production.

### Summary
This solution demonstrates how to build a production-ready priority-based messaging system using AWS managed services. By combining Amazon MQ priority queues with DynamoDB real-time streams and App Runner serverless compute, this design delivers a robust architecture that processes messages intelligently based on business priorities. Implementing application-level delays with priority bypass ensures urgent messages get immediate attention, while the two-tier retry mechanism provides high reliability. Real-time WebSocket updates keep users informed, creating a responsive and transparent system.

**References:**
* AWS Architecture Blog: [Build a priority-based messaging system with Amazon MQ and AWS App Runner](https://aws.amazon.com/blogs/architecture/build-priority-based-messaging-system-amazonmq-apprunner/)
* GitHub Sample: [Amazon MQ Polling Mechanism Sample](https://github.com/aws-samples/sample-amazonmq-polling-mechanism)
* Facebook: [AWS Study Group FCJ](https://www.facebook.com/groups/awsstudygroupfcj/permalink/2194921531272807?locale=vi_VN)

*(This is a summary of an AWS blog post I read. Feel free to share your thoughts or point out any mistakes!)*