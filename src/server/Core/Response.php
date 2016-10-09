<?php
/**
 * ******************************************************************
 * Created by   Marko Kungla on 09 Oct 2016
 * @package     toolshedr
 * Encoding     UTF-8
 * File         Response.php
 * Code format  PSR-2 and 12
 * *******************************************************************/

namespace Toolshedr\Core;

use \Toolshedr\Interfaces\ResponseDataInterface;
use \Toolshedr\Core\{
    Headers,
    Request
};

class Response
{
    /**
     * @var int Response status code
     */
    private $code;

    /**
     * @var string status message
     */
    private $message;

    /**
     * @var ResponseDataInterface data to be returned
     */
    private $data;

    /**
     * Response constructor.
     */
    public function __construct()
    {
        $this->code = 200;
        $this->message = "OK";
    }

    /**
     * Set status code
     *
     * @param int $code
     */
    public function setCode(int $code)
    {
        $this->code = $code;
    }

    /**
     * Set response message
     *
     * @param string $message
     */
    public function setMessage(string $message)
    {
        $this->message = $message;
    }

    /**
     * Set response data object
     *
     * @param ResponseDataInterface $data
     */
    public function setData(ResponseDataInterface $data)
    {
        $this->data = $data;
    }

    /**
     * Handle Options request
     *
     * @param Headers $headers
     */
    public function options(Headers $headers)
    {
        if ($headers->containsRequiredHeaders()) {
            $this->setCode(202);
            $this->setMessage('Good to continue!!!');
            $headers->setStatusCode(202);
        } else {
            $this->setCode(400);
            $this->setMessage('Bad Request!');
            $headers->setStatusCode(400);
        }

    }

    /**
     * Handle requests
     *
     * @param Request $request
     * @param Header $headers
     */
    public function handle(Request &$request, Headers $headers)
    {
        if ($request->authenticate()) {
            // go go go go
        } else {
            $this->setCode(401);
            $this->setMessage('Unauthorized!');
            $headers->setStatusCode(401);
        }


    }

    /**
     * Return Output object
     *
     * @return \stdClass
     */
    public function output()
    {
        $output = new \stdClass();
        $output->code = $this->code;
        $output->message = $this->message;

        if (is_object($this->data)) {
            $output->data = $this->data;
        }

        return $output;
    }
}
