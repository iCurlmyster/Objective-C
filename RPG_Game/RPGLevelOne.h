//
//  RPGLevelOne.h
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "RPGCharacters.h"
#import "RPGConstants.h"
#import "RPGBadGuy.h"

@interface RPGLevelOne : SKScene <SKPhysicsContactDelegate>
{
    SKNode *myWorld;
    RPGCharacters *leader;
    SKSpriteNode *house;
    char directionOfCharacter;
    NSMutableArray *enemyArray;
    NSUInteger howManyEnemies;
    int counter;
    
    SKLabelNode *livesText, *enemyCount;
    
}
@property BOOL didCreate;
@property BOOL isAround;
@property BOOL isLeft;
@property BOOL isRight;
@property BOOL isUp;
@property BOOL isDown;
@property BOOL keyIsPressed;

- (void)didMoveToView:(SKView *)view;
- (void)createScene;
- (void)renderCharacters;
- (void)renderObjects;
- (void)judgeDistance;
- (void)update:(NSTimeInterval)currentTime;
- (void)didSimulatePhysics;
- (void)centerNode:(SKNode *)node;
- (void)keyDown:(NSEvent *)theEvent;
- (void)keyUp:(NSEvent *)theEvent;
- (void)killHim:(SKSpriteNode *)thing;
- (void)takeAway:(SKSpriteNode*)yeah;
- (void)renderText;
- (void)smokeStuff: (SKSpriteNode *)what withOther:(SKSpriteNode *)the;
- (void)fireStuff: (SKSpriteNode *)but withOther:(id)the;
@end
