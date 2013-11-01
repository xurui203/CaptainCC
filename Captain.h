//
//  Captain.h
//  CaptainCC
//
//  Created by Ann Niou on 10/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Defines.h"
@interface Captain : CCSprite {
    
}

//actions
@property(nonatomic,strong) CCAction *idleAction;
@property(nonatomic,strong)id superPowerAction;
@property(nonatomic,strong)id walkAction;
@property(nonatomic,strong)id failAction;

//states
@property(nonatomic,assign)ActionState actionState;
@property(nonatomic,assign) Boolean reactivated;


//attributes
@property(nonatomic,assign)float walkSpeed;
@property(nonatomic,assign)float hitPoints;
@property(nonatomic,assign)float damage;

//movement
@property(nonatomic,assign)CGPoint velocity;
@property(nonatomic,assign)CGPoint desiredPosition;

//measurements
@property(nonatomic,assign)float centerToSides;
@property(nonatomic,assign)float centerToBottom;

//action methods
-(void)idle;
-(void)superPower;//attack
-(void)hurtWithDamage:(float)damage;
-(void)walkWithDirection:(CGPoint)direction;



//scheduled methods
-(void)update:(ccTime)dt;

@end
