#!/bin/bash
# Proposito: Automatizar instalação do Nginx na instancia EC2 AWS
# Utilizacao: Com o usuário root execute ./challenge-sre-install_nginx.sh
# Autor: Oswaldo Galdino - og.junior@hotmail.com
# ------------------------------------------------------------------------------

echo "INICIANDO"
echo "Atualizando OS"
apt update -y
echo ""
echo " Instalando ferramentas uteis para TSHOOT"
apt install links wget curl tcpdump net-tools telnet snap -y
echo ""
echo " Instalando NGINX"
apt install nginx -y
apt install fcgiwrap -y 
chmod 755 /var/www/cgi-bin
systemctl enable fcgiwrap
systemctl restart nginx
echo ""
echo "Liberando portas 80HTTP e 443HTTPS no firewall"
echo ""
apt install firewalld -y
dpkg -L firewalld
systemctl status firewalld
systemctl enable firewalld
firewall-cmd --zone=public --add-port=22/tcp --permanent
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
systemctl restart firewalld
echo ""
echo "Lista de portas"
firewall-cmd --list-ports
echo ""
echo ""
echo " Verificando portas liberadas no firewall"
firewall-cmd --list-all
echo ""
echo " Testando se o serviço NGINX está ativo"
systemctl status nginx
wget https://challenge-sre-2023s.s3.amazonaws.com/challenge.zip
chmod +x challenge.tar.gz
tar -xzf challenge.tar.gz
mv challenge/* /root
cp -rf challenge-sre-2023 /home/ubuntu/
mv /var/www www.bkp
cp -rf www /var
chmod 777 /var/www
chmod 755 /var/www/cgi-bin
systemctl restart nginx
echo ""
curl http://127.0.0.1 
echo ""
echo " O IP PÚBLICO DE ACESSO É"
curl eth0.me
echo "ACESSE UTILIZANDO http://IP-PUBLICO"
exit
