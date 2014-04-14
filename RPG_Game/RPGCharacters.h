//
//  RPGCharacters.h
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "RPGConstants.h"

@interface RPGCharacters : SKNode
{
    SKSpriteNode *mainGuy;
    SKAction *anim;
}
@property BOOL isAlive;
@property BOOL isAttacking;
@property SKTexture *frontStill, *frontWalk1, *frontWalk2, *frontAttack;
@property SKTexture *backStill, *backWalk1, *backWalk2, *backAttack;
@property SKTexture *leftStill, *leftWalk1, *leftWalk2, *leftAttack;
@property SKTexture *rightStill, *rightWalk1, *rightWalk2, *rightAttack;
- (id)init;
- (void)createFrames;
- (void)createStuff;
- (void)stillFrame:(char)direction;
- (void)goUp;
- (void)goDown;
- (void)goLeft;
- (void)goRight;
- (void)AttackInDirection:(char)direction;
- (void)doAction:(id)fromThing withDirection:(char)direction orDestroy:(BOOL)isIt;
- (void)tellIt;
@end
