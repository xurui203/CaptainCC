//
//  MazeLayer.h
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HumanC.h"
#import "DirectionPad.h"
#import "HudLayer.h"


@interface MazeLayer : CCLayer <DirectionPadDelegate>{
    CCTMXTiledMap *_tileMap;
    CCSpriteBatchNode *humanSpriteSheet;
    CCSpriteBatchNode *kangarooSpriteSheet;
    HumanC *_human;
}


@property(nonatomic,weak)HudLayer *hud;

@end
