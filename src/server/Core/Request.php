<?php
/**
 * ******************************************************************
 * Created by   Marko Kungla on 09 Oct 2016
 * @package     toolshedr
 * Encoding     UTF-8
 * File         Request.php
 * Code format  PSR-2 and 12
 * *******************************************************************/

namespace Toolshedr\Core;


class Request
{
    private $api_key;

    /**
     * Request constructor.
     */
    public function __construct()
    {
        $this->api_keys = array();

    }

    /**
     * @inheritdoc
     * 
     * @param string $api_key
     */
    public function setApiKey(string $api_key)
    {
        array_push($this->api_keys, $api_key);
    }

    /**
     * Authenticate the request
     * 
     * @return bool
     */
    public function authenticate()
    {
        return $this->checkApiKey();
        
    }

    /**
     * Is OPTIONS request
     * 
     * @return bool
     */
    public function isOptionRequest()
    {
        return $_SERVER['REQUEST_METHOD'] === 'OPTIONS';
    }

    /**
     * 
     * @param string $api_key
     * @return bool
     */
    public function isValidApiKey(string $api_key)
    {
        return in_array($api_key, $this->api_keys);
    }
    
    /**
     * Is recieved API KEY valid
     * 
     * @return bool
     */
    private function checkApiKey()
    {
        return isset($_SERVER['HTTP_X_TOOLSHEDR_API_KEY']) && $this->isValidApiKey($api_key);
    }
}
