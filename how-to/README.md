How to
======

A simple list with examples on `how to` I have trouble with.

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
