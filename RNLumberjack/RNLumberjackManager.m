//
//  RNLumberjackManager.m
//  RNLumberjack
//
//  Created by Hank Brekke on 11/26/18.
//  Copyright © 2018 HouseRater. All rights reserved.
//

#import "RNLumberjackManager.h"

#import <CocoaLumberjack/CocoaLumberjack.h>

static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
@implementation RNLumberjackManager

RCT_EXPORT_MODULE()

- (instancetype)init {
    self = [super init];
    if (self) {
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        [DDLog addLogger:[DDASLLogger sharedInstance]];
    }
    return self;
}

+ (BOOL)requiresMainQueueSetup {
    return NO;
}

RCT_EXPORT_METHOD(addFileLogger:(NSUInteger)maxSize withFrequency:(NSUInteger)frequency) {
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.maximumFileSize = maxSize;
    fileLogger.rollingFrequency = frequency;
    [DDLog addLogger:fileLogger];
}

RCT_EXPORT_METHOD(verbose:(NSString *)message fromModule:(NSString *)module) {
    DDLogVerbose(@"%@: %@", module, message);
}

RCT_EXPORT_METHOD(debug:(NSString *)message fromModule:(NSString *)module) {
    DDLogDebug(@"%@: %@", module, message);
}

RCT_EXPORT_METHOD(info:(NSString *)message fromModule:(NSString *)module) {
    DDLogInfo(@"%@: %@", module, message);
}

RCT_EXPORT_METHOD(warn:(NSString *)message fromModule:(NSString *)module) {
    DDLogWarn(@"%@: %@", module, message);
}

RCT_EXPORT_METHOD(error:(NSString *)message fromModule:(NSString *)module) {
    DDLogError(@"%@: %@", module, message);
}

@end
