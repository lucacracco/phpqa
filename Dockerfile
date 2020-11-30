FROM composer:1
LABEL Luca Cracco <lucacracco>

# Install dependeciens for phpqa.
RUN apk add --update libxslt-dev && \
    docker-php-ext-install xsl

# Install https://github.com/AlDanial/cloc.
RUN apk add cloc --update

# Install https://github.com/hirak/prestissimo.
RUN composer global require hirak/prestissimo --update-no-dev

# Install tools.
RUN composer global require  \

    # Install https://github.com/EdgedesignCZ/phpqa.
    edgedesign/phpqa:v1.23.3 \

    # Suggestions tools (see https://github.com/EdgedesignCZ/phpqa/blob/master/bin/suggested-tools.sh)
    jakub-onderka/php-parallel-lint:v1.0.0 \
    jakub-onderka/php-console-highlighter:v0.4 \
    phpstan/phpstan:0.12.26 \
    nette/neon:v3.2.1 \
    friendsofphp/php-cs-fixer:v2.16.7 \
    vimeo/psalm:4.2.1 \
    sensiolabs/security-checker:6.0 \

    # Install https://github.com/Dealerdirect/phpcodesniffer-composer-installer.
    dealerdirect/phpcodesniffer-composer-installer:v0.7.0 \

    # Install https://git.drupalcode.org/project/coder.
    drupal/coder:8.3.11 \

    # Install https://github.com/mglaman/phpstan-drupal.
    mglaman/phpstan-drupal:0.12.6 \

    # Install https://github.com/phpstan/phpstan-deprecation-rules.
    phpstan/phpstan-deprecation-rules:0.12.5 \

    # Install https://github.com/phpstan/phpstan-symfony.
    phpstan/phpstan-symfony:0.12.10 \

    # Install https://github.com/psalm/psalm-plugin-symfony.
    psalm/plugin-symfony:v2.0.2

RUN composer global clearcache

RUN ln -s /tmp/vendor/bin/* /usr/local/bin

ADD example-conf/drupal8 /phpqa/drupal8
ADD example-conf/symfony /phpqa/symfony

ENTRYPOINT ["docker-php-entrypoint"]
