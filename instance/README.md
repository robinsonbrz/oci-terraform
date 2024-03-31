Automatizando Criação de Instância Free Tier Oracle OCI


Essa configuração Terraform necessita apontar para uma Subnet pré configurada

Renomear o arquivo 

**terraform.tfvarsEXAMPLE** para **terraform.tfvars** 

e preencher com os dados de sua conta OCI



```
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


