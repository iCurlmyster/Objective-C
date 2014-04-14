//
//  RPGBadGuy.m
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import "RPGBadGuy.h"

@implementation RPGBadGuy
- (id)initWithName:(NSString *)myName {
    if (self= [super init]) {
        self.name = myName;
        [self randomStuff];
        [self createFrames];
        [self createStuff];
    }
    return self;
}

- (void)createStuff {
    
    mainGuy = [SKSpriteNode spriteNodeWithTexture:frontView size:CGSizeMake(50, 50)];
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:mainGuy.size];
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.categoryBitMask = EnemyMask;
    self.physicsBody.contactTestBitMask = HeroMask | ObjectMask | WallMask;
    self.physicsBody.collisionBitMask = HeroMask | ObjectMask | WallMask | EnemyMask;
    self.position = CGPointMake(xPos, yPos);
    [self addChild:mainGuy];
}


- (void)createFrames {
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"RPGBadGuyViews"];
    frontView = [atlas textureNamed:@"liazrdEnemyStill"];
    backView = [atlas textureNamed:@"backLizardEnemyStill"];
    leftView = [atlas textureNamed:@"leftLizardEnemyStill"];
    rightView = [atlas textureNamed:@"rightLizardEnemyStill"];
    
}

- (void)randomStuff {
    int thing = arc4random_uniform(4);
    if (thing == 0) {
        xPos = arc4random_uniform(2000);
        yPos = arc4random_uniform(2000);
    } else if (thing == 1)
    {
        xPos = arc4random_uniform(2000);
        yPos = arc4random_uniform(2000);
        
        xPos = -xPos;
        yPos = -yPos;
    } else if (thing == 2) {
        xPos = arc4random_uniform(2000);
        yPos = arc4random_uniform(2000);
        
        yPos = -yPos;
    } else if (thing == 3) {
        xPos = arc4random_uniform(2000);
        yPos = arc4random_uniform(2000);
        
        xPos = -xPos;
        
    }
}

- (void)goIdle {
    
    int thing = arc4random_uniform(2);
    if (thing == 0){
    SKAction *idle = [SKAction sequence:@[[SKAction moveTo:CGPointMake(self.position.x + 10, self.position.y) duration:0.5], [SKAction moveTo:CGPointMake(self.position.x - 10, self.position.y) duration:0.01]]];
        SKAction *rep = [SKAction repeatActionForever:idle];
    [self runAction:rep];
    } else {
        SKAction *idle = [SKAction sequence:@[[SKAction moveTo:CGPointMake(self.position.x, self.position.y - 10) duration:0.5], [SKAction moveTo:CGPointMake(self.position.x, self.position.y + 10) duration:0.01]]];
        SKAction *rep = [SKAction repeatActionForever:idle];
        [self runAction:rep];
    }
    
}

- (void)goAttack:(id)what{
    
    [what  removeFromParent];
}

- (void)goUp {
    SKAction *up = [SKAction moveToY:self.position.y + 10 duration:0.001];
    SKAction *ani = [SKAction animateWithTextures:@[backView] timePerFrame:0.1];
    [mainGuy runAction:ani];
    
    
    [self runAction:up];
}
- (void)goDown {
    SKAction *down = [SKAction moveToY:self.position.y - 10 duration:0.001];
    SKAction *ani = [SKAction animateWithTextures:@[frontView] timePerFrame:0.1];
    [mainGuy runAction:ani];
    [self runAction:down];

}
- (void)goLeft {
    SKAction *left = [SKAction moveToX:self.position.x - 10 duration:0.001];
    SKAction *ani = [SKAction animateWithTextures:@[leftView] timePerFrame:0.1];
    [mainGuy runAction:ani];
    
    [self runAction:left];
}
- (void)goRight {
    SKAction *right = [SKAction moveToX:self.position.x + 10 duration:0.001];
    SKAction *ani = [SKAction animateWithTextures:@[rightView] timePerFrame:0.1];
    [mainGuy runAction:ani];
    
    [self runAction:right];

}
- (void)AttackInDirectionForGuy:(SKNode *)theGuy fromThing:(id)thing {
    
    
    NSString *theString = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
    SKEmitterNode* effect = [NSKeyedUnarchiver unarchiveObjectWithFile:theString];
    effect.position = CGPointMake(self.position.x, self.position.y);
    effect.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
    effect.physicsBody.categoryBitMask = EnemyObject;
    effect.physicsBody.contactTestBitMask = HeroMask;
    effect.physicsBody.collisionBitMask = NoMask;
    
    CGPoint ref = theGuy.position;
    
    
    

    
    [thing addChild:(NSXMLNode*)effect];
    
    SKAction *shot = [SKAction moveTo:ref duration:0.8];
    [effect runAction:shot completion:^(void){
        [effect removeFromParent];
    }];
    
    
}
- (void)removingFire:(id)emit {
    [emit removeFromParent];
}
@end
