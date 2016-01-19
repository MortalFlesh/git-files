#
# ssl on vagrant (centos + apache 2.2)
# https://www.digitalocean.com/community/tutorials/how-to-create-a-ssl-certificate-on-apache-for-centos-6
#

# module for apache
sudo yum install mod_rewrite

# dir for certificate
sudo mkdir /etc/httpd/ssl

# showing info for generating
echo ===================
echo USE FOLLOWING INFO:
echo ===================
echo Country Name (2 letter code) [XX]:CZ
echo State or Province Name (full name) []:Prague
echo Locality Name (eg, city) [Default City]:Prague
echo Organization Name (eg, company) [Default Company Ltd]:LMC s.r.o.
echo Organizational Unit Name (eg, section) []:Edu
echo Common Name (eg, your name or your server's hostname) []:seduo.cz
echo Email Address []:admin@seduo.cz
echo ===================

# generating certificate for 1 year
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/httpd/ssl/apache.key -out /etc/httpd/ssl/apache.crt

# edit conf to use certificate
echo ===================
echo CHECK CONFIGURATION
echo ===================
echo $ sudo vim /etc/httpd/conf.d/ssl.conf
echo FILE ABOVE SHOULD CONTAINS FOLLOWING IN BLOCK <VirtualHost _default_:443>
echo ===================
echo SSLEngine on
echo SSLCertificateFile /etc/httpd/ssl/apache.crt
echo SSLCertificateKeyFile /etc/httpd/ssl/apache.key 
