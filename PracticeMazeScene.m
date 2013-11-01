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
//        
//        _menuLayer = [MenuSelectionLayer init];
//        [self addChild:_menuLayer z:2];
        
//        CCMenuItem *kangarooItem = [CCMenuItemImage
//                                    itemWithNormalImage:@"KangarooIcon.png"
//                                    selectedImage:@"KangarooIcon.png"
//                                    target:self selector:@selector(kangarooButtonTapped:)];
//        //self.menu = [CCMenu menuWithItems:superpowers, nil];
//        kangarooItem.position = ccp(60, 60);
//        [self addChild: kangarooItem z:100];
    }
    return self;
}
@end
