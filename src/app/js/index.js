import {version, name} from '../../../package.json';
import {Config} from './core/config';
import {Renderer} from './core/renderer';

/**
 * Toolshedr UI
 */
class Toolshedr{
  constructor(){
    // Load Classes
    this.Config = new Config();
    this.Renderer = new Renderer();

    this.name = name;
    this.version = (this.Config.isDev()) ? version + '-devel': version;
    
    this.greeting();
    
  }
  greeting(){
    console.info("Name:    " + this.getName());
    console.info("Version: " + this.getVersion());
  }
  getName(){
    return this.name;
  }
  getVersion(){
    return this.version;
  }
  render(){
    console.info("Server URL: " + this.Config.getServerUrl());
    this.Renderer.render();
  }
}


module.exports = window.TOOLSHEDR = new Toolshedr();
