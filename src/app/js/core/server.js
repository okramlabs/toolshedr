'use strict';

import {ResponseError, NotFoundError, HttpError} from './http/http-responses';
import 'whatwg-fetch';

/**
 * Toolshedr SERVER API
 */
class Server {
  constructor(is_dev, api_key) {
    this.api_url = false;
    this.is_dev = is_dev;
    this.headers = new Headers();
    this.headers.append('X-Toolshedr-API-KEY', api_key);
  }

  setApiUrl(url) {
    this.api_url = url;
  }

  /**
   * Can we connect to specified server
   * 
   * @returns {Promise.<TResult>}
   */
  isAlive() {
    let is_alive = this.fetch('/status').then(function (response) {
        return response.code === 200;
      })
      .catch(error => {
        Promise.reject(error);
        return false;
      });
    return is_alive;
  }

  fetch(path, method = 'GET', data = {}) {
    
    // Reguest URL
    let request_url = this.api_url + path;
    
    // Request Object
    var request = new Request(request_url, {
      method: method,
      headers: this.headers,
      mode: 'cors',
      cache: 'default'
    });
    console.log(request_url);
    
    // Fetch from Server API
    return fetch(request).then(response => {

      // Handle Server response
      if (response.ok) {
        const contentType = response.headers.get('Content-Type') || '';

        // make sure that only application/json is expected as return
        if (contentType.includes('application/json')) {
          return response.json().catch(error => {
            return Promise.reject(new ResponseError('Invalid JSON: ' + error.message));
          });
        }
        return Promise.reject(new ResponseError('Invalid content type: ' + contentType));
      }

      // If Server returns 404
      if (response.status === 404) {
        return Promise.reject(new NotFoundError('Page not found: ' + path));
      }

      // If other Server error occoured
      return Promise.reject(new HttpError('HTTP error: ' + response.status));
    }).catch(error => {

      // Perhaps we are not connected to internet
      return Promise.reject(error.message);
    });
    
  }
}
export {Server};
