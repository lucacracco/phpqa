FROM jakzal/phpqa:php7.4
LABEL Luca Cracco <lucacracco>

ENV BUILD_DEPS="build-essential autoconf file g++ gcc libc-dev pkg-config"
ENV TOOL_DEPS="nano"
ENV LIB_DEPS="libxslt-dev"

# Install extra software.
RUN apt-get update && apt-get install -y --no-install-recommends $TOOL_DEPS $BUILD_DEPS $LIB_DEPS && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install xsl
RUN echo "date.timezone=Europe/Rome" >> $PHP_INI_DIR/php.ini
RUN echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini
RUN apt-get purge -y --auto-remove $BUILD_DEPS

# Add extra libraries.
# TODO remove 'psalm/plugin-symfony' after close the issue https://github.com/jakzal/toolbox/issues/235.
RUN composer global require drupal/coder:^8.3 psalm/plugin-symfony:^2.1

# Install code sniffer of Drupal.
RUN phpcs --config-set installed_paths "$(phpcs --config-show|grep installed_paths|awk '{ print $2 }'),/tools/.composer/vendor/drupal/coder/coder_sniffer,/tools/.composer/vendor/sirbrillig/phpcs-variable-analysis/VariableAnalysis"

# Install EdgedesignCZ/PHPQA tool.
COPY edgedesign-phpqa $TOOLBOX_TARGET_DIR/edgedesign-phpqa
RUN composer install --no-progress --working-dir=$TOOLBOX_TARGET_DIR/edgedesign-phpqa

# Set the alias for EdgedesignCZ PHPQA.
RUN echo 'alias phpqa="$TOOLBOX_TARGET_DIR/edgedesign-phpqa/vendor/bin/phpqa"' >> ~/.bashrc
