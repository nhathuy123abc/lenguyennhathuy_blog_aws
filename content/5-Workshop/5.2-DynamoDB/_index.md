---
title: "Amazon DynamoDB"
date: 2024-01-01
weight: 2
chapter: false
pre: " <b> 5.2. </b> "
---

DynamoDB uses the **Single-Table Design** model to store all SmartCV data (Applications, Notes, Settings, Status Events) in a single table, optimizing costs and query performance.

1. In the AWS Management Console, type **DynamoDB** in the search bar and press Enter.
2. Click on **Tables** in the left sidebar, select **Create table**.
3. Create a table named `smartcv`.

![Create DynamoDB table](/images/5-Workshop/5.2-DynamoDB/5.3.jpg)
**Figure 5.2.1** — Create the `smartcv` table in DynamoDB.

4. Set up the Primary key:
   - **Partition key:** `PK` (String)
   - **Sort key:** `SK` (String)
5. Create a Global Secondary Index (GSI) to optimize secondary queries:
   - Go to **Indexes** → **Create index**
   - **Partition key:** `GSI1PK` (String)
   - **Sort key:** `GSI1SK` (String)
   - **Index name:** `GSI1`

![Create GSI1](/images/5-Workshop/5.2-DynamoDB/5.4.jpg)
**Figure 5.2.2** — Create Global Secondary Index GSI1 (GSI1PK/GSI1SK).

6. Scroll down to the **Time To Live (TTL)** section, enable TTL and set the TTL attribute name to `expiresAt` to automatically delete expired data (e.g., temporary sessions, AI analysis cache).

![Enable TTL](/images/5-Workshop/5.2-DynamoDB/5.5.jpg)
**Figure 5.2.3** — Enable Time To Live (TTL) with the `expiresAt` attribute.

7. Click **Create table** to complete.

The `smartcv` DynamoDB table with the `PK`/`SK` key and `GSI1` index (`GSI1PK`/`GSI1SK`) is now ready to serve the backend.