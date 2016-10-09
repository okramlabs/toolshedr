<?php

namespace Toolshedr;

use Toolshedr\Core\{
    Headers,
    Response,
    Request
};

final class Server
{
    /**
     * @var Headers 
     */
    private $headers;

    /**
     * @var Request
     */
    private $request;

    /**
     * @var Response
     */
    private $response;

    /**
     * Server constructor.
     */
    public function __construct()
    {
        $this->headers = new Headers();
        $this->request = new Request();
        $this->response = new Response();
    }

    /**
     * Whitelist your UI
     *
     * @param $origin
     * @return void
     */
    public function whitelist(string $origin)
    {
        $this->headers->addToWhitelist($origin);
    }

    /**
     * Set API KEY
     * 
     * @param string $api_key
     * @return void
     */
    public function setApiKey(string $api_key)
    {
        $this->request->setApiKey($api_key);
    }
    
    /**
     * Run the server
     *
     * @return void
     */
    public function run()
    {
        /**
         * Check are request headers ok
         */
        if ($this->headers->areOk() && !$this->request->isOptionRequest()) {
            $this->response->handle($this->request, $this->headers);
        } else {
            $this->response->options($this->headers);
        }

        $this->headers->send();
        
        print json_encode($this->response->output(), JSON_PRETTY_PRINT);
        
        // We are done
        exit();
    }
}
