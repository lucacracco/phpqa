# Docker PHP Quality Tools for Drupal8/Symfony project.

Docker image for running:

* [PHP QA Tools](https://edgedesigncz.github.io/phpqa/)
* [PHPloc](https://github.com/sebastianbergmann/phploc)
* [Count Lines of Code (cloc)](https://github.com/AlDanial/cloc)

# Examples

**phpqa**

    docker run --rm -u $UID -v $PWD:/app lucacracco/phpqa-drupal phpqa --report --ignoredDirs vendor,node_modules --analyzedDirs web/modules/custom

**phpqa with custom configurations**

    docker run --rm -u $UID -v $PWD:/app lucacracco/phpqa-drupal phpqa --config=folder/with/configurations

**phpqa with custom configurations example for Drupal8**

    docker run --rm -u $UID -v $PWD:/app lucacracco/phpqa-drupal phpqa --config=/phpqa/drupal8

An example configuration files will found in [default-config](default-config).

**cloc**

    docker run --rm -u $UID -v $PWD:/app lucacracco/phpqa-drupal cloc web/modules/custom
