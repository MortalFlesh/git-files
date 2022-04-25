<?php declare(strict_types=1);

if (count($argv) < 3) {
    throw new \RuntimeException('Compile requires 2 arguments: phar name and entry point');
}

[$_, $pharFile, $pharEntryPoint] = $argv;

if (ini_get('phar.readonly')) {
    throw new \RuntimeException('Phar is readonly.');
}

$currentDir = __DIR__;
$appDir = $currentDir . '/tmp/app';

$pharFilePath = $currentDir . '/' . $pharFile;

// create phar
$phar = new Phar($pharFile);

// start buffering. Mandatory to modify stub to add shebang
$phar->startBuffering();

// Create the default stub from main.php entrypoint
$defaultStub = Phar::createDefaultStub($pharEntryPoint);

// Add the rest of the apps files
$phar->buildFromDirectory($appDir);

// Customize the stub to add the shebang
$stub = "#!/usr/bin/env php \n" . $defaultStub;

// Add the stub
$phar->setStub($stub);

$phar->stopBuffering();

// plus - compressing it into gzip
$phar->compressFiles(Phar::GZ);
