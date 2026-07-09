---
title: "Week 3 Worklog"
date: 2026-07-07
weight: 3
chapter: false
pre: " <b> 1.3. </b> "
---


### Week 3 Objectives:

* Understand the architecture of Hybrid DNS on AWS.
* Learn how Amazon Route 53 Resolver integrates DNS between on-premises and AWS environments.
* Practice deploying AWS infrastructure using AWS CloudFormation.
* Complete Lab 10 and verify two-way DNS resolution.

### Tasks to be carried out this week:

| Day | Task | Start Date | Completion Date | Reference Material |
| --- | ---- | ---------- | --------------- | ------------------ |
| 1 | Study Hybrid DNS architecture and Amazon Route 53 Resolver, including Inbound Endpoint, Outbound Endpoint, and Resolver Rules. | 04/05/2026 | 04/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 2 | Deploy the networking infrastructure using AWS CloudFormation and create the required AWS resources for Lab 10. | 05/05/2026 | 05/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 3 | Create a Key Pair, configure Security Groups, and connect to the EC2 Windows instance through Remote Desktop Protocol (RDP). | 06/05/2026 | 06/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 4 | Configure Route 53 Resolver Outbound Endpoint, Inbound Endpoint, and Resolver Rules for Hybrid DNS integration. | 07/05/2026 | 08/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 5 | Verify DNS resolution using **nslookup** and **ping**, then clean up all AWS resources after completing Lab 10. | 09/05/2026 | 10/05/2026 | https://cloudjourney.awsstudygroup.com/ |

### Week 3 Achievements:

* Understood the Hybrid DNS architecture and the role of **Amazon Route 53 Resolver** in integrating DNS services between on-premises environments and AWS.

* Successfully created an EC2 Key Pair and established a Remote Desktop connection to a Windows EC2 instance.

* Deployed the required AWS infrastructure using **AWS CloudFormation**, including:

  * Amazon VPC
  * Subnets
  * Internet Gateway
  * NAT Gateway
  * Elastic Load Balancer
  * Auto Scaling

* Configured Security Groups with the required rules, including:

  * ICMP
  * RDP (Port 3389)

* Successfully configured:

  * Route 53 Resolver Outbound Endpoint
  * Route 53 Resolver Inbound Endpoint
  * Resolver Rules

* Verified Hybrid DNS functionality using **nslookup** and **ping**, confirming successful two-way DNS resolution.

* Cleaned up all AWS resources after completing the lab, including:

  * Route 53 Resolver
  * AWS Directory Service
  * CloudFormation Stack

### Plan for Next Week:

* Continue with **Lab 19** following the AWS Study Group learning roadmap.

* Explore the services and architectures introduced in Lab 19.

* Complete the hands-on exercises and validate the deployment results.