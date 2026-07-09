---
title: "Amazon SES"
date: 2024-01-01
weight: 6
chapter: false
pre: " <b> 5.6. </b> "
---

Amazon SES is used to send automated emails to users, including **Weekly Digest** (job application summary) and **Follow-up Reminder** (application tracking reminder) emails.

1. Access the **Amazon SES** service on the AWS Console.
2. In the left menu, under the **Configuration** section, select **Identities**.
3. Click **Create identity**.
4. Select the identity type as **Email address**.
5. Enter your email address in the **Email address** field.

![Create Identity on SES](/images/5-Workshop/5.6-SES/ses1.png)
**Figure 5.6.1** — Create an Identity (email address) on Amazon SES.

AWS will send a confirmation email to your inbox with the subject *"Amazon Web Services – Email Address Verification Request"*.

6. Open your inbox (check the spam/junk folder as well) and click on the link in the email to verify.

![Confirmation email from AWS SES](/images/5-Workshop/5.6-SES/ses2.png)
**Figure 5.6.2** — Verification email sent from AWS; you need to click the link to confirm.

7. Return to the **Verified identities** page on the SES Console and check if the Identity status of the email has changed to a green **Verified**.

![Successful Verification](/images/5-Workshop/5.6-SES/ses3.png)
**Figure 5.6.3** — The Identity status changes to "Verified" (green).

#### Update the sender email in Lambda

After verifying the email, update this email in the environment variables of the 2 Lambda functions that send emails (`smartcv-digest` and `smartcv-followup`):

1. Access the **Lambda** service again and open the `smartcv-digest` function.
2. Switch to the **Configuration** tab → **Environment variables**.
3. Add/edit the `SES_FROM_EMAIL` variable = your verified email address.
4. Do the same for the `smartcv-followup` function.

{{% notice note %}}
Because Amazon SES is in Sandbox mode by default, you need to verify **both the sender and recipient emails** (if the AWS account has not been moved out of the Sandbox). In a real Production environment, you need to submit a "Request production access" to remove the Sandbox limits.
{{% /notice %}}