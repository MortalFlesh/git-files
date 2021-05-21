Snippets for upgrading to php74
===============================

## Replace property short type
```
Find: /\*\* @var ([a-zA-Z]*?) \*/\n(.*?) \$(.*?);
Replace: $2 $1 \$$3;
```

```php
    /** @var \Monolog\Logger */
    protected $logger;
```

## Replace property type
```
Find: \/\*\*\n\s+\* @var ([a-zA-Z\\]*?)\n\s+\*\/\n(.*?) \$(.*?);
Replace: $2 $1 \$$3;
```

```php
    /**
     * @var \Monolog\Logger
     */
    protected $logger;
```
