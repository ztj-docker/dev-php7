FROM ztj1993/alpine-php7:latest

LABEL maintainer="Ztj <ztj1993@gmail.com>"

ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
ADD http://phar.phpunit.cn/phpunit.phar /usr/local/bin/phpunit

RUN echo "---------- apache----------" \
  && apk update \
  && apk add apache2 php7-apache2 \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /run/apache2 \
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
