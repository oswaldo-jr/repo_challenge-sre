# challenge-sre-2023
Repositório para o desafio challenge SRE

#README
# Proposito: Automatizar instalação do Nginx na instancia EC2 AWS
# Autor: Oswaldo Galdino - og.junior@hotmail.com
# http://23.23.10.251/
# ------------------------------------------------------------

Para a instalação do ambiente na amazon utilizando o recurso é preciso:

- Acessar o repositório no github https://github.com/oswaldo-jr/challenge-sre-2023
- Baixe o arquivo infra_terraform
	- Acesse a console da AWS;
	- Clique no ícone do CloudShell
	- Após o CloudShell inicializar copie e cole as linhas abaixo instalar o TerraForm:
	sudo yum install -y yum-utils
	sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
	sudo yum -y install terraform  
		Para a ultima linha será necessário apertar ENTER!
	Após a instalação do TerraForm baixe o arquivo .tf para provisionar a infraestrutura.
	LEMBRE-SE de editar o arquivo com suas informações de:
		- vpc_id
		- subnet_id
		- key_name
	Para baixar utilize o comando wget e a url https://github.com/oswaldo-jr/repo_challenge-sre/blob/main/challenge-sre-main.tf
	Desta forma: wget https://github.com/oswaldo-jr/repo_challenge-sre/blob/main/challenge-sre-main.tf
- Depois de baixar dentro do diretorio onde se encontra o arquivo challenge-sre-main.tf utilize os comando
	- terraform init
	- terraform plan
	- terraform apply
	
- Após o processo de provisionamento da infraestrutura terminar acesse a console da AWS e vá até o serviço "EC2"
	- Dentro do serviço EC2 clique em Instances (running)
		- Clique no instance ID da instancia criada e no campo Public IPv4 address copie o IP da sua instancia.
Com o IP e a chave pública será possível acessar a instancia LINUX UBUNTU por SSH!

===================================================================================================

Criando o servidor NGINX:

	Após acessar o ssh da instancia EC2 LINUX UBUNTU, altere para o usuário root com o comando sudo su -
- Como root utilize novamente o wget para fazer o download do script de instalação do NGINX com o comando:
		- wget https://github.com/oswaldo-jr/repo_challenge-sre/blob/main/challenge-sre-install_nginx.sh
		
		Altere as permissões do arquivo com o comando chmod +x challenge-sre-install_nginx.sh
		Agora execute o script com o comando ./challenge-sre-install_nginx.sh
		..
		Assim que o script finalizar a instalação, direto de um navegador web acesse a página utilizando o IP da instancia.
		http://IP-PUBLICO.

