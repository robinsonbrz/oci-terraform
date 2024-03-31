# Automatizando Criação de Instância Free Tier Oracle OCI


### Renomear o arquivo **terraform.tfvarsEXAMPLE** para **terraform.tfvars** e preencher com os dados de sua conta OCI

[Baseado no repositório Oracle](https://github.com/oracle/terraform-provider-oci/tree/master/examples/compute/instance)

[Consultar o README na raiz desse repositório que descreve a criação de chaves e API keys](../README.md)

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


