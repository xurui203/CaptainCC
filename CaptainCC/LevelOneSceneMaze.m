//
//  LevelOneSceneMaze.m
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//
//

#import "LevelOneSceneMaze.h"
#import "Captain.h"


@interface LevelOneSceneMaze() {
    CCTMXTiledMap *map;
    Captain *captain;
    CCTMXLayer *walls;
    CCTMXLayer *hazards;
    BOOL gameOver;
}

@end

@implementation LevelOneSceneMaze

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LevelOneSceneMaze *layer = [LevelOneSceneMaze node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        //  [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"level1.mp3"];
        self.isTouchEnabled = YES;
        CCLayerColor *blueSky = [[CCLayerColor alloc] initWithColor:ccc4(100, 100, 250, 255)];
    
        [self addChild:blueSky];
        
        map = [[CCTMXTiledMap alloc] initWithTMXFile:@"level1.tmx"];
        [self addChild:map];
        
        
//        captain = [[Captain alloc] initWithFile:@"CCC_standing_01.png"];
//        SKSpriteNode *captainsksprite = [[SKSpriteNode alloc] initWithImageNamed:@"CCC_standing_01.png"];
//        captainsksprite.position = ccp(200, 300);
//        [self addChild:captainsksprite z:30];
        captain = [[Captain alloc] initWithFile:@"CCC_standing_1.png"];
        captain.position = ccp(100, 300);
        [map addChild:captain z:15];
        
        walls = [map layerNamed:@"walls"];
        hazards = [map layerNamed:@"hazards"];
        
        [self schedule:@selector(update:)];
        
	}
	return self;
}

-(void)update:(ccTime)dt {
    if (gameOver) {
        return;
    }
    [captain update:dt];
    [self checkForWin];
    [self checkForAndResolveCollisions:captain];
    [self handleHazardCollisions:captain];
    [self setViewpointCenter:captain.position];
}

- (CGPoint)tileCoordForPosition:(CGPoint)position {
    float x = floor(position.x / map.tileSize.width);
    float levelHeightInPixels = map.mapSize.height * map.tileSize.height;
    float y = floor((levelHeightInPixels - position.y) / map.tileSize.height);
    return ccp(x, y);
}

-(CGRect)tileRectFromTileCoords:(CGPoint)tileCoords {
    float levelHeightInPixels = map.mapSize.height * map.tileSize.height;
    CGPoint origin = ccp(tileCoords.x * map.tileSize.width, levelHeightInPixels - ((tileCoords.y + 1) * map.tileSize.height));
    return CGRectMake(origin.x, origin.y, map.tileSize.width, map.tileSize.height);
}

-(NSArray *)getSurroundingTilesAtPosition:(CGPoint)position forLayer:(CCTMXLayer *)layer {
    
    CGPoint plPos = [self tileCoordForPosition:position]; //1
    
    NSMutableArray *gids = [NSMutableArray array]; //2
    
    for (int i = 0; i < 9; i++) { //3
        int c = i % 3;
        int r = (int)(i / 3);
        CGPoint tilePos = ccp(plPos.x + (c - 1), plPos.y + (r - 1));
        
        if (tilePos.y > (map.mapSize.height - 1)) {
            //fallen in a hole
            [self gameOver:0];
            return nil;
        }
        
        int tgid = [layer tileGIDAt:tilePos]; //4
        
        CGRect tileRect = [self tileRectFromTileCoords:tilePos]; //5
        
        NSDictionary *tileDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:tgid], @"gid",
                                  [NSNumber numberWithFloat:tileRect.origin.x], @"x",
                                  [NSNumber numberWithFloat:tileRect.origin.y], @"y",
                                  [NSValue valueWithCGPoint:tilePos],@"tilePos",
                                  nil];
        [gids addObject:tileDict]; //6
        
    }
    
    [gids removeObjectAtIndex:4]; //7
    [gids insertObject:[gids objectAtIndex:2] atIndex:6];
    [gids removeObjectAtIndex:2];
    [gids exchangeObjectAtIndex:4 withObjectAtIndex:6];
    [gids exchangeObjectAtIndex:0 withObjectAtIndex:4];
    
    return (NSArray *)gids;
}

