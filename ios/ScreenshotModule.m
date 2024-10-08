//
//  ScreenshotModule.m
//  ScreenshotAssignment
//
//  Created by Dipti Dilip Ladage on 08/10/24.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import <UIKit/UIKit.h>

@interface RCT_EXTERN_MODULE(ScreenshotModule, NSObject)
RCT_EXTERN_METHOD(isScreenCaptured:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
//RCT_EXTERN_METHOD(toggleScreenshotPrevention:(BOOL)enabled resolve:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
@end
