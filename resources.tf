
resource "kubernetes_namespace" "litellm" {
  metadata {
    name = "litellm"
  }
}

resource "kubernetes_secret" "litellm_secrets" {
  metadata {
    name      = "litellm-secrets"
    namespace = kubernetes_namespace.litellm.metadata[0].name
  }

  data = {
    OPENAI_API_KEY     = var.openai_api_key
    ANTHROPIC_API_KEY  = var.anthropic_api_key
    AWS_ACCESS_KEY_ID  = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
  }

  type = "Opaque"
}

resource "kubernetes_config_map" "litellm_config" {
  metadata {
    name      = "litellm-config"
    namespace = kubernetes_namespace.litellm.metadata[0].name
  }

  data = {
    "config.yaml" = <<EOF
model_list:
  - model_name: gpt-4-primary
    litellm_params:
      model: gpt-4o
      api_key: os.environ/OPENAI_API_KEY

  - model_name: gpt-4-fallback
    litellm_params:
      model: anthropic/claude-3-sonnet
      api_key: os.environ/ANTHROPIC_API_KEY

router_settings:
  fallbacks:
    gpt-4-primary:
      - gpt-4-fallback

general_settings:
  master_key: os.environ/LITELLM_MASTER_KEY
  database_url: postgresql://litellm:litellm@postgres:5432/litellm

litellm_settings:
  telemetry: true
EOF
  }
}

resource "helm_release" "litellm" {
  name       = "litellm"
  namespace  = kubernetes_namespace.litellm.metadata[0].name
  repository = "https://helm.litellm.ai"
  chart      = "litellm"
  version    = "1.35.2"

  values = [yamlencode({
    replicaCount = 2

    image = {
      repository = "ghcr.io/berriai/litellm"
      tag        = "main"
    }

    envFrom = [
      {
        secretRef = {
          name = kubernetes_secret.litellm_secrets.metadata[0].name
        }
      }
    ]

    extraEnv = [
      {
        name  = "LITELLM_CONFIG"
        value = "/app/config/config.yaml"
      }
    ]

    volumeMounts = [
      {
        name      = "config"
        mountPath = "/app/config"
      }
    ]

    volumes = [
      {
        name = "config"
        configMap = {
          name = kubernetes_config_map.litellm_config.metadata[0].name
        }
      }
    ]

    service = {
      type = "ClusterIP"
      port = 4000
    }

    resources = {
      requests = {
        cpu    = "250m"
        memory = "512Mi"
      }
      limits = {
        cpu    = "1"
        memory = "1Gi"
      }
    }
  })]
}
