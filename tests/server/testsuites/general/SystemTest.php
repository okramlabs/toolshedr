<?php

use \Toolshedr\Server;

class SystemTest extends PHPUnit_Framework_TestCase
{
    protected function setUp()
    {
        $this->toolshedr = new Server();   
    }
    
    public function test_php_version_to_low()
    {
        $this->assertGreaterThanOrEqual(70000, PHP_VERSION_ID, "No point to test it with PHP version less than PHP version 7.0!");
    }
    
    public function test_server_instance()
    {
        $this->assertInstanceOf('\Toolshedr\Server', $this->toolshedr);
    }
}
