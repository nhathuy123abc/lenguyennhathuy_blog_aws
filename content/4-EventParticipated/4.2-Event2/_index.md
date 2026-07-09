---
title: "Event 2"
date: 2026-05-23
weight: 1
chapter: false
pre: " <b> 4.2. </b> "
---



# Summary Report: "GenAI-powered App-DB Modernization Workshop"

## Event Objectives

- Share best practices for modern application design.
- Introduce Domain-Driven Design (DDD) and Event-Driven Architecture.
- Provide guidance on selecting appropriate AWS compute services.
- Demonstrate AI-powered tools that support the software development lifecycle.

## Speakers

- **Jignesh Shah** – Director, Open Source Databases
- **Erica Liu** – Senior GTM Specialist, AppMod
- **Fabrianne Effendi** – Associate Specialist Solutions Architect, Serverless, Amazon Web Services

## Key Highlights

### 1. Challenges of Legacy Application Architecture

Legacy applications often face several limitations:

- Long release cycles that delay product delivery and reduce business opportunities.
- High operational costs due to inefficient infrastructure and maintenance.
- Security and compliance risks caused by outdated technologies.

### 2. Modern Application Architecture with Microservices

The workshop introduced microservices as an effective modernization strategy, where applications are divided into independent services communicating through events.

Key components include:

- Queue management for asynchronous processing.
- Caching strategies to improve application performance.
- Event-based messaging for flexible service-to-service communication.

### 3. Domain-Driven Design (DDD)

The speakers explained how DDD helps developers design systems around business requirements instead of technical components.

Main concepts covered:

- Four-step Event Storming process:
  - Identify domain events.
  - Arrange events in chronological order.
  - Identify actors.
  - Define bounded contexts.
- Bookstore case study demonstrating DDD implementation.
- Context Mapping patterns for integrating multiple bounded contexts.

### 4. Event-Driven Architecture

Different communication patterns between services were introduced:

- Publish/Subscribe
- Point-to-Point Messaging
- Event Streaming

Benefits include:

- Loose coupling
- Better scalability
- Higher system resilience

The workshop also compared synchronous and asynchronous communication and discussed when each approach should be used.

### 5. Evolution of Compute Services

The speakers explained the AWS compute evolution:

EC2 → ECS → AWS Fargate → AWS Lambda

Topics discussed included:

- AWS Shared Responsibility Model.
- Advantages of serverless computing:
  - No server management.
  - Automatic scaling.
  - Pay only for actual usage.
- Guidelines for choosing between containers and serverless functions.

### 6. Amazon Q Developer

Amazon Q Developer was introduced as an AI assistant supporting the Software Development Life Cycle (SDLC).

Capabilities include:

- Planning and software maintenance assistance.
- Java and .NET code modernization.
- AWS Transform Agents for VMware, Mainframe, and .NET migration.

---

## Key Takeaways

### Design Perspective

- Always begin system design from business requirements rather than technology.
- Maintain a ubiquitous language between business stakeholders and developers.
- Use bounded contexts to effectively manage large and complex systems.

### Technical Architecture

- Apply Event Storming to understand business processes.
- Prefer event-driven communication whenever appropriate.
- Select suitable integration patterns based on business requirements.
- Choose the appropriate compute platform depending on workload characteristics.

### Modernization Strategy

- Modernization should follow a phased roadmap instead of a complete rebuild.
- Apply the 7Rs modernization framework according to application requirements.
- Measure modernization success through business agility and cost reduction.

---

## Applying the Knowledge

After attending this workshop, I plan to apply the knowledge by:

- Organizing Event Storming sessions during project analysis.
- Applying Domain-Driven Design to define service boundaries.
- Using Event-Driven Architecture instead of tightly coupled synchronous communication where appropriate.
- Exploring AWS Lambda for suitable serverless workloads.
- Integrating Amazon Q Developer into the software development workflow to improve productivity.

---

# Event Experience

Participating in the **"GenAI-powered App-DB Modernization Workshop"** provided valuable insights into modern software architecture and application modernization on AWS. The workshop combined architectural concepts with practical examples, making the topics easier to understand and apply.

## Learning from Industry Experts

The speakers shared practical experiences in designing scalable cloud-native applications and modernizing legacy systems.

Real-world examples demonstrated how Domain-Driven Design and Event-Driven Architecture can solve complex business problems while improving maintainability and scalability.

## Technical Knowledge Gained

During the workshop, I learned:

- How Event Storming helps model business processes.
- How to identify bounded contexts when designing microservices.
- The advantages and trade-offs of synchronous versus asynchronous communication.
- When to use Publish/Subscribe, Point-to-Point, and Streaming patterns.
- The evolution of AWS compute services from EC2 to AWS Lambda.

## Exploring Modern AWS Tools

The introduction to Amazon Q Developer showed how generative AI can assist developers throughout the software development lifecycle by:

- Automating repetitive development tasks.
- Assisting with code transformation.
- Accelerating application modernization projects.

## Networking Opportunities

The event provided opportunities to exchange ideas with AWS experts and fellow participants, allowing me to better understand current industry practices and cloud-native application development.

## Lessons Learned

The workshop reinforced several important principles:

- Business requirements should always drive software architecture decisions.
- Event-Driven Architecture improves scalability, flexibility, and resilience.
- Application modernization should be performed gradually using a structured roadmap.
- AI-assisted development tools such as Amazon Q Developer can significantly improve developer productivity.

## Event Photos

![Event Photos](/images/4-eventparticipated/Event2.jpg)

