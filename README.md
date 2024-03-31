Automatizando Criação de Instância Free Tier Oracle OCI


Necessário apontar uma Subnet pré configurada

Renomear o arquivo **.tfvarsEXAMPLE** para **.tfvars** preencher com os dados de sua conta OCI



```
# Autenticar na OCI
oci session authenticate

# Inicializar o Terraform 
terraform init

# Formatar
terraform fmt

# Validar
terraform validate


# validar o plano
terraform plan -var-file=".tfvars"

# Aplicar
terraform apply -var-file=".tfvars"

# Destruir
terraform apply -var-file=".tfvars" -destroy

```


