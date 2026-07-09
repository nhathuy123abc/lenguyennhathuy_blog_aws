---
title: "Clean up resources"
date: 2024-01-01
weight: 13
chapter: false
pre: " <b> 5.13. </b> "
---

After completing the Workshop, please delete all created AWS resources to avoid unexpected charges.

#### 5.13.1. Empty and delete S3 Bucket

1. Access **Amazon S3**.
2. Select the bucket `smartcv-resumes-YOUR_NAME`.
3. Click **Empty** and confirm the deletion of all objects.
4. Return to the Bucket list, select the bucket and click **Delete**.
5. Enter the bucket name to confirm.

![S3](/images/5-Workshop/5.13-Cleanup/S3.jpg)

#### 5.13.2. Delete AWS Amplify App

1. Access **AWS Amplify**.
2. Select the `smartcv-frontend` application.
3. Select **Actions** → **Delete app**.
4. Enter `delete` to confirm, click **Delete**.

![Amplify](/images/5-Workshop/5.13-Cleanup/Amplify.jpg)

#### 5.13.3. Delete Amazon Cognito User Pool

1. Access **Amazon Cognito**.
2. Select the `smartcv-users` User Pool.
3. Select **Delete**, enter the User Pool name to confirm.

![Cognito](/images/5-Workshop/5.13-Cleanup/Cognito.jpg)

#### 5.13.4. Delete DynamoDB Table

1. Access **Amazon DynamoDB** → **Tables**.
2. Select the `smartcv` table, click **Delete**.
3. Enter `delete` to confirm.

![DynamoDB](/images/5-Workshop/5.13-Cleanup/DatabaseClear.jpg)

#### 5.13.5. Delete Lambda Functions

1. Access **AWS Lambda**.
2. Select each function: `smartcv-applications`, `smartcv-insights`, `smartcv-settings`, `smartcv-notes`, `smartcv-digest`, `smartcv-followup`, `smartcv-cognito-verify`.
3. Select **Actions** → **Delete** for each function.
![Lambda](/images/5-Workshop/5.13-Cleanup/LambdaClear.jpg)

#### 5.13.6. Delete API Gateway

1. Access **API Gateway**.
2. Select the `SmartCV API` API.
3. Select **Delete**, confirm the deletion.

![API Gateway](/images/5-Workshop/5.13-Cleanup/APIClear.jpg)

#### 5.13.7. Delete IAM Role

1. Access **IAM** → **Roles**.
2. Find `SmartCV-Lambda-Role`.
3. Click **Delete**.

![IAM Role](/images/5-Workshop/5.13-Cleanup/IAMClean.jpg)

#### 5.13.8. Delete Amazon SES Identity (optional)

If you no longer use the verified email for other purposes:
1. Access **Amazon SES** → **Identities**.
2. Select the verified email, click **Delete**.
![SES](/images/5-Workshop/5.13-Cleanup/SESClear.jpg)
{{% notice note %}}
The Enable Model Access step for **Amazon Bedrock** (section 5.10) **does not** incur charges when not in use, so there is no need to "delete" it — you can leave it as is or disable model access in **Model access** if you prefer.
{{% /notice %}}

Congratulations on completing the SmartCV deployment on AWS Serverless Architecture Workshop!