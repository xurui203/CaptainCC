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
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"CCC_Kangaroo.plist"];
    
    kangarooSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"CCC_Kangaroo.png"];
    [kangarooSpriteSheet.texture setAliasTexParameters];
    
    CCArray *superPowerActionFrames = [CCArray arrayWithCapacity:85];
    for (int i = 1; i <= 25; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Ant Capt Transistion-From KL00%d.png", i]];
        [superPowerActionFrames addObject:frame];
    }
    for (int j = 1; j <= 29; j++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Ant Capt Trainsition-KL00%d.png", j]];
        [superPowerActionFrames addObject:frame];
    }
    for (int k = 1; k <= 31; k++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Lat Capt KL-Jumping00%d.png", k]];
        [superPowerActionFrames addObject:frame];
    }
    CCAnimation *actionAnimation = [CCAnimation animationWithSpriteFrames:[superPowerActionFrames getNSArray] delay:1.0/24.0];
    
    self.mySuperpower = actionAnimation;
    
    return self;
}







@end
