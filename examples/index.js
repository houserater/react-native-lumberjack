/**
 * @format
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import {AppRegistry} from 'react-native';
import App from './App';
import {name as appName} from './app.json';
import RNLumberjack from "../";

RNLumberjack.addFileLogger();

AppRegistry.registerComponent(appName, () => App);
