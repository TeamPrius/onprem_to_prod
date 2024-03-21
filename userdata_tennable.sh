#!/bin/bash

# Install Apache Web Server and PHP
dnf install -y httpd wget php-fpm php-mysqli php-json php php-devel
dnf install -y mariadb105-server

# Download Lab files
wget https://aws-tc-largeobjects.s3-us-west-2.amazonaws.com/ILT-TF-200-ACACAD-20-EN/mod6-
guided/scripts/inventory-app.zip
unzip inventory-app.zip -d /var/www/html/

# Download and install the AWS SDK for PHP
wget https://github.com/aws/aws-sdk-php/releases/download/3.62.3/aws.zip
unzip aws -d /var/www/html

# Turn on web server
systemctl enable httpd
systemctl start httpd








#Create Nessus agent and link to console
sudo su
curl -H 'X-Key: 1dbb14c0bfcdb7913d7d891003cc2034b41b279007e20b744de68de6aea49e04' 'https://sensor.cloud.tenable.com/install/agent?name=ModifiedPriusProdTestAgents&groups=PriusAgents' | bash
/opt/nessus_agent/sbin/nessuscli agent link \
        --key=1dbb14c0bfcdb7913d7d891003cc2034b41b279007e20b744de68de6aea49e04 \
        --host=cloud.tenable.com \
        --port=443 \
        --name=PriusProdTestAgents \
        --groups=PriusGroup
        
        
#modified onpremec2 file to point ec2 to a different user data file (userdataprem.sh)
#created userdataprem.sh with the following content:
#!/bin/bash
#Install Nessus scanner and link to console
#sudo su
#curl -H 'X-Key: 1dbb14c0bfcdb7913d7d891003cc2034b41b279007e20b744de68de6aea49e04' 'https://sensor.cloud.tenable.com/install/scanner?name=priustest2&groups=PriusGroup' | bash
