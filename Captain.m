//
//  Captain.m
//  CaptainCC
//
//  Created by Ann Niou on 10/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Captain.h"


@implementation Captain

#define JUMP_TAG 1001

-(void)idle {
    NSLog(@"IDLING");

    NSLog(@"old position is %f", self.position.x);

    if (_actionState == kActionStateSuperPower){
            NSLog(@"JUMP EXECUTING");

            CCJumpTo* jumpAct = [CCJumpTo actionWithDuration:1.0f position:ccp(self.position.x + 150.0, self.position.y) height:80 jumps:1 ];
            jumpAct.tag = JUMP_TAG;
        [self runAction:jumpAct];

        CCAction *action = [self getActionByTag: JUMP_TAG];
        if (!action){
            [self runAction:_idleAction];
            _actionState = kActionStateIdle;
        }

        
    }

    else {//(_actionState != kActionStateIdle){
        NSLog(@"STATE IS NOT IDLE");
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

//        CGPoint newPosition = ccp(max(self.position.x + 50, 500), self.position.y);
//        id jumpAct = [CCJumpBy actionWithDuration:1.0f position:newPosition height:200 jumps:1];
//        [self runAction:jumpAct];
       // _actionState = kActionStateSuperPower;
      //  _velocity = ccp(self.position.x * _walkSpeed, self.position.y * _walkSpeed);
        _actionState = kActionStateSuperPower;
        NSLog(@"state changed to superpower");
        
//        if (_actionState == kActionStateSuperPower){
//            
//            // if (n == 0){
//            NSLog(@"JUMP EXECUTING");
//            
//            CCJumpTo* jumpAct = [CCJumpTo actionWithDuration:2.0f position:ccp(self.position.x + 200.0, self.position.y) height:10 jumps:1 ];
//            jumpAct.tag = JUMP_TAG;
//            // n++;
//            //  }
//            [self runAction:jumpAct];
//            
//            CCAction *action = [self getActionByTag: JUMP_TAG];
//            
//            if (!action){
//                NSLog(@"IDLE EXECUTING");
//                [self runAction:_idleAction];
//                _actionState = kActionStateIdle;
//            }
//        }
//
    }
        //_actionState = kActionStateIdle;
    
}


-(void)walkWithDirection:(CGPoint)direction {
    if (_actionState == kActionStateIdle|| _actionState == kActionStateSuperPower) {
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
    if (_actionState == kActionStateWalk | _actionState == kActionStateSuperPower) {
        _desiredPosition = ccpAdd(position_, ccpMult(_velocity, dt));
    }
}

@end
