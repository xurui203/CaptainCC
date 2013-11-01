//
//  HumanC.m
//  CaptainCC
//
//  Created by Ann Niou on 10/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HumanC.h"
#import "Superpower.h"


@implementation HumanC

-(id)init {
    if ((self = [super initWithSpriteFrameName:@"Lat Capt Human-Standing0001.png"])) {
        NSLog(@"init human");
        
        //Set idle action
        self.idleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[self HumanIdleAnimation]]];
        
        
        //Set walk action
        self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation: [self HumanWalkAnimation]]];
        
        //Def superpower
//        Superpower *testSuperpower = [Superpower alloc];
//        testSuperpower = [testSuperpower init];
//
//        
        
        //action animation - runs once and then returns to idle
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

        self.superPowerAction = [CCSequence actions:[CCAnimate actionWithAnimation:actionAnimation], [CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        //
        //Set some initial values for the hero’s attributes, including the measurements from the center of the sprite to the sides and bottom
        self.centerToBottom = 39.0;
        self.centerToSides = 29.0;
        self.hitPoints = 100.0;
        self.damage = 20.0;
        self.walkSpeed = 80;
        

        

    }
    return self;
}

- (CCAnimation *) HumanWalkAnimation {
    
    CCArray *walkFrames = [CCArray arrayWithCapacity:8];
    for (int i = 1; i < 9; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Lat Capt Human-Walking000%d.png", i]];
        [walkFrames addObject:frame];
    }
    
    CCAnimation *walk = [CCAnimation animationWithSpriteFrames:[walkFrames getNSArray] delay:1.0/12.0];
    
    return walk;
    
}

- (CCAnimation *) HumanIdleAnimation {
    
    CCArray *idleFrames = [CCArray arrayWithCapacity:2];
    for (int i = 1; i < 3; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Lat Capt Human-Standing000%d.png", i]];
        [idleFrames addObject:frame];
    }
    
    CCAnimation *idleAnimation = [CCAnimation animationWithSpriteFrames:[idleFrames getNSArray] delay:1.0/12.0];

    return idleAnimation;
}


@end
