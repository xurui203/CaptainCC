//
//  Superpower.m
//  CaptainCC
//
//  Created by Xu Rui on 31/10/13.
//
//

#import "Superpower.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"


@implementation Superpower

-(id)init{
    
    self.superpowerAction = self.setSuperpowerAction;
    
}


-(CCAnimation *) setSuperpowerAction {
    //action animation - runs once and then returns to idle
    CCArray *superPowerActionFrames = [CCArray arrayWithCapacity:9];
    for (int i = 1; i < 10; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Running/Lat Capt Human-Running000%d.png", i]];
        [superPowerActionFrames addObject:frame];
    }
    CCAnimation *actionAnimation = [CCAnimation animationWithSpriteFrames:[superPowerActionFrames getNSArray] delay:1.0/24.0];
    self.superpowerAction = [CCSequence actions:[CCAnimate actionWithAnimation:actionAnimation], [CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
    
    return self.superpowerAction;
}






@end
