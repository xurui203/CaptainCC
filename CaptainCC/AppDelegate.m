//
//  AppDelegate.m
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

//#import "RootViewController.h"

#import "cocos2d.h"

#import "AppDelegate.h"
#import "PracticeMazeScene.h"
@implementation AppController

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//    // Override point for customization after application launch.
////    window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//
//    
////    director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
//
//    return YES;
//}
//
//- (void)applicationWillResignActive:(UIApplication *)application
//{
//    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//}
//
//- (void)applicationDidEnterBackground:(UIApplication *)application
//{
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//}
//
//- (void)applicationWillEnterForeground:(UIApplication *)application
//{
//    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}
//
//- (void)applicationWillTerminate:(UIApplication *)application
//{
//    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//}

//
//@synthesize window=window_, navController=navController_, director=director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Create the main window
//	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    
	
//	// Create a Navigation Controller with the Director
//	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
//	navController_.navigationBarHidden = YES;
//	
//	// set the Navigation Controller as the root view controller
//    //	[window_ addSubview:navController_.view];	// Generates flicker.
//	[window_ setRootViewController:navController_];
//	
//	// make main window visible
//	[window_ makeKeyAndVisible];
//	
	return YES;
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
//	if( [navController_ visibleViewController] == director_ )
//		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
//	if( [navController_ visibleViewController] == director_ )
//		[director_ resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
//	if( [navController_ visibleViewController] == director_ )
//		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
//	if( [navController_ visibleViewController] == director_ )
//		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
//	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
//	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
//	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void) dealloc
{
//	[window_ release];
//	[navController_ release];
    
	[super dealloc];
}
@end


