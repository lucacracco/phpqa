# Docker PHP Quality Tools for Drupal8/Symfony project.

```shell
docker run -it --rm -u $UID -v $PWD:/project -w /project lucacracco/phpqa bash
```

You might want to tweak this command to your needs and create an alias for convenience:

```shell
alias phpqa='docker run --init -it --rm -v "$(pwd):/project" -w /project lucacracco/phpqa'
```

Add it to your `~/.bashrc` so it's defined every time you start a new terminal session.
Now the command becomes a lot simpler:

```shell
phpqa phpcs --standard=Drupal /file/to/drupal/example_module
```


# Examples

**phpcs**

    phpqa phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md,yml /file/to/drupal/example_module
    phpqa phpcs --standard=DrupalPractice --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md,yml /file/to/drupal/example_module
    phpqa phpcs --standard=/phpqa/drupal8/.phpcs.xml --report=summary -p /file/to/drupal/example_module

**phpcbf**
    
    phpqa phpcbf --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md,yml /file/to/drupal/example_module

**phpcpd**
    
    phpqa phpcpd --min-lines 5 --min-tokens 70 --log-pmd "reports/phpcpd.xml" /file/to/drupal/example_module

**phpmetrics**

    phpqa phpmetrics --extensions=php,inc,module,install,test,profile,theme --report-html="reports/phpmetrics/" --report-violations="reports/phpmetrics.xml" /file/to/drupal/example_module
