FROM ghcr.io/qlicks/magento-php-7.3:latest

LABEL "repository"="http://github.com/IonBazan/composer-diff"
LABEL "homepage"="http://github.com/IonBazan"
LABEL "maintainer"="Ion Bazan <ion.bazan@gmail.com>"
LABEL "description"="Compares composer.lock changes and generates Markdown report so you can use it in PR description."
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV COMPOSER_VERSION 2.1.5

RUN composer global require ion-bazan/composer-diff

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

