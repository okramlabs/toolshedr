<?php
namespace Toolshedr;
/**
 * Class Autoload
 * @package Toolshedr
 */
final class Autoload
{
    private $root_path;

    /**
     * Toolshedr constructor.
     */
    public function register()
    {
        $this->root_path = dirname(__FILE__);
        spl_autoload_register(array($this, 'classLoader'));
    }

    /**
     * The Autoloader
     *
     * @param bool $class
     */
    public function classLoader($class = false)
    {
        $relative_path = preg_replace(array(
            '/Toolshedr/',
            '/\\\\/'
        ), array(
            '',
            DIRECTORY_SEPARATOR
        ), $class);
        
        $class_file = $this->root_path.$relative_path.'.php';

        if (file_exists($class_file)) {
            require_once $class_file;
        }
    }
}
