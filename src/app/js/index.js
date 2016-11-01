'use strict';

if (module.hot) {
  module.hot.accept();
}

import '../scss/toolshedr.scss';

import Toolshedr from './core/toolshedr';

import {Config} from './core/config';
import {Renderer} from './core/renderer';

// Set objects
Toolshedr.Config = new Config();
Toolshedr.Renderer = new Renderer();

// Set props
Toolshedr.version = TOOLSHEDR_VERSION + '-devel';

// Export to browser
exports = window.TOOLSHEDR = Toolshedr;

TOOLSHEDR.Config.set({
  host: 'localhost',
  path: '/devel/api.php',
  port: '8080',
  scheme: 'http',
  api_key: 'ce74e4b29e2e8f8679dfa1bb07f844329c76196f' // === sha1('API-KEY-Which-UI-has-to-use')
});
TOOLSHEDR.connect();