-(void)checkForAndResolveCollisions:(Captain *)p {
    
    NSArray *tiles = [self getSurroundingTilesAtPosition:p.position forLayer:walls ]; //1
    if (gameOver) {
        return;
    }
    p.onGround = NO;
    
    for (NSDictionary *dic in tiles) {
        CGRect pRect = [p collisionBoundingBox]; //3
        
        int gid = [[dic objectForKey:@"gid"] intValue]; //4
        
        if (gid) {
            CGRect tileRect = CGRectMake([[dic objectForKey:@"x"] floatValue], [[dic objectForKey:@"y"] floatValue], map.tileSize.width, map.tileSize.height); //5
            if (CGRectIntersectsRect(pRect, tileRect)) {
                CGRect intersection = CGRectIntersection(pRect, tileRect);
                int tileIndx = [tiles indexOfObject:dic];
                
                if (tileIndx == 0) {
                    //tile is directly below player
                    p.desiredPosition = ccp(p.desiredPosition.x, p.desiredPosition.y + intersection.size.height);
                    p.velocity = ccp(p.velocity.x, 0.0);
                    p.onGround = YES;
                } else if (tileIndx == 1) {
                    //tile is directly above player
                    p.desiredPosition = ccp(p.desiredPosition.x, p.desiredPosition.y - intersection.size.height);
                    p.velocity = ccp(p.velocity.x, 0.0);
                } else if (tileIndx == 2) {
                    //tile is left of player
                    p.desiredPosition = ccp(p.desiredPosition.x + intersection.size.width, p.desiredPosition.y);
                } else if (tileIndx == 3) {
                    //tile is right of player
                    p.desiredPosition = ccp(p.desiredPosition.x - intersection.size.width, p.desiredPosition.y);
                } else {
                    if (intersection.size.width > intersection.size.height) {
                        //tile is diagonal, but resolving collision vertially
                        p.velocity = ccp(p.velocity.x, 0.0);
                        float resolutionHeight;
                        if (tileIndx > 5) {
                            resolutionHeight = -intersection.size.height;
                            p.onGround = YES;
                        } else {
                            resolutionHeight = intersection.size.height;
                        }
                        
                        p.desiredPosition = ccp(p.desiredPosition.x, p.desiredPosition.y + resolutionHeight );
                        
                    } else {
                        float resolutionWidth;
                        if (tileIndx == 6 || tileIndx == 4) {
                            resolutionWidth = intersection.size.width;
                        } else {
                            resolutionWidth = -intersection.size.width;
                        }
                        p.desiredPosition = ccp(p.desiredPosition.x + resolutionWidth , p.desiredPosition.y);
                        
                    }
                }
            }
        }
    }
    p.position = p.desiredPosition; //8
}

-(void)handleHazardCollisions:(Captain *)p {
    NSArray *tiles = [self getSurroundingTilesAtPosition:p.position forLayer:hazards ];
    for (NSDictionary *dic in tiles) {
        CGRect tileRect = CGRectMake([[dic objectForKey:@"x"] floatValue], [[dic objectForKey:@"y"] floatValue], map.tileSize.width, map.tileSize.height);
        CGRect pRect = [p collisionBoundingBox];
        
        if ([[dic objectForKey:@"gid"] intValue] && CGRectIntersectsRect(pRect, tileRect)) {
            [self gameOver:0];
        }
    }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        CGPoint touchLocation = [self convertTouchToNodeSpace:t];
        if (touchLocation.x > 240) {
            captain.mightAsWellJump = YES;
        } else {
            captain.forwardMarch = YES;
        }
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        
        CGPoint touchLocation = [self convertTouchToNodeSpace:t];
        
        //get previous touch and convert it to node space
        CGPoint previousTouchLocation = [t previousLocationInView:[t view]];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        previousTouchLocation = ccp(previousTouchLocation.x, screenSize.height - previousTouchLocation.y);
        
        if (touchLocation.x > 240 && previousTouchLocation.x <= 240) {
            captain.forwardMarch = NO;
            captain.mightAsWellJump = YES;
        } else if (previousTouchLocation.x > 240 && touchLocation.x <=240) {
            captain.forwardMarch = YES;
            captain.mightAsWellJump = NO;
        }
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *t in touches) {
        CGPoint touchLocation = [self convertTouchToNodeSpace:t];
        if (touchLocation.x < 240) {
            captain.forwardMarch = NO;
        } else {
            captain.mightAsWellJump = NO;
        }
    }
}

-(void)gameOver:(BOOL)won {
	gameOver = YES;
	NSString *gameText;
	
	if (won) {
		gameText = @"You Won!";
	} else {
		gameText = @"You have Died!";
//        [[SimpleAudioEngine sharedEngine] playEffect:@"hurt.wav"];
	}
	
    CCLabelTTF *diedLabel = [[CCLabelTTF alloc] initWithString:gameText fontName:@"Marker Felt" fontSize:40];
    diedLabel.position = ccp(240, 200);
    CCMoveBy *slideIn = [[CCMoveBy alloc] initWithDuration:1.0 position:ccp(0, 250)];
    CCMenuItemImage *replay = [[CCMenuItemImage alloc] initWithNormalImage:@"replay.png" selectedImage:@"replay.png" disabledImage:@"replay.png" block:^(id sender) {
        [[CCDirector sharedDirector] replaceScene:[LevelOneSceneMaze scene]];
    }];
    
    NSArray *menuItems = [NSArray arrayWithObject:replay];
    CCMenu *menu = [[CCMenu alloc] initWithArray:menuItems];
    menu.position = ccp(240, -100);
    
    [self addChild:menu];
    [self addChild:diedLabel];
    
    [menu runAction:slideIn];
}

-(void)checkForWin {
    if (captain.position.x > 3130.0) {
        [self gameOver:1];
    }
}

-(void)setViewpointCenter:(CGPoint) position {
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int x = MAX(position.x, winSize.width / 2);
    int y = MAX(position.y, winSize.height / 2);
    x = MIN(x, (map.mapSize.width * map.tileSize.width)
            - winSize.width / 2);
    y = MIN(y, (map.mapSize.height * map.tileSize.height)
            - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    map.position = viewPoint;
}

@end
