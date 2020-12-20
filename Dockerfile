FROM php:7.4-cli
LABEL Luca Cracco <lucacracco>

ENV TOOLS_LIBS="git graphviz make unzip nano zlib1g-dev libzip-dev libxslt-dev"
ENV TARGET_DIR="/phpqa"
ENV PATH="$PATH:$TARGET_DIR:$TARGET_DIR/.composer/vendor/bin"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME=$TARGET_DIR/.composer
ENV COMPOSER_BIN_DIR=$COMPOSER_HOME/vendor/bin

# Include composer.
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install extra software.
RUN apt-get update && apt-get install -y --no-install-recommends $TOOLS_LIBS && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-install zip xsl \
 && echo "date.timezone=Europe/Rome" >> $PHP_INI_DIR/php.ini \
 && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini \
 && rm -rf $COMPOSER_HOME/cache

# Install common tools.
# Extra bamarni/composer-bin-plugin.
RUN composer global require \
    phploc/phploc \
    sebastian/phpcpd \
    squizlabs/php_codesniffer \
    pdepend/pdepend \
    phpmd/phpmd \
    phpmetrics/phpmetrics \
    sensiolabs/security-checker \
    friendsofphp/php-cs-fixer \
    phpunit/phpunit \
    phpstan/phpstan \
    vimeo/psalm \
    php-parallel-lint/php-parallel-lint \
    php-parallel-lint/php-console-highlighter \
    phpstan/phpstan-deprecation-rules \
    behat/behat \
    icanhazstring/composer-unused \
    phpbench/phpbench \
    rskuipers/php-assumptions

# For Drupal.
RUN composer global require \
    dealerdirect/phpcodesniffer-composer-installer:^0.7.1 \
    drupal/coder:^8.3
#    mglaman/phpstan-drupal:^0.12.6 \
#    mglaman/phpstan-drupal-deprecations

#RUN phpcs --config-set installed_paths /tools/.composer/vendor-bin/phpcs/vendor/drupal/coder/coder_sniffer

# For Symfony
#RUN composer global require  \
#    phpstan/phpstan-symfony:0.12.10 \
#    psalm/plugin-symfony:2.0.2

ADD example-conf/drupal8 /phpqa/drupal8
ADD example-conf/symfony /phpqa/symfony

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
