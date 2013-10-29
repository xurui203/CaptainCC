//
//  AppDelegate.h
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "cocos2d.h"
@interface AppDelegate : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
    
	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
