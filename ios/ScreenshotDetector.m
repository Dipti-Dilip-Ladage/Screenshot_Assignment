//
//  ScreenshotDetector.m
//  ScreenshotAssignment
//
//  Created by Dipti Dilip Ladage on 08/10/24.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <UIKit/UIKit.h>

@interface ScreenshotDetector : RCTEventEmitter <RCTBridgeModule>
@end

@implementation ScreenshotDetector

RCT_EXPORT_MODULE('ScreenshotDetector');

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDidTakeScreenshot:)
                                                     name:UIApplicationUserDidTakeScreenshotNotification
                                                   object:nil];
    }
    return self;
}

- (void)userDidTakeScreenshot:(NSNotification *)notification {
    [self sendEventWithName:@"UserDidTakeScreenshot" body:@{@"screenshotDetected": @YES}];
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"UserDidTakeScreenshot"];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
