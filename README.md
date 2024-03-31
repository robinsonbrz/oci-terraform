# Automatizando a Criação de Instâncias Free Tier Oracle OCI


### Arqiivos para criação de recursos utilizando Terraforma na nuvem Oracle OCI.

A utilização do Terraform e Infraestrutura como Código **IaC** permite o setup e destruição rápido de recursos na nuvem.

  <div align="center">
    <table>
      </tr>
            <td>
                <a  href="https://www.linkedin.com/in/robinsonbrz/">
                Adaptação e deploy por Robinson Enedino
            </td>
        <td>
            <a  href="https://www.linkedin.com/in/robinsonbrz/">
            <img src="https://raw.githubusercontent.com/robinsonbrz/robinsonbrz/main/static/img/linkedin.png" width="30" height="30">
        </td>
        <td>
            <a  href="https://www.linkedin.com/in/robinsonbrz/">
            <img  src="https://avatars.githubusercontent.com/u/18150643?s=96&amp;v=4" alt="@robinsonbrz" width="30" height="30">
        </td>
        <td>
            <a href="mailto:robinsonbrz@gmail.com">
            <img src="https://raw.githubusercontent.com/robinsonbrz/robinsonbrz/main/static/img/gmail.png" width="30" height="30" ></a>
        </td>
      </tr>
    </table>
  </div>

Este repositório contém arquivos organizados em pastas, utilizados para criar recursos e pode ser um ponto de partida para implementações mais complexas tanto na OCI e outros provedores de serviços nuvem.

Cada pasta tem um propósito específico e terá um README.md mais específico sobre sua utilização.


### Pré-requisitos:

Criar par de chaves para criação de API Key e geração de fingerprint


```bash
# Create a hidden subdirectory to store the PEM key
mkdir ~/.oci

# Generate a private key (2048 bits or higher)
openssl genrsa -out ~/.oci/oci_api_key.pem 2048

# Set permissions to ensure only you can read the key
chmod go-rwx ~/.oci/oci_api_key.pem

# Generate the public key for the private key
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem

```

Com esse par de chaves já é possível Gerar uma Api Key e o Fingerprint.

Na Dash OCI clicar em My Profile -> Api Keys -> Add API Keys

Selecione Paste Public Key

E cole o conteúdo dentro do arquivo gerado no passo anterior: "~/.oci/oci_api_key_public.pem"

Isso irá criar a sua chave "API Key", copie o "Fingerprint" gerado e cole no arquivo terraform.tfvars


---

Outro requisito nesta implementação é o par de chaves ssh que ficam em "~/.ssh/" em algumas distribuições Linux.

A chave pública será utilizada para acessar a instância após a sua criação.

O caminho dessa chave deve ser adicionado a variavel no arquivo terraform.tfvars como no EXAMPLE

---

Também na console OCI será necessário extrair as seguintes informações para construir a instância: 

```bash
tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaaadslkdasçlkasdçlkasdçlkdçlaksldkds"
user_ocid="ocid1.user.oc1..aaaaaaaaadslkdasçlkasdçlkasdçlkdçlaksldksd"
fingerprint="Gerado com a API Key"

# 
private_key_path="~/.oci/oci_api_key.pem"
# Em region coloque a sua região OCI
region="sa-saopaulo-1"

# O ocid de seu compartimento
compartment_ocid="ocid1.compartment.oc1..aaaaaaaaadslkdasçlkasdçlkasdçlkdçlaksldk"
ssh_public_key="/home/seuusuariolinux/.ssh/id_rsa.pub"
```
---






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


  <h1 align="center"> Informações e contato </h1> 
  <div align="center">
    <table>
        </tr>
            <td>
                <a  href="https://www.linkedin.com/in/robinsonbrz/">
                <img src="https://raw.githubusercontent.com/robinsonbrz/robinsonbrz/main/static/img/linkedin.png" width="100" height="90">
            </td>
            <td>
                <a  href="https://www.linkedin.com/in/robinsonbrz/">
                <img  src="https://avatars.githubusercontent.com/u/18150643?s=96&amp;v=4" alt="@robinsonbrz" width="30" height="30">
            </td>
            <td>
                <a href="https://www.enedino.com.br/contato">
                <img src="https://raw.githubusercontent.com/robinsonbrz/robinsonbrz/main/static/img/gmail.png" width="120" height="100" ></a>
            </td>
        </tr>
    </table> 
  </div>
  <br>
</div>


