FROM composer:2
LABEL Luca Cracco <lucacracco>

# Install dependeciens for phpqa.
RUN apk add --update libxslt-dev && \
    docker-php-ext-install xsl

# Install https://github.com/AlDanial/cloc.
RUN apk add cloc --update

# Install tools.
RUN composer global require  \

    # Install https://github.com/EdgedesignCZ/phpqa.
    edgedesign/phpqa:1.23.3 \

    # Suggestions tools (see https://github.com/EdgedesignCZ/phpqa/blob/master/bin/suggested-tools.sh)

    # TODO: change with php-parallel-lint/php-parallel-lint.
    jakub-onderka/php-parallel-lint:1.0.0 \
    # TODO: change with php-parallel-lint/php-console-highlighter.
    jakub-onderka/php-console-highlighter:0.4 \
    # Fixed for compatibility with mglaman/phpstan-drupal.
    phpstan/phpstan:0.12.26 \
    nette/neon:3.2.1 \
    friendsofphp/php-cs-fixer:2.16.7 \
    vimeo/psalm:4.2.1 \
    sensiolabs/security-checker:6.0.3 \

    sebastian/phpcpd:4.1.0 \

    # Install https://github.com/Dealerdirect/phpcodesniffer-composer-installer.
    dealerdirect/phpcodesniffer-composer-installer:0.7.1 \

    # Install https://git.drupalcode.org/project/coder.
    drupal/coder:8.3.11 \

    # Install https://github.com/mglaman/phpstan-drupal.
    mglaman/phpstan-drupal:0.12.6 \

    # Install https://github.com/phpstan/phpstan-deprecation-rules.
    phpstan/phpstan-deprecation-rules:0.12.5 \

    # Install https://github.com/phpstan/phpstan-symfony.
    phpstan/phpstan-symfony:0.12.10 \

    # Install https://github.com/psalm/psalm-plugin-symfony.
    psalm/plugin-symfony:2.0.2

RUN composer global clearcache

RUN ln -s /tmp/vendor/bin/* /usr/local/bin

ADD example-conf/drupal8 /phpqa/drupal8
ADD example-conf/symfony /phpqa/symfony

ENTRYPOINT ["docker-php-entrypoint"]
