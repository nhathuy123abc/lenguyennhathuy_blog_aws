---
title: "Amazon Bedrock"
date: 2024-01-01
weight: 11
chapter: false
pre: " <b> 5.11. </b> "
---

Amazon Bedrock is the generative AI service used by SmartCV to analyze CV/job application content and provide improvement suggestions, through the two Lambda functions `insights` and `digest`. The official model chosen for the project is **Amazon Nova Lite**.

{{% notice note %}}
**Important update:** The current Bedrock interface now **automatically enables (auto-enable)** serverless foundation models — you **do not need** to manually "Request model access" as required in older Console versions.
{{% /notice %}}

#### Step 1: Check Model Access

1. Open the AWS Console, type **Bedrock** into the search box, and access the service.
2. In the left sidebar, under **Configure and learn**, select **Model access**.

**Figure AI-01.** Amazon Bedrock's new Model access page shows that serverless foundation models have been automatically activated, with no need to manually request access as before.

![Model access page](/images/5-Workshop/5.11-Bedrock/image5.png)
**Figure 5.11.1** — The Model access page showing models that are already automatically available for use.

#### Step 2: Select a Model in the Model Catalog

1. Still in the sidebar, select **Model catalog**.
2. Type **Nova Lite** into the search box and select the **Amazon Nova Lite** model — this is the official AI model used for the SmartCV project.

**Figure AI-02.** The Amazon Nova Lite model in the Bedrock Model catalog, used as the primary AI model for the SmartCV Insights feature.

![Selecting Amazon Nova Lite in the Model catalog](/images/5-Workshop/5.11-Bedrock/image6.png)
**Figure 5.11.2** — Amazon Nova Lite in the Model catalog.

#### Step 3: Test the Model in the Playground

1. On the Nova Lite model page, choose **Open in playground** (or go to **Playgrounds** in the sidebar).

![Opening Nova Lite in the Playground](/images/5-Workshop/5.11-Bedrock/5.11.1.png)
**Figure 5.11.3** — Opening Amazon Nova Lite in the Playground to test it.

2. If prompted, grant permission (**Grant permission**) so your account can use the Playground.

![Granting permission to use the Playground](/images/5-Workshop/5.11-Bedrock/image7.png)
**Figure 5.11.4** — Granting Playground access permission.

3. Try entering a sample CV and an analysis prompt to check the quality of the model's response before integrating it into your code.

#### Step 4: Create an API Key to Connect Bedrock to the Project

1. In the Bedrock Console, create a **Short-term API key** to use when calling Bedrock from the Lambda code.

![Creating a Short-term API Key](/images/5-Workshop/5.11-Bedrock/image8.png)
**Figure 5.11.5** — Creating a Short-term API Key in the Bedrock Console.

2. Copy the API key you just created — you'll use it in the next step.

#### Step 5: Attach the API Key to the Project Code

1. Open the SmartCV source code, and go into the `insights` and `digest` folders (the two Lambda functions that call Bedrock).
2. In the `handler.py` file of **each** folder, find the section that declares the Bedrock client.
3. Paste the API key you copied into the correct location in the client declaration (following the specific instructions in the code comments).

{{% notice warning %}}
**Do not commit the API key directly into source code** when pushing to a public Git repository. A safer approach is to store the API key in the Lambda's environment variables (section [5.5](../5.5-lambda/) → Environment variables, e.g. adding a `BEDROCK_API_KEY` variable) and read it from `os.environ` inside `handler.py`, instead of hard-coding it directly in the file.
{{% /notice %}}

4. After updating the code, re-zip and upload the new `.zip` file for the `smartcv-insights` and `smartcv-digest` functions, following the instructions in section [5.5](../5.5-lambda/).
5. Re-test the Lambda functions to confirm that calls to Bedrock succeed, with no more authentication errors.
