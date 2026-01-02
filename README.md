<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/84fc45d6-1a5d-4d5e-9b70-2a49df8ec471" />



## LiteLLM | Kubernetes ☸️
LiteLLM is an open-source LLM gateway that provides a unified interface to over 100 different large language models (LLMs) from various providers like OpenAI, Anthropic, and Cohere, allowing developers to interact with them using a single, OpenAI-compatible API format. It simplifies integration by handling the complexities of different model providers, offering features such as load balancing, cost tracking, authentication, and logging. 



🧱 Features
```
✅ Unified API (OpenAI-compatible)
   🔌 OpenAI ,Azure , AWS Bedrock (Claude, Llama, Titan) , Anthropic ,Google Gemini
✅ LLM Gateway (Server Mode)
   🔁 Fallbacks (e.g., GPT-4 → Claude → Llama)
   ⚖️ Load balancing
   🧠 Model routing by rules
   🔑 Centralized API key management
   🧾 Usage tracking & cost visibility
✅ Observability & Governance
✅ Works well with Kubernetes & GitOps
✅ Custom Email Branding
```



🚀 Config | Model routing config
```
model_list:
  - model_name: gpt-4-prod
    litellm_params:
      model: azure/gpt-4o
      api_key: os.environ/AZURE_API_KEY

  - model_name: gpt-4-fallback
    litellm_params:
      model: anthropic/claude-3-sonnet
      api_key: os.environ/ANTHROPIC_API_KEY

router_settings:
  fallbacks:
    gpt-4-prod:
      - gpt-4-fallback
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
