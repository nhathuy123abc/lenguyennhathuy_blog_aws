---
title: "Amazon API Gateway"
date: 2024-01-01
weight: 7
chapter: false
pre: " <b> 5.7. </b> "
---

API Gateway is the communication gateway between the React Frontend and the Lambda Backend. The Frontend calls the API via the Gateway, and the Gateway routes the request to the correct Lambda for processing.

Manually creating each Resource and Method on the Console would take a lot of time, so the project has prepared an OpenAPI file for bulk import.

#### Import API from OpenAPI file

1. Open the `api/openapi.yml` file in the SmartCV source code using a text editor (VSCode, Notepad...).
2. Access the **API Gateway** service on the AWS Console.
3. Find the **REST API** section and select **Import**.
4. Paste the entire content of the `openapi.yml` file into the editor.
5. For **Endpoint Type**, select *Regional*.
6. Click **Import**.

![Import OpenAPI](/images/5-Workshop/5.7-APIGateway/image40.png)
![Import OpenAPI](/images/5-Workshop/5.7-APIGateway/image41.png)
**Figure 5.7.1** — Import the `openapi.yml` file to create a REST API.

API Gateway will automatically create an API named `SmartCV API` with all resources and methods.

![Created API](/images/5-Workshop/5.7-APIGateway/image42.png)
**Figure 5.7.2** — The `SmartCV API` is automatically created with full resources/methods.

#### Configure Cognito Authorizer

1. In the left menu of `SmartCV API`, select **Authorizers**.
2. You will see a pre-created Authorizer named `cognitoAuth`. Click on it and select **Edit**.
3. **Cognito User Pool:** select `smartcv-users` (the User pool created in section 5.4).
4. Click **Save**.

![Configure Authorizer](/images/5-Workshop/5.7-APIGateway/image43.png)
**Figure 5.7.3** — Attach the `cognitoAuth` Cognito Authorizer to the `smartcv-users` User pool.

#### Enable CORS for API Gateway

{{% notice warning %}}
If the Frontend (Amplify) and API Gateway are on different domains (which is always true for this architecture), **missing CORS will cause all browser requests to be blocked** with a `blocked by CORS policy` error, even if Lambda and IAM are correctly configured.
{{% /notice %}}

1. In the **Resources** menu, select the root resource (e.g., `/applications`).
2. Select **Actions** (or the **Enable CORS** button if available on the new UI).
3. **Access-Control-Allow-Origin:** enter `*` (or the actual Amplify domain when moving to production).
4. **Access-Control-Allow-Headers:** keep the default (`Content-Type,Authorization,X-Amz-Date,...`).
5. **Access-Control-Allow-Methods:** check the methods being used (GET, POST, PUT, DELETE, OPTIONS).
6. Click **Save**, then repeat this for **all** other resources: `/insights`, `/settings`, `/notes`, `/resumes`.

![Enable CORS](/images/5-Workshop/5.7-APIGateway/image44.png)
**Figure 5.7.4** — Enable CORS for each resource (applications, insights, settings, notes, resumes).

#### Integrate Methods with Lambda (Lambda Proxy Integration)

Perform this for **each Method** (GET, POST, PUT, DELETE) of every Resource:

1. In the **Resources** menu, click on a Method (e.g., `GET` of `/applications`).
2. Click **Edit integration** (or *Integration Request* → *Edit*).
3. **Integration type:** *Lambda function*.
4. **Use Lambda Proxy integration:** this must be **Enabled (Checked)**.
5. **Lambda function:** type the corresponding function name (e.g., `/applications` → `smartcv-applications`).
6. Click **Save** and grant permission when prompted.

Repeat this for all Resources: `/insights` → `smartcv-insights`, `/settings` → `smartcv-settings`, `/notes` → `smartcv-notes`, `/resumes` → `smartcv-applications`.

![Lambda Proxy Integration](/images/5-Workshop/5.7-APIGateway/image45.png)
**Figure 5.7.5** — Integrate the Method with the corresponding Lambda function (Lambda Proxy Integration).

#### Deploy API

1. Click **Deploy API** (top right corner).
2. **Deployment stage:** select *[New Stage]*.
3. **Stage name:** enter `v1` (**important**: this must match the `/v1` declaration in the OpenAPI file).
4. Click **Deploy**.
5. After successful deployment, you will see an **Invoke URL** (e.g., `https://xxxxxx.execute-api.ap-southeast-1.amazonaws.com/v1`). Copy this URL — it will serve as the Backend URL for the Frontend.

![Deploy successful, get Invoke URL](/images/5-Workshop/5.7-APIGateway/image46.png)
**Figure 5.7.6** — Deploy API to stage `v1` and get the Invoke URL for the Frontend.