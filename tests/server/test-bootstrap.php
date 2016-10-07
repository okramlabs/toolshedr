<?php
$loader = require_once dirname(__DIR__, 2) . DIRECTORY_SEPARATOR . 'vendor' . DIRECTORY_SEPARATOR . 'server' . DIRECTORY_SEPARATOR . 'autoload.php';
$path = $loader->findFile('Composer\\Composer');
$loader->add('Composer\Test', dirname($path,3) . DIRECTORY_SEPARATOR .'tests');
