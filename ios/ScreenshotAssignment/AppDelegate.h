// #import <RCTAppDelegate.h>
// #import <UIKit/UIKit.h>

// @interface AppDelegate : RCTAppDelegate

// @end


#import <React/RCTBridgeDelegate.h>
#import <RCTAppDelegate.h>
#import <UIKit/UIKit.h>

// @interface AppDelegate : RCTAppDelegate
@interface AppDelegate : UIResponder <UIApplicationDelegate, RCTBridgeDelegate>
@property (nonatomic, strong) UIWindow *window;

@end
