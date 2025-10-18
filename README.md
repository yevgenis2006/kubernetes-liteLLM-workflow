<img width="286" height="77" alt="image" src="https://github.com/user-attachments/assets/f767fde7-8419-410f-bc34-535a9bbbd983" />


## Kubernetes AI Foundation LiteLLM | ☸️
LiteLLM is an open-source LLM gateway that provides a unified interface to over 100 different large language models (LLMs) from various providers like OpenAI, Anthropic, and Cohere, allowing developers to interact with them using a single, OpenAI-compatible API format. It simplifies integration by handling the complexities of different model providers, offering features such as load balancing, cost tracking, authentication, and logging. 

Call all LLM APIs using the OpenAI format [Bedrock, Huggingface, VertexAI, TogetherAI, Azure, OpenAI, Groq etc.] 

🎯 Features
```
Security:
✅ SSO for Admin UI
✅ Audit Logs with retention policy
✅ JWT-Auth
✅ Control available public, private routes (Restrict certain endpoints on proxy)
✅ Control available public, private routes
✅ Secret Managers - AWS Key Manager, Google Secret Manager, Azure Key, Hashicorp Vault
✅ [BETA] AWS Key Manager v2 - Key Decryption
✅ IP address‑based access control lists
✅ Track Request IP Address
✅ Use LiteLLM keys/authentication on Pass Through Endpoints
✅ Set Max Request Size / File Size on Requests
✅ Enforce Required Params for LLM Requests (ex. Reject requests missing ["metadata"]["generation_name"])
✅ Key Rotations

Customize Logging, Guardrails, Caching per project:
✅ Team Based Logging - Allow each team to use their own Langfuse Project / custom callbacks
✅ Disable Logging for a Team - Switch off all logging for a team/project (GDPR Compliance)

Spend Tracking & Data Exports
✅ Set USD Budgets Spend for Custom Tags
✅ Set Model budgets for Virtual Keys
✅ Exporting LLM Logs to GCS Bucket, Azure Blob Storage
✅ /spend/report API endpoint

Prometheus Metrics:
✅ Prometheus Metrics - Num Requests, failures, LLM Provider Outages
✅ x-ratelimit-remaining-requests, x-ratelimit-remaining-tokens for LLM APIs on Prometheus

Custom Branding
✅ Custom Branding + Routes on Swagger Docs
✅ Public Model Hub
✅ Custom Email Branding
```

🔨 Example : 

```
from litellm import completion
import os
## set ENV variables
os.environ["OPENAI_API_KEY"] = "your-openai-key"
os.environ["ANTHROPIC_API_KEY"] = "your-anthropic-key"

messages = [{ "content": "Hello, how are you?","role": "user"}]

# openai call
response = completion(model="openai/gpt-4o", messages=messages)

# anthropic call
response = completion(model="anthropic/claude-sonnet-4-20250514", messages=messages)
print(response)
---
