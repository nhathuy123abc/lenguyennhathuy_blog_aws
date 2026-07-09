---
title: "AWS Lambda"
date: 2024-01-01
weight: 5
chapter: false
pre: " <b> 5.5. </b> "
---


Before starting this section, ensure you have completed the **Enable Model Access** step for Amazon Bedrock in section [5.10](../5.10-bedrock/). If not, the Lambda functions that call Bedrock (`insights`, `digest`) will encounter an `AccessDeniedException` error when tested.


#### Create IAM Execution Role for Lambda

1. Access the **IAM** service on the AWS Console.
2. In the left menu, select **Roles**, and click **Create role**.
3. **Trusted entity type:** select *AWS service*. **Use case:** select *Lambda*. Click **Next**.
4. Search for and check the following Policies:
   - `AWSLambdaBasicExecutionRole` (write logs to CloudWatch)
   - `AmazonDynamoDBFullAccess` (read/write to the SmartCV table)
   - `AmazonS3FullAccess` (create Presigned URLs)
   - `AmazonBedrockFullAccess` (call AI model)
   - `AmazonSESFullAccess` (send emails)
5. Name the Role `SmartCV-Lambda-Role` and click **Create role**.

![Create IAM Role](/images/5-Workshop/5.5-Lambda/5.10.jpg)
![Create IAM Role](/images/5-Workshop/5.5-Lambda/5.30.png)
![Create IAM Role](/images/5-Workshop/5.5-Lambda/5.31.png)
![Create IAM Role](/images/5-Workshop/5.5-Lambda/5.32.png)
![Create IAM Role](/images/5-Workshop/5.5-Lambda/5.34.png)
![Create IAM Role](/images/5-Workshop/5.5-Lambda/5.35.png)
**Figure 5.5.1** — Create the `SmartCV-Lambda-Role` IAM Role with the 5 necessary policies.
#### Create a Lambda Layer for Shared Libraries

Open the terminal at the root directory of the SmartCV project and run the following command:

```bash
bash scripts/build_layer.sh
```

This command generates a file named `shared_layer.zip`.

1. Access the **Lambda** service, select **Layers** from the left menu, and click **Create layer**.
2. **Name:** `smartcv-dependencies`.
3. **Upload a .zip file:** upload the recently created `shared_layer.zip`.
4. **Compatible runtimes:** *Python 3.12*.
5. **Compatible architectures:** *arm64* and *x86_64*.
6. Click **Create** and note down the **Version ARN** of the layer.

![Create Lambda Layer](/images/5-Workshop/5.5-Lambda/5.11.png)
![Create Lambda Layer](/images/5-Workshop/5.5-Lambda/5.12.png)
**Figure 5.5.2** — Create the `smartcv-dependencies` Layer from the `shared_layer.zip` file.

#### List of 7 Lambda Functions to Create

The SmartCV system consists of **7 Lambda functions**, each handling a specific business logic:

1. `smartcv-applications`: add/edit/delete applications, get CV upload links.
2. `smartcv-insights`: perform statistical analysis and AI Chat with Bedrock.
3. `smartcv-settings`: set goals and track Streaks.
4. `smartcv-notes`: add Timeline notes.
5. `smartcv-digest`: send weekly statistical report emails.
6. `smartcv-followup`: send application follow-up reminder emails.
7. `smartcv-cognito-verify`: automatically verify email when a new user registers.

#### Create Each Function

For **each function** in the list above, repeat the following steps:

1. In the Lambda sidebar, select **Functions** → **Create function**.
2. Choose *Author from scratch*.
3. **Function name:** enter the function name (e.g., `smartcv-applications`).
4. **Runtime:** *Python 3.12*.
5. **Architecture:** *arm64* (recommended) or *x86_64*.
6. **Execution role:** select *Use an existing role* → `SmartCV-Lambda-Role`.
7. Click **Create function**.

Immediately after creating each function, configure the following settings **directly on that function's interface**:

**a. Attach the Layer to the Function**

Scroll down to the **Layers** section → **Add a layer** → *Specify an ARN* → paste the ARN of the `smartcv-dependencies` layer → **Add**.

