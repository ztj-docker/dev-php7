FROM ztj1993/alpine-php7:latest

LABEL maintainer="Ztj <ztj1993@gmail.com>"

ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
ADD http://phar.phpunit.cn/phpunit.phar /usr/local/bin/phpunit

RUN echo "---------- composer ----------" \
  && chmod +x /usr/local/bin/composer \
  && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
  && echo "---------- phpunit ----------" \
  && chmod +x /usr/local/bin/phpunit \
  && echo "---------- end ----------"
