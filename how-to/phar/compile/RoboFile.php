<?php declare(strict_types=1);

require_once __DIR__ . '/vendor/autoload.php';

use Robo\Common\ResourceExistenceChecker;
use Robo\Symfony\ConsoleIO;
use Robo\Tasks;

class RoboFile extends Tasks
{
    use ResourceExistenceChecker;

    public function __construct()
    {
    }

    public function buildPhar(ConsoleIO $io, array $options = []): int
    {
        $this->stopOnFail();

        $io->title('Build phar');

        $sourceDir = __DIR__ . '/..';

        $temporaryBuildDir = __DIR__ . '/tmp';
        $buildRootDir = $temporaryBuildDir . '/app';

        $pharFile = 'coding-standards.phar';
        $pharEntryPoint = '/vendor/bin/ecs';
        $pharFilePath = __DIR__ . '/' . $pharFile;

        //
        // Prepare temp dir with all require files
        //
        if ($this->isDir($temporaryBuildDir)) {
            $this->_deleteDir($temporaryBuildDir);
        }

        $this->taskFilesystemStack()
            ->mkdir($buildRootDir)
            ->run();

        $dirs = ['src', 'vendor'];
        foreach ($dirs as $dir) {
            $this->_copyDir($sourceDir . '/' . $dir, $buildRootDir . '/' . $dir);
        }

        $files = [
            'composer.json',
            'composer.lock',
            'LICENCE.md',
            'README.md',
        ];
        foreach($files as $file) {
            $fileToCopy = $sourceDir . '/' . $file;

            if ($this->isFile($fileToCopy)) {
                $this->_copy($fileToCopy, $buildRootDir . '/' . $file);
            }
        }

        //
        // Make phar out of a temp dir
        //
        if ($this->isFile($pharFilePath)) {
            $this->_remove($pharFilePath);
        }

        if ($this->isFile($pharFilePath . '.gz')) {
            $this->_remove($pharFilePath . '.gz');
        }

        $this->taskExec('php --define phar.readonly=0 compile.php')
            ->dir(__DIR__)
            ->args($pharFile, $pharEntryPoint)
            ->run();

        $this->taskFilesystemStack()
            ->chmod($pharFilePath, 0770) // writable by user
            ->run();

        //
        // Clean temp dir
        //
        $this->_deleteDir($temporaryBuildDir);

        $io->newLine();
        $io->success('Done');

        return 0;
    }
}
