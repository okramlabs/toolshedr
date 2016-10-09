import {Server} from './server';

class Toolshedr {
  greeting() {
    console.info("Name:    " + this.getName());
    console.info("Version: " + this.getVersion());
  }

  /**
   * Get Application name
   *
   * @returns string
   */
  getName() {
    return this.name;
  }

  /**
   * Get Toolshedr Server version
   *
   * @returns {string|*}
   */
  getVersion() {
    return this.version;
  }
  
  /**
   * Connect to Server API
   */
  connect() {

    this.Server = new Server(this.Config.isDev(), this.Config.api_key);
    
    this.version = (this.Config.isDev()) ? this.version  + '-devel' : this.version;
    this.greeting();

    this.Server.setApiUrl(this.Config.getServerUrl());
    
    let self = this;

    this.Server.isAlive().then(function(status){
      if(!status) {
        self.Renderer.offline();
        console.info("Server URL: " + self.Config.getServerUrl() + " [FAILED]");
      } else {
        self.Renderer.ok();
        console.info("Server URL: " + self.Config.getServerUrl() + " [OK]");
      }
      // Render UI
      self.Renderer.render();
    });
  }
}
export default (new Toolshedr());
