---
title: "Amazon Cognito"
date: 2024-01-01
weight: 4
chapter: false
pre: " <b> 5.4. </b> "
---

Amazon Cognito plays the role of user authentication (sign-up, sign-in) for SmartCV, issuing JWT tokens so the Frontend can securely call the API.

1. In the AWS Management Console, type **Cognito** in the search bar and press Enter.
2. Click **Create user pool**. In the **Cognito user pool sign-in options** section, check **Email**.
3. Leave the remaining settings as default, and name the user pool `smartcv-users`.

![Create User Pool](/images/5-Workshop/5.4-Cognito/5.50.png)
**Figure 5.4.1** — Create the `smartcv-users` User Pool with Email sign-in.

#### Get configuration information for the Frontend

Once created, you need to retrieve the parameters to configure the React Frontend later:

1. Click on the newly created `smartcv-users` User pool.
2. On the overview page, copy the **User pool ID** (e.g., `ap-southeast-1_xxxxxxxxx`) and save it to your notes.
3. Switch to the **App integration** tab.
4. Scroll down to the **App client list** section, copy the **Client ID** of `smartcv-frontend` and save it to your notes.

![Get User Pool ID and Client ID](/images/5-Workshop/5.4-Cognito/5.51.png)
**Figure 5.4.2** — Copy the User pool ID and Client ID to configure the Frontend.