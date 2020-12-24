FROM php:7.4-cli
LABEL Luca Cracco <lucacracco>

ENV TOOLS_LIBS="git graphviz make unzip nano zlib1g-dev libzip-dev libxslt-dev"
ENV TARGET_DIR="/tools"
ENV PATH="$PATH:$TARGET_DIR:$TARGET_DIR/vendor/bin"
ENV COMPOSER_ALLOW_SUPERUSER 1
#ENV COMPOSER_HOME=$TARGET_DIR/.composer
#ENV COMPOSER_BIN_DIR=$COMPOSER_HOME/vendor/bin/

# Include composer.
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install extra software.
RUN apt-get update && apt-get install -y --no-install-recommends $TOOLS_LIBS && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-install zip xsl \
 && echo "date.timezone=Europe/Rome" >> $PHP_INI_DIR/php.ini \
 && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini \
 && rm -rf $COMPOSER_HOME/cache

# Install projects.
COPY composer.json $TARGET_DIR/composer.json
RUN composer install --no-progress --working-dir=$TARGET_DIR

COPY composer.phpqa.json $TARGET_DIR/phpqa/composer.json
RUN composer install --no-progress --working-dir=$TARGET_DIR/phpqa

# Set the alias for PHPQA.
RUN echo 'alias phpqa="$TARGET_DIR/phpqa/vendor/bin/phpqa"' >> ~/.bashrc

## For Drupal.
#RUN composer global require \
#    #mglaman/phpstan-drupal:^0.12.7
#    #mglaman/phpstan-drupal-deprecations

## For Symfony
#RUN composer global require  \
#    phpstan/phpstan-symfony:0.12.10 \
#    psalm/plugin-symfony:2.0.2

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
