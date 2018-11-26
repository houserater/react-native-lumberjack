/**
 * Copyright (c) 2018, HouseRater LLC.
 * All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 * @providesModule react-native-lumberjack
 */

import React from "react";
import { NativeModules } from "react-native";
import { format } from "util";

const RNLumberjack = NativeModules.RNLumberjackManager;

function stackToString (e) {
    let s = e.stack, ce;

    if (typeof e.cause === 'function' && (ce = e.cause()))
        s += '\nCaused by: ' + stackToString(ce);

    return s
}

function LoggingBuilder(loggerName) {
    return [
        "verbose",
        "debug",
        "info",
        "warn",
        "error"
    ].reduce((logger, logName) => {
        logger[logName] = (...args) => {
            args = args.map((arg) => {
                if (arg instanceof Error) {
                    const errorBody = {
                        message: arg.message,
                        code: arg.code,
                        stack: stackToString(arg)
                    };
                    return `Error(${arg.name})${JSON.stringify(errorBody)}`
                }
                return arg;
            });
            const message = format(...args);
            RNLumberjack[logName](message, loggerName);
        };
        return logger;
    }, {})
}

module.exports = LoggingBuilder;
