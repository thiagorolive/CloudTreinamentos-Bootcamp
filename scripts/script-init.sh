#!/bin/bash
#atualização e instalação de ferramentas
apt-get update
apt-get upgrade -y
# chave ssh
 echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCReTMb6l44iRxY8q6c1EcPQih9SuwRLYgenJMSUHtvrn73wuf5Qm8l6ZCtdD3fN7ECdgNL5TLc1Bxev6CaAmAuiSukWCSFW61xiGEfZQ/dpRrZwuKr6buKoQNs+38DgJdsywlfTnFog1tmZXmm0pzlyOQaPGLGYyHX58c8dYrFJDKojNxqhTjFzCs5NTq4aU4qUKyDCINeLc0z1ZiUT6kyuFLh9zEHKNefcAFzLgHl1biOlG6fXaPc8J1Y2iPUma7eCkBausUyuW6A0EMTk4fX5jbFgoltHxY/O+AN5gyUhDGEq7EGos86yhFXg2aDhKHn41sPZ6iutFAUlTGINQ5szzte4xzPpzWVeNJ70dDCzfUXBS52AutRpnCTZi6fCNwY+abEwGf63X2Lzt1r7fN+icBBY1ld7gMf/+6idquXGgFND4FGxBZQZez3IMWPpWFvbmXgesfR+wIWtOCRPJbnokRbDGTnjLV/TZ/gpzoCyvNGB6gS067jxcEHCKBmegs=" >> home/ubuntu/.ssh/authorized_keys
# 
#instalação dos pacotes necessários
# 
sudo apt-get install apache2 php7.4 libapache2-mod-php7.4 php7.4-common php7.4-curl php7.4-intl php7.4-mbstring php7.4-json php7.4-xmlrpc php7.4-soap php7.4-mysql php7.4-gd php7.4-xml php7.4-cli php7.4-zip wget mysql-client unzip git binutils ruby -y
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl restart apache2
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start
sudo chmod 777 /etc/init.d/codedeploy-agent
#
#deploy da aplicação do bootcamp
#
sudo wget https://s3.sa-east-1.amazonaws.com/pages.cloudtreinamentos.com/aws/bootcamp/Bootcamp9.zip 
sudo unzip -o Bootcamp9.zip -d /var/www/html/
sudo rm /var/www/html/index.html
sudo chmod -R 777 /var/www/html