![Create Lambda Layer](/images/5-Workshop/5.5-Lambda/5.13.png)
![Create Lambda Layer](/images/5-Workshop/5.5-Lambda/5.14.png)
![Create Lambda Layer](/images/5-Workshop/5.5-Lambda/5.15.png)
![Create Lambda Layer](/images/5-Workshop/5.5-Lambda/5.16.png)
![Create Lambda Layer](/images/5-Workshop/5.5-Lambda/5.17.png)
![Create Lambda Layer](/images/5-Workshop/5.5-Lambda/5.18.png)
![Create Lambda Layer](/images/5-Workshop/5.5-Lambda/5.19.png)
**Figure 5.5.3** — Attach the `smartcv-dependencies` Layer to each Lambda function.

**b. Configure Timeout and Memory**

{{% notice warning %}}
Lambda defaults to a Timeout of only 3 seconds — which is not enough time to call Amazon Bedrock (usually takes a few seconds). If you do not increase the Timeout, you will encounter a `Task timed out after 3.00 seconds` error.
{{% /notice %}}

Go to the **Configuration** tab → **General configuration** → **Edit**:
- **Memory:** 256 MB (recommended, can be increased if needed).
- **Timeout:** 30 seconds (mandatory for `insights` and `digest` as they call Bedrock; other functions can be set to 10–15 seconds).

**c. Set up Environment Variables**

Go to **Configuration** → **Environment variables** → **Edit** → **Add environment variable**. Add the following variables for **all Lambda functions**:

| Key | Value |
| --- | --- |
| `TABLE_NAME` | `smartcv` |
| `CORS_ORIGIN` | `*` |
| `RESUME_BUCKET` | `smartcv-resumes-YOUR_NAME` (bucket created in section 5.3) |
| `USER_POOL_ID` | `ap-southeast-1_xxxxxxxxx` (User Pool ID created in section 5.4) |
| `POWERTOOLS_SERVICE_NAME` | `SmartCV` |

Specifically for **`smartcv-insights`** and **`smartcv-digest`** (2 functions that call AI), add the additional variable:

| Key | Value |
| --- | --- |
| `BEDROCK_MODEL_ID` | `amazon.nova-lite-v1:0` |

Specifically for **`smartcv-digest`** and **`smartcv-followup`** (2 functions that send emails), add the additional variable:

| Key | Value |
| --- | --- |
| `SES_FROM_EMAIL` | `your_email@domain.com` (email verified in section 5.6) |

Click **Save**.

![Set up environment variables](/images/5-Workshop/5.5-Lambda/5.20.png)
![Set up environment variables](/images/5-Workshop/5.5-Lambda/5.21.png)
![Set up environment variables](/images/5-Workshop/5.5-Lambda/5.22.png)
**Figure 5.5.4** — Set up environment variables (TABLE_NAME, RESUME_BUCKET, USER_POOL_ID, BEDROCK_MODEL_ID, SES_FROM_EMAIL...).

#### Upload Source Code for Each Lambda

The source code for the Lambda functions is pre-written in the project's `lambdas/` directory. For **each function**, perform the following:

1. Open the SmartCV source code on your local machine, and navigate to the `lambdas/<function-name>/` directory (e.g., `lambdas/applications/`).
2. Compress all the files **inside** that directory into a zip file (e.g., `applications.zip`) — note: select the files inside to compress, do not compress the parent directory itself.
3. Return to the AWS Console, navigate to the management page of the corresponding Lambda function, and select the **Code** tab.
4. Click **Upload from** → **.zip file**, select the newly created zip file, and click **Save**.

Repeat this process for all 7 functions: `applications`, `settings`, `insights`, `notes`, `digest`, `followup`, `cognito-verify`.

![Upload code for each function](/images/5-Workshop/5.5-Lambda/5.23.png)
![Upload code for each function](/images/5-Workshop/5.5-Lambda/5.24.png)
![Upload code for each function](/images/5-Workshop/5.5-Lambda/5.25.png)
![Upload code for each function](/images/5-Workshop/5.5-Lambda/5.26.png)
![Upload code for each function](/images/5-Workshop/5.5-Lambda/5.27.png)
![Upload code for each function](/images/5-Workshop/5.5-Lambda/5.28.png)  
![Upload code for each function](/images/5-Workshop/5.5-Lambda/5.29.png)
**Figure 5.5.5** — Upload the source code .zip file for each Lambda function (7 functions).