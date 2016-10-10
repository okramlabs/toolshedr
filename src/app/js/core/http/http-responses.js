class HttpError extends Error {

  /**
   * HTTP Status constructor
   * 
   * @param message
   * @param code
   */
  constructor(message, code) {
    super(message);
    this.name = this.constructor.name;
    this.setDefaults();
    this.setCode(code);
    this.setMessage(this.name + ': code: '+ this.code + ' message: ' + message);
  }
  
  setCode(code){
    this.code = code || this.defaultCode();
  }
  
  setMessage(msg){
    this.message = msg || this.defaultMessage();
  }

  setDefaults()
  {
    this.name = 'Server API HttpError';
    this.default_code = 500;
    this.default_message = "Internal Server Error";
  }
  
  defaultCode(){
    return this.default_code;
  }

  defaultMessage(){
    return this.default_message;
  }
}

class ResponseError extends HttpError {

  setDefaults()
  {
    this.name = 'Server API ResponseError';
    this.default_code = 501;
    this.default_message = "Not Implemented";
  }
}

class NotFoundError extends HttpError {
  
  setDefaults()
  {
    this.name = 'Server API NotFoundError';
    this.default_code = 404;
    this.default_message = "Not Found";
  }
}

export {HttpError, ResponseError, NotFoundError};

