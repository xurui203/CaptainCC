//
//  Captain.m
//  CaptainCC
//
//  Created by Ann Niou on 10/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Captain.h"


@implementation Captain

-(void)idle {
    if (_actionState != kActionStateIdle) {
        [self stopAllActions];
        [self runAction:_idleAction];
        _actionState = kActionStateIdle;
        _velocity = CGPointZero;
    }
}
-(id)initWithSpriteFrameName:(NSString*)spriteFrameName
{
	NSAssert(spriteFrameName!=nil, @"Invalid spriteFrameName for sprite");
    
	CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteFrameName];
	return [super initWithSpriteFrame:frame];
}

-(void)superPower {
    if (_actionState == kActionStateIdle || _actionState == kActionStateSuperPower || _actionState == kActionStateWalk) {
        [self stopAllActions];
        [self runAction:_superPowerAction];
        _actionState = kActionStateSuperPower;
    }
}


-(void)walkWithDirection:(CGPoint)direction {
    if (_actionState == kActionStateIdle) {
        [self stopAllActions];
        [self runAction:_walkAction];
        _actionState = kActionStateWalk;
    }
    if (_actionState == kActionStateWalk) {
        _velocity = ccp(direction.x * _walkSpeed, direction.y * _walkSpeed);
        if (_velocity.x >= 0) self.scaleX = 1.0;
        else self.scaleX = -1.0;
    }
}

-(void)update:(ccTime)dt {
    if (_actionState == kActionStateWalk) {
        _desiredPosition = ccpAdd(position_, ccpMult(_velocity, dt));
    }
}

@end
