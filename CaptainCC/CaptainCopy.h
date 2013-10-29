//
//  CaptainCopy.h
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <SpriteKit/SpriteKit.h>

@interface Captain : SKSpriteNode

@property (nonatomic, assign) CGPoint velocity;
@property (nonatomic, assign) CGPoint desiredPosition;
@property (nonatomic, assign) BOOL onGround;
@property (nonatomic, assign) BOOL forwardMarch;
@property (nonatomic, assign) BOOL mightAsWellJump;

-(void)update:(ccTime)dt;
-(CGRect)collisionBoundingBox;

@end

