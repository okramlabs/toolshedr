<?php

error_reporting(-1);
ini_set("display_errors", 1); 

require_once dirname(__DIR__) . DIRECTORY_SEPARATOR . 'vendor' . DIRECTORY_SEPARATOR . 'server' . DIRECTORY_SEPARATOR .
    'autoload.php';

$toolshedr = new Toolshedr\Server();
$toolshedr->whitelist('http://127.0.0.1:9000');
$toolshedr->apikey(sha1('API-KEY-Which-UI-has-to-use'));
$toolshedr->run();
