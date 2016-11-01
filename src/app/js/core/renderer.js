'use strict';

/**
 * Toolshedr Config
 */
class Renderer {
  constructor(){
    this.current_page = 'home';
    this.page = '<div id="devel">' +
      'Toolshedr<br>' +
      '<em>A tool you need to plan and host efficient workshops</em>' +
      '</div>';
    this.canvas = document.getElementById("toolshedr");
  }
  offline() {
    this.page = '<div id="devel">' +
      'Toolshedr<br>' +
      '<em>A tool you need to plan and host efficient workshops</em><br>' +
      '<sup class="error-msg">Could not connect to API!</sup>' +
      '</div>';
  }
  ok(){
    this.page = '<div id="devel">' +
      'Toolshedr<br>' +
      '<em>A tool you need to plan and host efficient workshops</em><br>' +
      '<sup class="ok-msg">Connection to API OK!</sup>' +
      '</div>';
  }
  render(){
    if(this.canvas) {
      this.canvas.innerHTML = this.page;
    } else {
      console.log('Can not find dom element with id=toolshedr!!!');
    }
  }
}

export {Renderer};
