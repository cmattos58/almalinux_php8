FROM almalinux:8.5
RUN yum update -y && yum install epel-release -y &&  yum install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm -y && yum module reset php -y &&  yum module enable php:remi-8.0 -y
RUN dnf install php php-cli php-curl php-mysqlnd php-gd php-opcache php-zip php-intl  php-bcmath  php-fedora-autoloader php-gmp php-tidy php-xml php-pgsql php-soap php-sodium php-react-promise php-process php-pecl-imagick httpd-devel httpd httpd-tools -y
RUN mkdir /run/php-fpm

RUN yum -y install supervisor
RUN mkdir -p /run/supervisor
RUN chmod 777 /run/supervisor/ -R


RUN yum clean all &&  rm -rf /var/cache/yum

WORKDIR /var/www/html


#COPY index.php /var/www/html/
#COPY phpinfo.php /var/www/html/
#COPY  html/site /var/www/html/
#COPY  html/sophia /var/www/html/
COPY supervisord.conf /etc/
#COPY php.ini    /etc/

#CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
#CMD ["/usr/sbin/php-fpm","-F","-R"]

#CMD ["/usr/bin/supervisord", "-c" , "/etc/supervisord.conf"]

CMD ["/usr/bin/supervisord"] 

EXPOSE 80
EXPOSE 443
