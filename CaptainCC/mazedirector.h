//
//  mazedirector.h
//  CaptainCC
//
//  Created by Ann Niou on 10/31/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface mazedirector : NSObject
{
	UIWindow *window_;
	UINavigationController *navController_;
    
	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
