FROM php:7.3-cli
LABEL Luca Cracco <lucacracco>

ENV PATH="$PATH:/tools/.composer/vendor/bin"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME=/tools/.composer

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install dependeciens for phpqa.
RUN apt-get update \
    && apt-get install -y --no-install-recommends git make unzip libxslt-dev \
    && docker-php-ext-install xsl

RUN echo "date.timezone=Europe/London" >> $PHP_INI_DIR/php.ini \
    && echo "memory_limit=-1" >> $PHP_INI_DIR/php.ini

# Install https://github.com/AlDanial/cloc.
RUN apt-get install cloc -y --no-install-recommends

# Install tools.
# Install https://github.com/EdgedesignCZ/phpqa.
# Suggestions tools (see https://github.com/EdgedesignCZ/phpqa/blob/master/bin/suggested-tools.sh)
# TODO: replace jakub-onderka/php-parallel-lint with php-parallel-lint/php-parallel-lint.
# TODO: replace jakub-onderka/php-console-highlighter with php-parallel-lint/php-console-highlighter.
# Fixed for compatibility with mglaman/phpstan-drupal.
# Install https://github.com/Dealerdirect/phpcodesniffer-composer-installer.
# Install https://git.drupalcode.org/project/coder.
# Install https://github.com/mglaman/phpstan-drupal.
# Install https://github.com/phpstan/phpstan-deprecation-rules.
# Install https://github.com/phpstan/phpstan-symfony.
# Install https://github.com/psalm/psalm-plugin-symfony.
RUN composer global require  \
    edgedesign/phpqa:^1.23 \
    jakub-onderka/php-parallel-lint:^1.0 \
    jakub-onderka/php-console-highlighter:^0.4.0 \
    phpstan/phpstan:0.12.42 \
    nette/neon:^3.2 \
    vimeo/psalm:^4.3 \
    sensiolabs/security-checker:^6.0 \
    pdepend/pdepend:^2.8 \
    phploc/phploc:^4.0 \
    phpmd/phpmd:^2.9 \
    phpmetrics/phpmetrics:^2.7 \
    sebastian/phpcpd:^4.1 \
    dealerdirect/phpcodesniffer-composer-installer:^0.7.1 \
    drupal/coder:^8.3 \
    mglaman/phpstan-drupal:^0.12.6 \
    phpstan/phpstan-deprecation-rules:~0.12.0 \
    phpstan/phpstan-symfony:0.12.10 \
    psalm/plugin-symfony:2.0.2

RUN composer global clearcache

RUN ln -s /tmp/vendor/bin/* /usr/local/bin

ADD example-conf/drupal8 /phpqa/drupal8
ADD example-conf/symfony /phpqa/symfony

ENTRYPOINT ["docker-php-entrypoint"]
