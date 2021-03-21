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

## Install EdgedesignCZ/PHPQA.
RUN composer global require edgedesign/phpqa --update-no-dev

# Suggestions tools for EdgedesignCZ/PHPQA
RUN composer global require \
    friendsofphp/php-cs-fixer \
    php-parallel-lint/php-parallel-lint \
    enlightn/security-checker \
    phpstan/phpstan \
    nette/neon \
    phpunit/phpunit

# Add extra libraries.
RUN composer global require \
    friendsofphp/php-cs-fixer \
    vimeo/psalm \
    phpstan/phpstan-deprecation-rules \
    psalm/plugin-symfony \
    phpstan/phpstan-symfony \
    drupal/coder

# The library requires symfony/yaml ~3.4.5|^4.2, we force the downgrades.
RUN composer global require \
    mglaman/phpstan-drupal --with-all-dependencies

# Install https://github.com/Dealerdirect/phpcodesniffer-composer-installer.
# I don't know but works for edgedesign/phpqa.
RUN composer global require dealerdirect/phpcodesniffer-composer-installer

# I don't know but works for global phpcs.
RUN phpcs --config-set installed_paths "$(phpcs --config-show|grep installed_paths|awk '{ print $2 }'),/tools/.composer/vendor/drupal/coder/coder_sniffer,/tools/.composer/vendor/sirbrillig/phpcs-variable-analysis/VariableAnalysis"
