//
//  Captain.m
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Captain.h"
#import <SpriteKit/SpriteKit.h>
@implementation Captain

@synthesize velocity = _velocity;
@synthesize desiredPosition = _desiredPosition;
@synthesize onGround = _onGround;
@synthesize forwardMarch = _forwardMarch, mightAsWellJump = _mightAsWellJump;

-(id)initWithFile:(NSString *)filename {
    if (self = [super initWithFile:filename]) {
        self.velocity = ccp(0.0, 0.0);
        
    }
    return self;
}

-(void)update:(ccTime)dt {
    
    CGPoint jumpForce = ccp(0.0, 310.0);
    float jumpCutoff = 150.0;
    
    if (self.mightAsWellJump && self.onGround) {
        NSLog(@"on ground");
        self.velocity = ccpAdd(self.velocity, jumpForce);
//        [[SimpleAudioEngine sharedEngine] playEffect:@"jump.wav"];
    } else if (!self.mightAsWellJump && self.velocity.y > jumpCutoff) {
        self.velocity = ccp(self.velocity.x, jumpCutoff);
    }
    if (!self.onGround) {
        NSLog(@" not on ground");
    }
    CGPoint gravity = ccp(0.0, -350.0);
    CGPoint gravityStep = ccpMult(gravity, dt);
    
    CGPoint forwardMove = ccp(800.0, 0.0);
    CGPoint forwardStep = ccpMult(forwardMove, dt);
    
    self.velocity = ccp(self.velocity.x * 0.90, self.velocity.y); //2
    
    if (self.forwardMarch) {
        self.velocity = ccpAdd(self.velocity, forwardStep);
    } //3
    
    CGPoint minMovement = ccp(0.0, -450.0);
    CGPoint maxMovement = ccp(120.0, 250.0);
    self.velocity = ccpClamp(self.velocity, minMovement, maxMovement);
    
    self.velocity = ccpAdd(self.velocity, gravityStep);
    
    CGPoint stepVelocity = ccpMult(self.velocity, dt);
    
    self.desiredPosition = ccpAdd(self.position, stepVelocity);
}

-(CGRect)collisionBoundingBox {
    
//    CGRect collisionBox = CGRectInset(self.boundingBox, 3, -1000);
    CGRect  collisionBox = self.boundingBox;
    NSLog(@"bounding box: %f, %f", self.boundingBox.size.width, self.boundingBox.size.height);
    //collisionBox = CGRectOffset(collisionBox, 0, -2);
    CGPoint diff = ccpSub(self.desiredPosition, self.position);
    CGRect returnBoundingBox = CGRectOffset(collisionBox, diff.x, 0);
    return returnBoundingBox;
    
}

@end
