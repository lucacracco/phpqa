# Docker PHP Quality Tools for PHP/Drupal/Symfony project.

> The based image: [jakzal/phpqa](https://github.com/jakzal/phpqa).
> See [jakzal/toolbox](https://github.com/jakzal/toolbox) for other information.

```shell
docker run -it --rm -v $PWD:/project -w /project lucacracco/phpqa bash
```

You might want to tweak this command to your needs and create an alias for convenience:

```shell
alias phpqa='docker run -it --rm -v "$(pwd):/project" -w /project lucacracco/phpqa'
```

Add it to your `~/.bashrc` so it's defined every time you start a new terminal session.
Now the command becomes a lot simpler:

```shell
phpqa phpcs --standard=Drupal /file/to/example/directory
```

### Examples (for Drupal)

**phpcs**
```shell
phpqa phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md,yml /file/to/drupal/example_module
phpqa phpcs --standard=DrupalPractice --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md,yml /file/to/drupal/example_module
phpqa phpcs --standard=/tools/edgedesign-phpqa/drupal8/.phpcs.xml --report=summary -p /file/to/drupal/example_module
```

**phpcbf**
```shell    
phpqa phpcbf --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md,yml /file/to/drupal/example_module
```

**phpcpd**
```shell    
phpqa phpcpd --min-lines 5 --min-tokens 70 --log-pmd "reports/phpcpd.xml" /file/to/drupal/example_module
```

**phpmetrics**
```shell
phpqa phpmetrics --extensions=php,inc,module,install,test,profile,theme --report-html="reports/phpmetrics/" --report-violations="reports/phpmetrics.xml" /file/to/drupal/example_module
```

**composer-unused**
```shell
phpqa composer unused
````

**parallel-lint**
```shell
phpqa parallel-lint /file/to/example/directory
````

**pdpend**
```shell
phpqa pdepend --summary-xml=reports/pdepend.xml --jdepend-chart=reports/pdepend.svg --overview-pyramid=reports/pdepend-pyramid.svg /file/to/example/directory
```

### GitHub actions

The image can be used with GitHub actions.

```yaml
# .github/workflows/static-code-analysis.yml
name: Static code analysis

on: [pull_request]

jobs:
  static-code-analysis:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - name: PHPStan
        uses: docker://lucacracco/phpqa
        with:
          args: phpstan analyze src/ -l 1
      - name: PHP-CS-Fixer
        uses: docker://lucacracco/phpqa
        with:
          args: php-cs-fixer --dry-run --allow-risky=yes --no-interaction --ansi fix
```

### Bitbucket Pipelines

Here is an example configuration of a bitbucket pipeline using the phpqa image:

```yaml
# bitbucket-pipelines.yml
image: lucacracco/phpqa
pipelines:
  default:
    - step:
        name: Static analysis
        caches:
          - composer
        script:
          - composer install --no-scripts --no-progress
          - phpstan analyze src/ -l 1
          - php-cs-fixer --dry-run --allow-risky=yes --no-interaction --ansi fix
```

Unfortunately, bitbucket overrides the docker entrypoint so composer needs to be
explicitly invoked as in the above example.


## EdgedesignCZ PHPQA

Project: [https://github.com/EdgedesignCZ/phpqa/](https://github.com/EdgedesignCZ/phpqa/)
Documentation: [https://edgedesigncz.github.io/phpqa](https://edgedesigncz.github.io/phpqa)

### Example

`phpqa --config=phpqa` in [lucacracco/project-starterkit:drupal-8.x](https://github.com/lucacracco/project-starterkit)
