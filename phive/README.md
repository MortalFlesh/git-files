Phive
=====

## Install Phive
See: https://phar.io/

```bash
wget -O phive.phar https://phar.io/releases/phive.phar
wget -O phive.phar.asc https://phar.io/releases/phive.phar.asc
gpg --keyserver hkps.pool.sks-keyservers.net --recv-keys 0x9D8A98B29B2D5D79
gpg --verify phive.phar.asc phive.phar
chmod +x phive.phar
sudo mv phive.phar ~/bin/phive
phive --version
```

## Install dependencies
```bash
brew install re2c
brew install gpgme
pecl install gnupg
php -i | grep gpg
```

## Install package by Phive
```bash
phive install composer-require-checker
```
