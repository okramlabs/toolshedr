<?php
error_reporting(-1);
$yaml = '/swagger-web/docs/api-definitions.yaml';

if(file_exists($yaml) && $_SERVER['REQUEST_METHOD'] === 'GET') {
    header('text/vnd.yaml');
    print file_get_contents($yaml);
} elseif($_SERVER['REQUEST_METHOD'] === 'PUT') {

    $incoming = fopen("php://input", "r");
    $fp = fopen($yaml, "w");

    while ($data = fread($incoming, 1024))
        fwrite($fp, $data);

    fclose($fp);
    fclose($incoming);

} else {
    http_response_code(400);
    print "API definitions YAML file probably is not mounted";
}

exit(0);
