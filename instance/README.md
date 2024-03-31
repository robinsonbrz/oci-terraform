# Automatizando Criação de Instância Free Tier Oracle OCI


### Renomear o arquivo **terraform.tfvarsEXAMPLE** para **terraform.tfvars** e preencher com os dados de sua conta OCI

Essa configuração Terraform necessita apontar para uma Subnet e VCN pré configurada no arquivo terraform.tfvars

``` bash
# Autenticar na OCI
oci session authenticate

# Inicializar o Terraform 
terraform init

# Formatar
terraform fmt

# Validar
terraform validate


# Checar o plano
terraform plan

# Aplicar o plano 
terraform apply

# Destruir
terraform apply -destroy

```


