import {version, name} from '../../../package.json';

import Toolshedr from './core/toolshedr';

import {Config} from './core/config';
import {Renderer} from './core/renderer';

// Set objects
Toolshedr.Config = new Config();
Toolshedr.Renderer = new Renderer();

// Set props
Toolshedr.name = name;
Toolshedr.version = version + '-devel';

// Export to browser
exports = window.TOOLSHEDR = Toolshedr;
