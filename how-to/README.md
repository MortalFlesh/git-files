How to
======

A simple list with examples on `how to` I have trouble with.

## Brew
```sh
`brew update`                   # `fetch` current packages from github
`brew outdated`                 # show what is available to upgrade
`brew upgrade pcgk_1 pckg_2`    # upgrade packages
```

## PHP

### Install and Register PHP extension on ubuntu
- download extension somehow
    - PECL
        - `pecl install {extension}` _will simply download extension library - `{extension}.so`_
        - `ll /usr/lib/php/20160303/` _or similar_
    - manual
        - clone repository and build it
            ```bash
            $ git clone ...
            $ cd {extension-repo-dir}
            $ phpize
            $ ./configure
            $ sudo make install
            ```
- register
    - create ini file, which loads extension
        - `sudo vim /etc/php/7.1/mods-available/{extension}.ini`
        ```
        // {extension.ini}
        ; configuration for php {extension} module
        ; priority=20
        extension={extension}.so
        ```
    - link ini file to php `conf.d`
        - **cli**
            ```
            cd /etc/php/7.1/cli/conf.d/
            sudo ln -s /etc/php/7.1/mods-available/{extension}.ini 20-{extension}.ini
            ```
        - **apache**
            ```
            cd /etc/php/7.1/apache2/conf.d/
            sudo ln -s /etc/php/7.1/mods-available/{extension}.ini 20-{extension}.ini
            ```

### Provide truth table in PHPUnit
- inspired here: https://stackoverflow.com/questions/9291987/outputting-a-truth-table-in-php

```php
/**
 * @dataProvider providePossibility
 */
public function testShouldCheckPossibility(bool $a, bool $b, bool $c, bool $d): void {
    echo implode(' | ', [
        $a ? 'Y' : 'N',
        $b ? 'Y' : 'N',
        $c ? 'Y' : 'N',
        $d ? 'Y' : 'N',
    ]);

    // perform test ...
}

public function providePossibility(): iterable
{
    $options = ['a', 'b', 'c', 'd'];

    $nbBooleans = count($options);

    $nbIterations = pow(2, $nbBooleans);
    for ($i = 0; $i < $nbIterations; $i++) {
        $case = [];
        for ($iBit = 0; $iBit < $nbBooleans; $iBit++) {
            $case[] = ($i & pow(2, $iBit)) !== 0 ? true : false;
        }

        yield $case;
    }
}
```
