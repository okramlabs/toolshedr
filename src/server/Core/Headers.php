<?php
/**
 * ******************************************************************
 * Created by   Marko Kungla on 09 Oct 2016
 * @package     toolshedr
 * Encoding     UTF-8
 * File         Headers.php
 * Code format  PSR-2 and 12
 * *******************************************************************/

namespace Toolshedr\Core;


class Headers
{
    /**
     * Domains allowed to connect
     * @var array
     */
    private $whitlisted = array();

    private $http_response_code = 200;
    /**
     * Headers constructor.
     */
    public function __construct()
    {
        $this->addToWhitelist('localhost');
    }
    
    /**
     * Whitelist your UI
     *
     * @param $origin
     * @return void
     */
    public function addToWhitelist(string $origin)
    {
        array_push($this->whitlisted, $origin);
    }

    /**
     * Send all headers
     *
     * @return void
     */
    public function areOk()
    {
        header('Access-Control-Allow-Headers: X-Toolshedr-API-KEY');
        header('X-Powered-By: Toolshedr Server');
        header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');

        return $this->checkOrigin();
    }

    /**
     * Is Domain whitelisted
     *
     * @param string $origin
     * @return bool
     */
    public function isWhitelisted(string $origin)
    {
        return in_array($origin, $this->whitlisted);
    }
    
    /**
     * Check request origin
     *
     * @return bool
     */
    private function checkOrigin()
    {
        if (!empty($_SERVER['HTTP_ORIGIN']) && $this->isWhitelisted($_SERVER['HTTP_ORIGIN'])) {
            header(sprintf('Access-Control-Allow-Origin: %s', $_SERVER['HTTP_ORIGIN']));
            return true;
        } else {
            $this->setStatusCode(403);
            header(sprintf('Access-Control-Allow-Origin: %s', $_SERVER['HTTP_HOST']));
            return false;
        }
    }

    /**
     * Get White listed domains
     * 
     * @return array
     */
    public function getWhitelist()
    {
        return $this->whitlisted;    
    }
    
    /**
     * Set HTTP Status Code
     * 
     * @param int $code
     */
    public function setStatusCode(int $code)
    {
        // Do not allow overwrite previous code other than 200
        if($this->http_response_code !== 200) return;

        $this->http_response_code = $code;
       
    }

    /**
     * Check does request have required headers
     * 
     * @return bool
     */
    public function containsRequiredHeaders()
    {
        return !empty($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']) && 
            $_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS'] === 'x-toolshedr-api-key';
    }

    /**
     * Send remaining headers
     * 
     * @return void
     */
    public function send()
    {
        http_response_code($this->http_response_code);
        $this->setContentType('application/json');
    }

    /**
     * Set output content type
     * 
     * @param string $content_type
     */
    public function setContentType($content_type = 'application/json')
    {
        header(sprintf('Content-Type: %s', $content_type));
    }
}
