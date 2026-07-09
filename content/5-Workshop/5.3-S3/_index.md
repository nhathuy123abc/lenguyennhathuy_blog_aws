---
title: "Amazon S3"
date: 2024-01-01
weight: 3
chapter: false
pre: " <b> 5.3. </b> "
---

The S3 bucket will be used to store the project's PDF Resume files. For security, this bucket will be completely **private**, but the Frontend can upload files directly via **Presigned URLs**.

1. Access the **Amazon S3** service on the AWS Console, select the **`ap-southeast-1`** Region (the same Region used for DynamoDB).
2. Click **Create bucket**.
3. **General configuration:**
   - **Bucket name:** Enter `smartcv-resumes-YOUR_NAME` (the bucket name must be globally unique, replace `YOUR_NAME` with your name).
   - **AWS Region:** `ap-southeast-1`.
4. **Block Public Access settings:** ensure **Block all public access** is **Enabled (Checked)** — do not make this bucket public.
5. Click **Create bucket**.
6. After creation, click on the bucket name, switch to the **Permissions** tab.
7. Scroll down to the **Cross-origin resource sharing (CORS)** section, click **Edit** and paste the following JSON:

```json
[
  {
    "AllowedHeaders": ["*"],
    "AllowedMethods": ["GET", "PUT"],
    "AllowedOrigins": ["*"],
    "ExposeHeaders": []
  }
]
```
![Create Bucket](/images/5-Workshop/5.3-S3/5.45.png)
**Figure 5.3.1** — Create the `smartcv-resumes-YOUR_NAME` S3 bucket with Block Public Access enabled.

![Configure CORS](/images/5-Workshop/5.3-S3/5.49.png)
**Figure 5.3.2** — Configure CORS to allow the Frontend to upload via a Presigned URL.

The `smartcv-resumes-YOUR_NAME` bucket is now ready for Lambda to generate Presigned URLs and integrate file uploads from the Frontend.