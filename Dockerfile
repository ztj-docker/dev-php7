FROM ztj1993/alpine-php7:latest

LABEL maintainer="Ztj <ztj1993@gmail.com>"

ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
ADD https://phar.phpunit.de/phpunit.phar /usr/local/bin/phpunit

RUN echo "---------- apache----------" \
  && apk update \
  && apk add apache2 php7-apache2 \
  && rm -rf /var/cache/apk/* \
  && echo "---------- nginx----------" \
  && apk update \
  && apk add nginx \
  && rm -rf /var/cache/apk/* \
  && echo "---------- composer ----------" \
  && chmod +x /usr/local/bin/composer \
  && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
  && composer config -g secure-http false \
  && composer self-update \
  && echo "---------- phpunit ----------" \
  && chmod +x /usr/local/bin/phpunit \
  && echo "---------- end ----------"

RUN mkdir -p /run/apache2
RUN ln -sf /dev/stdout /var/log/apache2/access.log
RUN ln -sf /dev/stderr /var/log/apache2/error.log
RUN sed -i 's@^#ServerName.*@ServerName localhost@' /etc/apache2/httpd.conf
RUN sed -i "s@Require ip 127@Require ip 127 192 10@" /etc/apache2/conf.d/info.conf
RUN sed -i "s@AllowOverride None@AllowOverride All@" /etc/apache2/httpd.conf
RUN sed -i "s@AllowOverride none@AllowOverride all@" /etc/apache2/httpd.conf
RUN sed -i "s@^#LoadModule rewrite_module@LoadModule rewrite_module@" /etc/apache2/httpd.conf
RUN sed -i "s@^#LoadModule info_module@LoadModule info_module@" /etc/apache2/httpd.conf
