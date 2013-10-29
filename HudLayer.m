//
//  HudLayer.m
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "HudLayer.h"


@implementation HudLayer


-(id)init {
    if ((self = [super init])) {
        _dPad = [DirectionPad dPadWithFile:@"pd_dpad.png" radius:64];
        _dPad.position = ccp(64.0, 64.0);
        _dPad.opacity = 100;
        [self addChild:_dPad];
    }
    return self;
}
@end
