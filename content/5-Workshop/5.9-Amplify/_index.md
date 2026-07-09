---
title: "AWS Amplify"
date: 2024-01-01
weight: 9
chapter: false
pre: " <b> 5.9. </b> "
---

AWS Amplify is used to build and deploy the SmartCV React Frontend to the Internet, connecting it to the Backend created in the previous sections (API Gateway, Cognito).

#### Step 1: Initialize the Amplify App

1. Access the **AWS Amplify** service on the AWS Console.
2. Choose **New app** → **Host web app**, connect to the repository containing the Frontend source code (GitHub/GitLab/Bitbucket) and select the correct branch to deploy.
3. Name the app `smartcv-frontend`.

![Initializing the Amplify App name](/images/5-Workshop/5.9-Amplify/5.9.1.png)
**Figure 5.9.1** — Initializing the Amplify App with the name `smartcv-frontend`.

4. Confirm the default build configuration that Amplify automatically detects (React/Vite framework), and add any required environment variables for the Frontend (API Gateway URL, User Pool ID, Client ID... obtained from previous sections) if the project requires them.
5. Click **Save and deploy** to let Amplify automatically build and deploy the app.

#### Step 2: Check the Deployment Status

1. After the build finishes (usually within a few minutes), go back to the overview page of the `smartcv-frontend` app.
2. Check the deployment status of the selected branch — if it shows **Deployed** with a green checkmark, the Frontend has been successfully deployed.

![Checking successful deployment on Amplify](/images/5-Workshop/5.9-Amplify/5.9.2.png)
**Figure 5.9.2** — "Deployed" status (green checkmark) on the Amplify Console.

3. Click on the default Amplify domain (in the form `https://main.xxxxxxxxxx.amplifyapp.com`) to open the SmartCV Frontend in your browser.

{{% notice note %}}
If you'd like to use a custom domain instead of the default Amplify domain, continue to section [5.10 Amazon Route 53](../5.10-route53/).
{{% /notice %}}
