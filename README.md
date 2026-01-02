<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/a0f775fa-6e1f-4793-ae27-b4d2191285af" />


## LiteLLM | AWS - GCP - Azure
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



#### 

| Module | Description |
|--------|-------------|
| `CloudFront` | Fast, globally distributed Content Delivery Network|
| `EKS` | Elastic Kubernetes Service, is a fully managed service by Amazon Web Services |
| `Minio` | S3 Object Storage |
| `API Gateway` |REST API |
| `Argo Events` | Event-driven workflow automation |
| `LiteLLM ` |  lightweight, powerful abstraction layer that unifies LLM API calls across providers |



🔧 Example :  Model routing config
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

