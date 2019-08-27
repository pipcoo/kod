#Version 1.0.0
FROM debian:jessie 
MAINTAINER pipcoo <blcat@hotmail.com>

#FROM php:5.4-apache
#ADD sources.list /etc/apt/sources.list
# Install modules
ENV kodver=4.40
RUN set -x &&\
    apt-get update &&\
	apt-get install -y php5 php5-gd &&\
	apt-get install -y wget unzip &&\
	sed -i "1i DirectoryIndex index.php index.html" /etc/apache2/apache2.conf &&\
	wget -P /tmp/ http://static.kodcloud.com/update/download/kodexplorer${kodver}.zip &&\
	unzip /tmp/kodexplorer${kodver}.zip -d /var/www/html &&\
	userdel www-data &&\
	useradd www-data &&\
    chown -R www-data:www-data /var/www/html &&\
    apt-get purge -y wget unzip && apt-get -y autoremove && apt-get clean &&\
    rm -f /tmp/kodexplorer${kodver}.zip &&\
    echo '<Files *>' > /var/www/html/.htaccess &&\
    echo 'Options -Indexes' >> /var/www/html/.htaccess &&\
    echo '</Files>' >> /var/www/html/.htaccess 

EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]

