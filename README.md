# Automatizando Criação de Instância Free Tier Oracle OCI


### Experimento prático sobre a criação de recursos utilizando Terraforma na nuvem Oracle OCI.

A utilização do Terraform e Infraestrutura como Código **IaC** permite o setup e destruição rápido de recursos na nuvem.

Este repositório contém arquivos organizados em pastas, utilizados para criar recursos e pode ser um ponto de partida para implementações mais complexas tanto na OCI e outros provedores de serviços nuvem.

Cada pasta tem um propósito específico e terá um README.md mais específico sobre sua utilização.

Antes da utilização preencher as variáveis do arquivo terraform.tfvars com as informações do seu provedor e região.

### Pré-requisitos:


[Conta Free Tier OCI - ou conta comercial OCI - para criação de recursos nuvem](https://signup.cloud.oracle.com/?language=en&sourceType=:ow:o:p:feb:0916FreePageBannerButton&intcmp=:ow:o:p:feb:0916FreePageBannerButton)

[**OCI CLI**](https://docs.oracle.com/pt-br/iaas/Content/API/SDKDocs/cliinstall.htm)

[**Terraform**](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Comandos básicos Terraform e OCI Cli que serão utilizados


```bash
# Autenticar na OCI
oci session authenticate

# Inicializar o Terraform e atualizar com provider
terraform init

# Formatação dos arquivos Terraform
terraform fmt

# Validar
terraform validate

# Checar o plano
terraform plan

# Aplicar no provider
terraform apply

# Destruir o plano já aplicado
terraform apply -destroy

```


