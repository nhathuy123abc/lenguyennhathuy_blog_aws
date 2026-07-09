---
title: "Week 6 Worklog"
date: 2026-07-07
weight: 6
chapter: false
pre: " <b> 1.6. </b> "
---


### Week 6 Objectives:

* Learn AWS Backup and implement automated backup strategies.
* Understand Hybrid Cloud storage using AWS Storage Gateway.
* Deploy static website hosting with Amazon S3 and Amazon CloudFront.
* Improve data protection through Versioning and Cross-Region Replication.

### Tasks to be carried out this week:

| Day | Task | Start Date | Completion Date | Reference Material |
| --- | ---- | ---------- | --------------- | ------------------ |
| 1 | Configure AWS Backup by creating Backup Plans, assigning protected resources, and testing automated backup schedules. | 25/05/2026 | 25/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 2 | Test Backup and Restore operations and integrate Amazon SNS to send email notifications for backup job status. | 26/05/2026 | 26/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 3 | Deploy AWS Storage Gateway (File Gateway), create an Amazon S3 bucket, launch an EC2 Gateway instance, and configure SMB File Share. | 27/05/2026 | 28/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 4 | Create an Amazon S3 bucket, upload website files, enable Static Website Hosting, and configure Amazon CloudFront for secure content delivery. | 29/05/2026 | 29/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 5 | Enable S3 Versioning, configure Cross-Region Replication (CRR), validate data protection, and clean up AWS resources after testing. | 30/05/2026 | 31/05/2026 | https://cloudjourney.awsstudygroup.com/ |

### Week 6 Achievements:

* Successfully deployed an automated backup solution using **AWS Backup**, including:

  * Backup Plan configuration.
  * Scheduled backup jobs.
  * Backup and Restore testing.

* Integrated **Amazon SNS** with AWS Backup to automatically send email notifications indicating successful or failed backup operations.

* Implemented a **Hybrid Cloud Storage** solution using **AWS Storage Gateway (File Gateway)** by:

  * Creating an Amazon S3 bucket.
  * Deploying an EC2 instance as the gateway.
  * Configuring SMB File Share.
  * Granting Guest access for file sharing.

* Successfully deployed a **Static Website** using **Amazon S3**, including:

  * Uploading HTML and image files.
  * Configuring Static Website Hosting.
  * Testing website accessibility.

* Improved website performance and security by integrating **Amazon CloudFront**, preventing direct public access to the S3 bucket.

* Enhanced data protection by enabling:

  * Amazon S3 Versioning.
  * Cross-Region Replication (CRR) for disaster recovery.

### Plan for Next Week:

* Continue improving website security by restricting direct Internet access to Amazon S3 and allowing access only through Amazon CloudFront.

* Validate CloudFront content delivery performance across different regions.

* Further optimize data protection by reviewing Versioning and Cross-Region Replication configurations.