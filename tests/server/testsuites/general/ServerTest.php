<?php

use \Toolshedr\Server;

class ServerTest extends PHPUnit_Framework_TestCase
{
    protected function setUp()
    {
        $this->toolshedr = new Server();
    }
    
    public function test_server_instance()
    {
        $this->assertFalse($this->toolshedr->isWhitelisted('http://mydomain.org'));
        $this->toolshedr->whitelist('http://mydomain.org');
        $this->assertTrue($this->toolshedr->isWhitelisted('http://mydomain.org'));
    }
    
    public function test_apy_key()
    {
        $this->assertFalse($this->toolshedr->isValidApiKey('123456789'));
        $this->toolshedr->apikey('123456789');
        $this->assertTrue($this->toolshedr->isValidApiKey('123456789'));
    }
}
