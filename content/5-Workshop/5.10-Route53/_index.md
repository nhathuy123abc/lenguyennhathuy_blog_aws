---
title: "Amazon Route 53"
date: 2024-01-01
weight: 10
chapter: false
pre: " <b> 5.10. </b> "
---

Amazon Route 53 is used to attach a **custom domain** (e.g. `smartcv.com`) to the Frontend application running on AWS Amplify, instead of using the default domain in the form `https://main.xxxxxxxxxx.amplifyapp.com` from section [5.9](../5.9-amplify/).

{{% notice note %}}
This section is **optional**. If you don't need a custom domain, you can skip it and use the default Amplify domain directly.
{{% /notice %}}

#### Step 1: Register a Domain on Route 53

1. Access the **Amazon Route 53** service on the AWS Console.
2. In the left-hand menu, choose **Domains** → **Registered domains** → **Register domain**.
3. Enter the domain name you want (e.g. `smartcv-yourname.com`) and click **Check** to see if it's available.
4. If the domain is available, add it to your cart (**Add to cart**), then fill in your contact information and complete the payment.

![Registering a domain on Route 53](/images/5-Workshop/5.10-Route53/image1.png)
**Figure 5.10.1** — Registering a new domain on Amazon Route 53.

{{% notice warning %}}
A registered domain incurs **real charges** (annually) and **cannot be refunded/canceled** once registration is successful. If you only want to practice, you can use a domain you already own (purchased elsewhere) and simply create a Hosted Zone pointing to Route 53, without registering a new domain in this step.
{{% /notice %}}

After successful registration, Route 53 automatically creates a **Hosted Zone** corresponding to that domain.

#### Step 2: Set Up the Hosted Zone and Records

1. In the left-hand menu, choose **Hosted zones**.
2. Click on the Hosted Zone corresponding to your domain (e.g. `smartcv-yourname.com`).
3. You'll see 2 default records of type **NS** (Name Server) and **SOA** — there's no need to edit these two records.

![List of records in the Hosted Zone](/images/5-Workshop/5.10-Route53/![Registering a domain on Route 53](/images/5-Workshop/5.10-Route53/image1.png)
![Registering a domain on Route 53](/images/5-Workshop/5.10-Route53/image2.png)
**Figure 5.10.2** — Hosted Zone with the default NS/SOA records.

4. The record pointing to Amplify (type **CNAME** or **A - Alias**) will be **automatically added by AWS Amplify** in the next step (Step 3) when you attach the custom domain — you don't need to create it manually here unless Amplify requires domain verification via a separate CNAME record.

#### Step 3: Attach the Custom Domain to AWS Amplify

1. Access the **AWS Amplify** service, select the `smartcv-frontend` app (created in section [5.9](../5.9-amplify/)).
2. In the left-hand menu, choose **App settings** → **Domain management**.
3. Click **Add domain**.
4. Select the domain registered in Step 1 (if that domain was registered under the same AWS account, Amplify will list it automatically).
5. Confirm the branch you want to attach the domain to (e.g. `main`), then click **Save**.
6. Amplify will automatically create the necessary CNAME/A records in the Route 53 Hosted Zone (if the domain is under the same AWS account) and issue a free **SSL certificate** via AWS Certificate Manager.

![Attaching a Custom Domain in Amplify](/images/5-Workshop/5.10-Route53/image3.png)
**Figure 5.10.3** — Attaching a custom domain to the Amplify App.

7. The SSL verification and DNS propagation process can take anywhere from a few minutes to a few hours. Monitor the status under **Domain status**.

#### Step 4: Verify the Domain is Working

1. Once the status changes to **Available**, reopen the **AWS Amplify Console** and go to the `smartcv-frontend` app.
2. Check that the newly attached domain shows the **Deployed** status with a green checkmark.
3. Open the newly attached domain in your browser to confirm the SmartCV Frontend loads correctly through your custom domain.

{{% notice note %}}
If the domain isn't working after several hours, check: (1) whether the Hosted Zone's Name Servers (NS) match those at the domain registrar; (2) whether the SSL verification CNAME record has been added to the Hosted Zone by Amplify; (3) which stage the Domain status on Amplify is currently at (Pending verification / In progress / Available).
{{% /notice %}}
