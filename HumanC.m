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
    if ((self = [super initWithSpriteFrameName:@"Standing/Lat Capt Human-Standing0001.png"])) {
        NSLog(@"init human");
        
        //Set idle action
        self.idleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[self HumanIdleAnimation]]];
        
        
        //Set walk action
        self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation: [self HumanWalkAnimation]]];
        
        
        //Set some initial values for the hero’s attributes, including the measurements from the center of the sprite to the sides and bottom
        self.centerToBottom = 39.0;
        self.centerToSides = 29.0;
        self.hitPoints = 100.0;
        self.damage = 20.0;
        self.walkSpeed = 80;
        
        
        //action animation - runs once and then returns to idle
//        CCArray *superPowerActionFrames = [CCArray arrayWithCapacity:9];
//        for (i = 1; i < 10; i++) {
//            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Running/Lat Capt Human-Running000%d.png", i]];
//            [superPowerActionFrames addObject:frame];
//        }
//        CCAnimation *actionAnimation = [CCAnimation animationWithSpriteFrames:[superPowerActionFrames getNSArray] delay:1.0/24.0];
//        self.superPowerAction = [CCSequence actions:[CCAnimate actionWithAnimation:actionAnimation], [CCCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        

    }
    return self;
}

- (CCAnimation *) HumanWalkAnimation {
    
    CCArray *walkFrames = [CCArray arrayWithCapacity:8];
    for (int i = 1; i < 9; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Walking/Lat Capt Human-Walking000%d.png", i]];
        [walkFrames addObject:frame];
    }
    
    CCAnimation *walk = [CCAnimation animationWithSpriteFrames:[walkFrames getNSArray] delay:1.0/12.0];
    
    return walk;
    
}

- (CCAnimation *) HumanIdleAnimation {
    
    CCArray *idleFrames = [CCArray arrayWithCapacity:2];
    for (int i = 1; i < 3; i++) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Standing/Lat Capt Human-Standing000%d.png", i]];
        [idleFrames addObject:frame];
    }
    
    CCAnimation *idleAnimation = [CCAnimation animationWithSpriteFrames:[idleFrames getNSArray] delay:1.0/12.0];

    return idleAnimation;
}

- (void) setSuperPowerAction: (Superpower*) superpower{
    self.superPowerAction = superpower.superpowerAction;
}


@end
