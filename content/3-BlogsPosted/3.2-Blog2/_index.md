---
title: "Blog 2"
date: 2026-06-25
weight: 2
chapter: false
pre: " <b> 3.2. </b> "
---

# Building a Hybrid Multi-Tenant Architecture for Stateful Services on AWS

Hi everyone, I recently read an insightful article on the AWS Blog about building a **Hybrid Multi-Tenant Architecture** for stateful services on AWS. This is a very practical challenge for SaaS platforms or systems serving multiple customers simultaneously while ensuring performance, resource isolation, and operational cost optimization.

### 1. The Challenge
The system discussed in the blog is a large-scale ad-serving platform processing millions of requests per second. Previously, the architecture utilized a **cellular architecture** model where each tenant or major customer had their own AWS account, VPC, Application Load Balancer, and ECS clusters. While this approach provided excellent isolation, it introduced significant bottlenecks as the system scaled:
* **Difficult to Scale:** Onboarding each new tenant required provisioning a complete set of duplicate infrastructure resources.
* **High Operational Cost:** Average CPU utilization hovered around 3% and memory around 19%, leaving the vast majority of resources idle.
* **Slow Onboarding:** Onboarding a new customer took approximately 52 days.
* **Noisy Neighbor Effect:** In stateful services, data is kept in memory. Sharing compute resources without proper boundaries meant that a tenant with massive datasets could easily impact the performance of others.

The core challenge lies in the fact that this is not a typical stateless system. The application must load and maintain in-memory states for each tenant to serve requests quickly rather than constantly querying the database. Improper compute sharing would directly lead to memory resource contention between tenants.

![Infrastructure Optimization Dimensions](/images/3-BlogsPosted/blog2-diagram2.png)

### 2. AWS's Proposed Solution
AWS proposed a **hybrid multi-tenant architecture** that balances shared infrastructure with cluster-level resource isolation.
Instead of dedicating a separate AWS account to each tenant, the system is organized into three layers:
1. **Tier:** Groups tenants with similar workload characteristics (e.g., High TPS, Standard TPS, or Low TPS).
2. **Cell:** An AWS account that acts as a unit of horizontal scaling.
3. **Infra Group:** A shared infrastructure stack consisting of a VPC, Application Load Balancer, ECS clusters, IAM roles, and a monitoring stack.

Within each *Infra Group*, each tenant still runs on its own dedicated ECS cluster to guarantee compute and memory isolation. However, common components like VPC endpoints, IAM roles, and downstream service connections are pre-configured and shared at the *Tier* level, significantly reducing deployment overhead.

![Hybrid Multi-Tenant Architecture](/images/3-BlogsPosted/blog2-diagram1.png)

### 3. Key AWS Services Used
* Amazon Route 53
* Application Load Balancer
* Amazon ECS
* Amazon VPC
* IAM Roles
* Amazon CloudWatch

### 4. Key Highlights
The standout feature of this architecture is how AWS balances **isolation** and **operational efficiency**.
Too much isolation (e.g., one account per tenant) ensures security but incurs high management overhead, high costs, and slow onboarding. Too much sharing, on the other hand, reduces costs but risks noisy-neighbor issues—especially critical for stateful services.

The hybrid model solves this by:
* Sharing core infrastructure at the Tier and Infra Group levels.
* Isolating tenants at the ECS cluster level.
* Using ALB listener rules to route requests to the correct tenant.
* Leveraging Route 53 weighted routing to scale or migrate traffic transparently.
* Using AWS PrivateLink to securely share downstream connections without public exposure.

AWS reported that this approach cut tenant onboarding time from **52 days down to just 7 days** (an **86% reduction**), while reducing setup efforts by **80%**.

### 5. Request Flow and Architecture
When a client sends a request, it is dynamically routed to the appropriate tenant's environment:
1. The **Client** sends a request to the system.
2. **Amazon Route 53** receives and resolves the DNS request.
3. **Route 53** uses weighted routing to forward traffic to the appropriate Application Load Balancer (ALB).
4. The **Application Load Balancer** inspects the request for a tenant identifier.
5. The **Tenant Identifier** can be in the path (e.g., `/tenant-a/*`) or in an HTTP header.
6. The **ALB** routes the request to a tenant-specific listener rule.
7. The **Listener Rule** forwards the request to the tenant's dedicated target group.
8. The request is processed inside the **Tenant's Dedicated ECS Cluster**.
9. The application in ECS uses environment variables like `TENANT_ID` to load tenant-specific configurations.
10. The application loads only the state and data relevant to that tenant.
11. Tenant data is retrieved from a remote cache or downstream service.
12. Private connectivity to downstream services is handled via **AWS PrivateLink**.
13. Downstream services process the request and return results to the application.
14. The application returns the response to the client.

Additionally, the operations team can monitor tenant-specific errors using **Amazon CloudWatch Logs Insights** (e.g., querying errors by `tenant_id` to quickly isolate issues without affecting other clients).

### 6. Core Benefits
* **Faster Onboarding:** Adding a new tenant is largely a configuration change.
* **Strong Isolation:** Dedicated ECS clusters eliminate noisy-neighbor risks in CPU and memory.
* **Resource Optimization:** Eliminates the need for a separate AWS account per tenant.
* **Flexible Scaling:** New Infra Groups or Cells can be added as the system grows.
* **Zero Client Impact:** Route 53 manages backend traffic redistribution transparently.
* **Secure Connections:** PrivateLink ensures secure private connectivity.

### 7. Conclusion
This case study offers a great blueprint for anyone building multi-tenant SaaS platforms or handling large enterprise workloads on AWS.
Instead of choosing between two extremes—complete silo or complete pool—the hybrid model shares what can be shared and isolates components where performance and security are critical (compute and memory).

For stateful services that rely heavily on in-memory caching to maintain low latency, this hybrid design is highly practical, cost-effective, and scalable.

**References:**
* AWS Architecture Blog: [Building Hybrid Multi-Tenant Architecture for Stateful Services on AWS](https://aws.amazon.com/blogs/architecture/building-hybrid-multi-tenant-architecture-for-stateful-services-on-aws/)
* Facebook: [AWS Study Group FCJ](https://www.facebook.com/groups/awsstudygroupfcj/permalink/2194925764605717?locale=vi_VN)