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
phpqa phpcs --standard=Drupal /file/to/example/directory
```


# Examples

**phpcs**

    phpqa phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md,yml /file/to/example/directory
    phpqa phpcs --standard=DrupalPractice --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md,yml /file/to/example/directory
    phpqa phpcs --standard=/phpqa/drupal8/.phpcs.xml --report=summary -p /file/to/example/directory

**phpcbf**
    
    phpqa phpcbf --standard=Drupal --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md,yml /file/to/example/directory

**phpcpd**
    
    phpqa phpcpd --min-lines 5 --min-tokens 70 --log-pmd "reports/phpcpd.xml" /file/to/example/directory

**phpmetrics**

    phpqa phpmetrics --extensions=php,inc,module,install,test,profile,theme --report-html="reports/phpmetrics/" --report-violations="reports/phpmetrics.xml" /file/to/example/directory

**composer-unused**

    phpqa composer unused

**parallel-lint**
    
    phpqa parallel-lint /file/to/example/directory

**pdpend**

    phpqa pdepend --summary-xml=reports/pdepend.xml --jdepend-chart=reports/pdepend.svg --overview-pyramid=reports/pdepend-pyramid.svg /file/to/example/directory

**phpa**
    
    phpqa phpa /file/to/example/directory