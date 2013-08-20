//
//  SIAppDelegate.m
//  SeeIt
//
//  Created by Pro on 8/19/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//


#import "SIAppDelegate.h"
#import "menuSIViewController.h"
#import <FacebookSDK/FacebookSDK.h>
@implementation SIAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

// FBSample logic
// If we have a valid session at the time of openURL call, we handle Facebook transitions
// by passing the url argument to handleOpenURL; see the "Just Login" sample application for
// a more detailed discussion of handleOpenURL
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                    fallbackHandler:^(FBAppCall *call) {
                        NSLog(@"In fallback handler");
                    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // FBSample logic
    // if the app is going away, we close the session object
    [FBSession.activeSession close];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //    // If you have not added the -ObjC linker flag, you may need to uncomment the following line because
    
    [FBProfilePictureView class];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application	{
    // FBSample logic
    // Call the 'activateApp' method to log an app event for use in analytics and advertising reporting.
    [FBAppEvents activateApp];
    
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActive];
}


@end
