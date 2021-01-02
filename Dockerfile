FROM php:7.4-cli
LABEL Luca Cracco <lucacracco>

ENV TOOLS_LIBS="git graphviz make unzip nano zlib1g-dev libzip-dev libxslt-dev"
ENV TARGET_DIR="/tools"
ENV PATH="$PATH:$TARGET_DIR:$TARGET_DIR/vendor/bin"
ENV COMPOSER_ALLOW_SUPERUSER 1

# Include composer.
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install extra software.
RUN apt-get update && apt-get install -y --no-install-recommends $TOOLS_LIBS && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-install zip xsl \
 && echo "date.timezone=Europe/Rome" >> $PHP_INI_DIR/php.ini \
 && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini \
 && rm -rf $COMPOSER_HOME/cache

# Only for composer:1.
#RUN composer global require hirak/prestissimo

# Install phpqa tools projects.
COPY composer.json $TARGET_DIR/composer.json
RUN composer install --no-progress --working-dir=$TARGET_DIR

# Install EdgedesignCZ/PHPQA old project.
COPY edgedesign-phpqa $TARGET_DIR/edgedesign-phpqa
RUN composer install --no-progress --working-dir=$TARGET_DIR/edgedesign-phpqa

# Set the alias for EdgedesignCZ PHPQA.
RUN echo 'alias phpqa="$TARGET_DIR/edgedesign-phpqa/vendor/bin/phpqa"' >> ~/.bashrc

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
