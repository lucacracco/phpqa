FROM composer:latest
MAINTAINER Luca Cracco <lucacracco>

# Install dependeciens for phpqa.
RUN apk add --update libxslt-dev && \
    docker-php-ext-install xsl

# Install https://github.com/AlDanial/cloc.
RUN apk add cloc --update

# Install https://github.com/hirak/prestissimo.
RUN composer global require hirak/prestissimo --update-no-dev

# Install tools.
RUN composer global --update-no-dev require  \

    # Install https://github.com/EdgedesignCZ/phpqa.
    edgedesign/phpqa \

    # Suggestions tools (see https://github.com/EdgedesignCZ/phpqa/blob/master/bin/suggested-tools.sh)
    jakub-onderka/php-parallel-lint \
    jakub-onderka/php-console-highlighter \
    phpstan/phpstan \
    nette/neon \
    friendsofphp/php-cs-fixer:~2.2 \
    vimeo/psalm \
    sensiolabs/security-checker \

    # Install https://github.com/Dealerdirect/phpcodesniffer-composer-installer.
    dealerdirect/phpcodesniffer-composer-installer \

    # Install https://git.drupalcode.org/project/coder.
    drupal/coder:^8.3 \

    # Install https://github.com/mglaman/phpstan-drupal.
    mglaman/phpstan-drupal \

    # Install https://github.com/phpstan/phpstan-deprecation-rules.
    phpstan/phpstan-deprecation-rules \

    # Install https://github.com/phpstan/phpstan-symfony.
    phpstan/phpstan-symfony \

    # Install https://github.com/psalm/psalm-plugin-symfony.
    psalm/plugin-symfony

RUN composer global clearcache

RUN ln -s /tmp/vendor/bin/* /usr/local/bin

ADD example-conf/drupal8 /phpqa/drupal8
ADD example-conf/symfony /phpqa/symfony

ENTRYPOINT ["docker-php-entrypoint"]
