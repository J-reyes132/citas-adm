FROM webdevops/php-nginx:8.1-alpine

ENV WEB_DOCUMENT_ROOT=/app/public

ENV COMPOSER_ALLOW_SUPERUSER=1

ENV PHP_DISMOD=bz2,calendar,exiif,ffi,intl,gettext,ldap,mysqli,imap,pdo_pgsql,pgsql,soap,sockets,sysvmsg,sysvsm,sysvshm,shmop,xsl,zip,gd,apcu,vips,yaml,imagick,mongodb,amqp

WORKDIR /app

COPY composer.json composer.lock ./

USER root

RUN composer install --no-dev --no-interaction --no-progress --no-scripts --optimize-autoloader

COPY . .

# Ensure all of our files are owned by the same user and group.

RUN chown -R application:application /app \

&& chmod 550 script.sh





CMD [ "./script.sh" ]
