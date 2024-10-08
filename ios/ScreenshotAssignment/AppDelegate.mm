// #import "AppDelegate.h"
// #import <React/RCTBridgeModule.h>


// #import "AppDelegate.h"
// #import <React/RCTBridgeModule.h>
// #import <React/RCTBundleURLProvider.h>
// #import <React/RCTRootView.h>


#import "AppDelegate.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "ScreenshotDetector.h" // Import the header file

@interface AppDelegate () <RCTBridgeModule>
@end

@implementation AppDelegate

// Register the module with React Native
RCT_EXPORT_MODULE();

// Method to enable screen capture prevention
// RCT_EXPORT_METHOD(enableSecureMode) {
//     [self addScreenCaptureObserver];
// }

// // Method to disable screen capture prevention
// RCT_EXPORT_METHOD(disableSecureMode) {
//     [self removeScreenCaptureObserver];
// }

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // self.moduleName = @"ScreenshotAssignment";
  // self.initialProps = @{};
//   // You can add your custom initial props in the dictionary below.
//   // They will be passed down to the ViewController used by React Native.

//       RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
//                                                      moduleName:@"YourAppName"
//                                               initialProperties:nil];

// //  rootView.backgroundColor = [UIColor whiteColor];

//     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//     UIViewController *rootViewController = [UIViewController new];
//     rootViewController.view = rootView;
//     self.window.rootViewController = rootViewController;
//     [self.window makeKeyAndVisible];

//   // self.initialProps = @{};
//     [self addObserver];

//   return [super application:application didFinishLaunchingWithOptions:launchOptions];

    RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];

    // Initialize the RCTRootView with the bridge, module name, and initial properties
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                     moduleName:@"ScreenshotAssignment"  // Replace with your app's registered name
                                              initialProperties:nil];

    // Set the background color of the root view
    rootView.backgroundColor = [UIColor whiteColor];

    // Create the window and set the root view controller
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = rootView;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];

    return YES;
      // return [super application:application didFinishLaunchingWithOptions:launchOptions];

}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [self bundleURL];
}
// Required method for RCTBridgeDelegate - specifies the location of the JavaScript bundle
// - (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
// #if DEBUG
//     return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
// #else
//     return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
// #endif
// }


// Method to enable screen capture prevention
RCT_EXPORT_METHOD(enableSecureMode) {
    [self addScreenCaptureObserver];
}

// Method to disable screen capture prevention
RCT_EXPORT_METHOD(disableSecureMode) {
    [self removeScreenCaptureObserver];
}


// Method to add the screen capture observer
- (void)addScreenCaptureObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangeScreenCaptured:)
                                                 name:UIScreenCapturedDidChangeNotification
                                               object:nil];
}

// Method to remove the screen capture observer
- (void)removeScreenCaptureObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIScreenCapturedDidChangeNotification
                                                  object:nil];
}



// Method called when screen capture status changes
- (void)didChangeScreenCaptured:(NSNotification *)notification {
    if (@available(iOS 11.0, *)) {
        if ([UIScreen mainScreen].isCaptured) {
            // Screen capture detected, you can handle this (e.g., show an alert)
            NSLog(@"Screen capture detected!");
        } else {
            // Screen capture stopped
            NSLog(@"Screen capture stopped.");
        }
    }
}

- (NSURL *)bundleURL
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}




@end
