//
//  MazeLayer.m
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MazeLayer.h"
#import "Superpower.h"


@implementation MazeLayer



-(id)init {
    if ((self = [super init])) {
        self.isTouchEnabled = YES;
        
        [self initTileMap];
        [self scheduleUpdate];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"CCC_first.plist"];
    
         humanSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"CCC_first.png"];
        [humanSpriteSheet.texture setAliasTexParameters];
        [self addChild:humanSpriteSheet z:-5];
        
        [self initHuman];
        
        CCMenuItem *kangarooItem = [CCMenuItemImage
                                    itemWithNormalImage:@"KangarooIcon.png"
                                    selectedImage:@"KangarooIcon.png"
                                    target:self selector:@selector(kangarooButtonTapped:)];
        CCMenu *menu= [CCMenu menuWithItems:kangarooItem, nil];
        menu.position = ccp(500, 300);
        [self addChild: menu z:100];
    }
    return self;
}
-(void)update:(ccTime)dt {
    [_human update:dt];
    [self updatePositions];
    [self setViewpointCenter:_human.position];
}

-(void)setViewpointCenter:(CGPoint) position {
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int x = MAX(position.x, winSize.width / 2);
    int y = MAX(position.y, winSize.height / 2);
    x = MIN(x, (_tileMap.mapSize.width * _tileMap.tileSize.width)
            - winSize.width / 2);
    y = MIN(y, (_tileMap.mapSize.height * _tileMap.tileSize.height)
            - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    self.position = viewPoint;
}

-(void)updatePositions {
    float posX = MIN(_tileMap.mapSize.width * _tileMap.tileSize.width - _human.centerToSides, MAX(_human.centerToSides, _human.desiredPosition.x));
    float posY = MIN(3 * _tileMap.tileSize.height + _human.centerToBottom, MAX(_human.centerToBottom, _human.desiredPosition.y));
    _human.position = ccp(posX, posY);
}
-(void)dealloc {
    [self unscheduleUpdate];
}

-(void)initHuman {
    _human = [HumanC node];
    [humanSpriteSheet addChild:_human];
    //??
    _human.position = ccp(_human.centerToSides, 80);
    _human.desiredPosition = _human.position;
    [_human idle];
}


-(void)initTileMap {
    _tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"prac_map.tmx"];
    for (CCTMXLayer *child in [_tileMap children]) {
        [[child texture] setAliasTexParameters];
    }
    [self addChild:_tileMap z:-6];
}

-(void)kangarooButtonTapped:(id) sender{
    NSLog(@"kangaroo selected");
    //Superpower *power = [Superpower init];
//    _human.superPowerAction = power.superpowerAction;
    [_human superPower];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_human superPower];
}


-(void)DirectionPad:(DirectionPad *)DirectionPad didChangeDirectionTo:(CGPoint)direction {
    [_human walkWithDirection:direction];
}
-(void)DirectionPadTouchEnded:(DirectionPad *)DirectionPad {
    if (_human.actionState ==kActionStateWalk) {
        [_human idle];
    }
}

-(void)DirectionPad:(DirectionPad *)DirectionPad isHoldingDirection:(CGPoint)direction {
    [_human walkWithDirection:direction];
}

@end
