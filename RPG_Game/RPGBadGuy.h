//
//  RPGBadGuy.h
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "RPGConstants.h"

@interface RPGBadGuy : SKNode
{
    SKSpriteNode *mainGuy;
    SKTexture *frontView, *backView, *leftView, *rightView;
    CGFloat xPos,yPos;
    int counter;
    //SKEmitterNode *effect;
}
@property BOOL isIdle;
@property BOOL isAttack;
@property BOOL possiblyAlive;
- (id)initWithName:(NSString*)myName;
- (void)createStuff;
- (void)createFrames;
- (void)randomStuff;
- (void)goIdle;
- (void)goAttack:(id)what;
- (void)goUp;
- (void)goDown;
- (void)goLeft;
- (void)goRight;
- (void)AttackInDirectionForGuy:(SKNode*)theGuy fromThing:(id)thing;
- (void)removingFire:(id)emit;
@end
