---
title: "Amazon EventBridge"
date: 2024-01-01
weight: 8
chapter: false
pre: " <b> 5.8. </b> "
---

EventBridge is used to automatically run Lambda functions on a schedule, such as sending a Weekly Digest or checking profiles that need a Follow-up reminder.

#### Create a Schedule to send daily Follow-up emails

1. Access the **Amazon EventBridge** service on the AWS Console.
2. In the left menu, select **Scheduler** → **Schedules**.
3. Click **Create schedule**.
4. **Schedule name:** enter `smartcv-daily-followup`.
5. Select **Recurring schedule**.
6. **Time zone:** select **Asia/Saigon (UTC+07:00)**.
7. **Schedule type:** select **Cron-based schedule**.
8. Enter the Cron Expression: `0 9 * * ? *`

{{% notice note %}}
Since the Time zone is set to **Asia/Saigon**, the hour values in the cron expression are interpreted based on **Vietnam local time**, not UTC. `0 9 * * ? *` = **09:00 AM every day Vietnam time** (not 2:00 AM — this is a common mistake when confusing UTC and local time after selecting a Time zone).
{{% /notice %}}

![Create Follow-up Schedule](/images/5-Workshop/5.8-EventBridge/5.42.png)

9. Click **Next**.
10. In the **Target API** section, select **AWS Lambda** → **Invoke**.
11. **Lambda function:** select `smartcv-followup`, then click **Next**.
12. Click **Create schedule** to complete the setup.

![Complete Schedule](/images/5-Workshop/5.8-EventBridge/5.43.png)

#### Create a Schedule to send weekly summary emails

1. Click **Create schedule** once again.
2. **Schedule name:** enter `smartcv-weekly-digest`.
3. Select **Recurring schedule**.
4. **Time zone:** select **Asia/Saigon (UTC+07:00)**.
5. Select **Cron-based schedule**.
6. Enter the Cron Expression: `cron(0 8 ? * MON *)` — which corresponds to **08:00 AM every Monday** Vietnam time.
7. Click **Next** → select **AWS Lambda** → **Invoke**. For **Lambda function**, select `smartcv-digest`.
8. Click **Next**.
9. Click **Create schedule**.

![Create Weekly Digest Schedule](/images/5-Workshop/5.8-EventBridge/5.44.png)

Both the **Weekly Digest** and **Daily Followup** schedules have been successfully created.

![Schedules List](/images/5-Workshop/5.8-EventBridge/5.46.png)
![Schedules List](/images/5-Workshop/5.8-EventBridge/image51.png)