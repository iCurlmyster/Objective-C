//
//  RPGCharacters.m
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import "RPGCharacters.h"

@implementation RPGCharacters
- (id)init {
    if (self = [super init]) {
        [self createFrames];
        [self createStuff];
    }
    return self;
}

- (void)createStuff {
    mainGuy = [SKSpriteNode spriteNodeWithTexture:_frontStill size:CGSizeMake(40, 40)];
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:mainGuy.size];
    self.physicsBody.categoryBitMask = HeroMask;
    self.physicsBody.collisionBitMask = EnemyMask | WallMask;
    self.physicsBody.contactTestBitMask = EnemyMask | ObjectMask;
    self.physicsBody.allowsRotation = NO;
    
    
    _isAlive = YES;
    
    [self addChild:mainGuy];
}

- (void)createFrames {
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"RPGGoodFrontView"];
    _frontStill = [atlas textureNamed:@"frontViewStill"];
    _frontWalk1 = [atlas textureNamed:@"frontViewLeg0"];
    _frontWalk2 = [atlas textureNamed:@"frontViewLeg1"];
    _frontAttack = [atlas textureNamed:@"frontViewAttack"];
    
    SKTextureAtlas *backAtlas = [SKTextureAtlas atlasNamed:@"RPGGoodBackView"];
    _backStill = [backAtlas textureNamed:@"backViewStill"];
    _backWalk1 = [backAtlas textureNamed:@"backViewLeg0"];
    _backWalk2 = [backAtlas textureNamed:@"backViewLeg1"];
    _backAttack = [backAtlas textureNamed:@"backViewAttack"];
    
    SKTextureAtlas *leftAtlas = [SKTextureAtlas atlasNamed:@"RPGGoodLeftView"];
    _leftStill = [leftAtlas textureNamed:@"leftSideViewStill"];
    _leftWalk1 = [leftAtlas textureNamed:@"leftSideViewLeg0"];
    _leftWalk2 = [leftAtlas textureNamed:@"leftSideViewLeg1"];
    _leftAttack = [leftAtlas textureNamed:@"leftSideAttack"];
    
    SKTextureAtlas *rightAtlas = [SKTextureAtlas atlasNamed:@"RPGGoodRightView"];
    _rightStill = [rightAtlas textureNamed:@"rightSideViewStill"];
    _rightWalk1 = [rightAtlas textureNamed:@"rightSideViewLeg0"];
    _rightWalk2 = [rightAtlas textureNamed:@"rightSideViewLeg1"];
    _rightAttack = [rightAtlas textureNamed:@"rightSideAttack"];
    
    
}

- (void)stillFrame:(char)direction {
    if (direction == 'd') {
        SKAction *still = [SKAction animateWithTextures:@[_frontStill] timePerFrame:0.001];
        [mainGuy runAction:still];
        
    } else if (direction == 'u') {
        SKAction *still = [SKAction animateWithTextures:@[_backStill] timePerFrame:0.001];
        [mainGuy runAction:still];
        
    } else if (direction == 'l') {
        SKAction *still = [SKAction animateWithTextures:@[_leftStill] timePerFrame:0.001];
        [mainGuy runAction:still];
    
    } else if (direction == 'r') {
        SKAction *still = [SKAction animateWithTextures:@[_rightStill] timePerFrame:0.001];
        [mainGuy runAction:still];
    
    }
}

- (void)goDown {
    SKAction *down = [SKAction moveToY:self.position.y - 10 duration:0.001];
    SKAction *ani = [SKAction animateWithTextures:@[_frontWalk1] timePerFrame:0.1];
    [mainGuy runAction:ani];
    [self runAction:down];
}
- (void)goLeft {
    SKAction *left = [SKAction moveToX:self.position.x - 10 duration:0.001];
    SKAction *ani = [SKAction animateWithTextures:@[_leftWalk1] timePerFrame:0.1];
    [mainGuy runAction:ani];

    [self runAction:left];
}
- (void)goRight {
    SKAction *right = [SKAction moveToX:self.position.x + 10 duration:0.001];
    SKAction *ani = [SKAction animateWithTextures:@[_rightWalk1] timePerFrame:0.1];
    [mainGuy runAction:ani];

    [self runAction:right];
}
- (void)goUp {
    SKAction *up = [SKAction moveToY:self.position.y + 10 duration:0.001];
    SKAction *ani = [SKAction animateWithTextures:@[_backWalk1] timePerFrame:0.1];
    [mainGuy runAction:ani];

    
    [self runAction:up];
    
}

- (void)AttackInDirection:(char)direction {
    
    if (direction == 'u'){
        anim = [SKAction animateWithTextures:@[_backAttack,_backWalk1,_backWalk2] timePerFrame:0.5];
        [mainGuy runAction:anim];
    } else if (direction == 'd'){
        anim = [SKAction animateWithTextures:@[_frontAttack] timePerFrame:0.1];
        [mainGuy runAction:anim];
    } else if (direction == 'r'){
        anim = [SKAction animateWithTextures:@[_rightAttack] timePerFrame:0.1];
        [mainGuy runAction:anim];
    } else if (direction == 'l'){
        anim = [SKAction animateWithTextures:@[_leftAttack] timePerFrame:0.1];
        [mainGuy runAction:anim];
    }



}

- (void)doAction:(id)fromThing withDirection:(char)direction orDestroy:(BOOL)isIt {
    NSString *emit = [[NSBundle mainBundle] pathForResource:@"SmokeStuff" ofType:@"sks"];
    SKEmitterNode* doIt = [NSKeyedUnarchiver unarchiveObjectWithFile:emit];
    doIt.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:7];
    doIt.physicsBody.categoryBitMask = ObjectMask;
    doIt.physicsBody.contactTestBitMask = EnemyMask;
    doIt.physicsBody.collisionBitMask = NoMask;
    doIt.position = CGPointMake(self.position.x, self.position.y);
    
    if (direction == 'u'){
        
        
        [fromThing addChild:(NSXMLNode*)doIt];
        SKAction *doStuff = [SKAction waitForDuration:2.0];
        [doIt runAction:doStuff completion:^(void){
            [doIt removeFromParent];
        }];
    }
    if (direction == 'r') {
        SKAction *doStuff = [SKAction waitForDuration:2.0];
        [doIt runAction:doStuff completion:^(void){
            [doIt removeFromParent];
        }];

        [fromThing addChild:(NSXMLNode*)doIt];
    }
    if (direction == 'l') {
        SKAction *doStuff = [SKAction waitForDuration:2.0];
        [doIt runAction:doStuff completion:^(void){
            [doIt removeFromParent];
        }];

        [fromThing addChild:(NSXMLNode*)doIt];
    }
    if (direction == 'd') {
        SKAction *doStuff = [SKAction waitForDuration:2.0];
        [doIt runAction:doStuff completion:^(void){
            [doIt removeFromParent];
        }];

        [fromThing addChild:(NSXMLNode*)doIt];
    }
    
    
    if (isIt){
        [doIt removeFromParent];
    }
    
    
}



@end
