//
//  PracticeMazeScene.m
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PracticeMazeScene.h"


@implementation PracticeMazeScene


-(id)init {
    if ((self = [super init])) {
        _mazeLayer = [MazeLayer node];
        [self addChild:_mazeLayer z:0];
        _hudLayer = [HudLayer node];
        [self addChild:_hudLayer z:1];
        
        _hudLayer.dPad.delegate = _mazeLayer;
        _mazeLayer.hud = _hudLayer;
    }
    return self;
}
@end
