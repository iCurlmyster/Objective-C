//
//  RPGLevelOne.m
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import "RPGLevelOne.h"
#import "RPGLose.h"
#import "RPGWin.h"

@implementation RPGLevelOne
- (void)didMoveToView:(SKView *)view {
    if (!_didCreate)
        [self createScene];
    _didCreate = YES;
}
- (void)createScene {
    self.backgroundColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
    self.anchorPoint = CGPointMake(0.5, 0.5);
    myWorld = [SKNode node];
    myWorld.zPosition = -2.0;
    [self addChild:myWorld];
    
    SKSpriteNode *map = [SKSpriteNode spriteNodeWithImageNamed:@"map"];
    map.position = CGPointMake(0.0, 0.0);
    
    [myWorld addChild:map];
    myWorld.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:map.frame];
    myWorld.physicsBody.categoryBitMask = WallMask;
    myWorld.physicsBody.collisionBitMask = HeroMask | EnemyMask | ObjectMask | EnemyObject;
    
    lives = 5;
    
    if (difficulty == EasyDiff)
        howManyEnemies = 12;
    else if (difficulty == NormalDiff)
        howManyEnemies = 24;
    else if (difficulty == HardDiff)
        howManyEnemies = 39;
    
    [self renderCharacters];
    [self renderObjects];
    [self renderText];
    
    
    
}
#pragma mark - Render
- (void)renderCharacters {
    enemyArray = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < howManyEnemies; i++){
        [enemyArray addObject:[[RPGBadGuy alloc] initWithName:[NSString stringWithFormat:@"Lizard%lu",i]]];
        [myWorld addChild:[enemyArray objectAtIndex:i]];
        [[enemyArray objectAtIndex:i] setPossiblyAlive:YES];
    }
    
    leader = [RPGCharacters node];
    
    [myWorld addChild:leader];
}

- (void)renderText {
    livesText = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    livesText.text = [NSString stringWithFormat:@"Lives: %d", lives];
    livesText.fontColor = [SKColor whiteColor];
    livesText.fontSize = 35;
    livesText.position = CGPointMake(430, 350);
    
    livesText.zPosition = 1.0;
    
    
    enemyCount = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    enemyCount.fontSize = 35;
    enemyCount.text = [NSString stringWithFormat:@"Enemies Killed: %d",killedEnemies];
    enemyCount.fontColor = [SKColor whiteColor];
    enemyCount.position = CGPointMake(200,350);
    
    
    [self addChild:livesText];
    [self addChild:enemyCount];
}

- (void)renderObjects {
    house = [SKSpriteNode spriteNodeWithImageNamed:@"PepperHouse.png"];
    house.size = CGSizeMake(200, 200);
    house.name = @"PHouse";
    house.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:house.size];
    house.physicsBody.allowsRotation = NO;
    house.position = CGPointMake(-1000, -500);
    house.physicsBody.mass = 10000;
    
    [myWorld addChild:house];
}
#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime {
    
    
    
    
    if(_isLeft) {
        [leader goLeft];
    }
    else if (_isDown) {
        [leader goDown];
        
    }
    else if (_isRight) {
        [leader goRight];
    }
    else if (_isUp) {
        [leader goUp];
    }
    if(!_keyIsPressed ) {
        [leader stillFrame:directionOfCharacter];
    }

    for (NSUInteger i = 0; i<howManyEnemies; i++) {
        SKAction *move = [SKAction moveTo:leader.position duration:2.0];
        
        SKSpriteNode *safe = [enemyArray objectAtIndex:i];
        int placeY = safe.position.y - leader.position.y;
        int placeX = safe.position.x - leader.position.x;
        placeX = fabsf(placeX);
        placeY = fabsf(placeY);
        if ((placeX < 400)&&(placeY<400)){
            if ([[enemyArray objectAtIndex:i] possiblyAlive]==YES){
            [[enemyArray objectAtIndex:i] runAction:move];
            
            counter++;
            int thisThing = arc4random_uniform(5);
            if(thisThing == 1){
            if ((counter % 5) == 0){
                [[enemyArray objectAtIndex:i] AttackInDirectionForGuy:leader fromThing:myWorld];
            }}
            }
        }

       
    }
    
    
    
    
    livesText.text = [NSString stringWithFormat:@"Lives: %d", lives];
    enemyCount.text = [NSString stringWithFormat:@"Enemies Killed: %d",killedEnemies];
    
    
}
- (void)judgeDistance {
    
}
#pragma mark - Physics
- (void)didSimulatePhysics {
    [self centerNode:leader];
    [self judgeDistance];
}
- (void)centerNode:(SKNode *)node {
    CGPoint cameraScene = [node.scene convertPoint:node.position fromNode:node.parent];
    node.parent.position = CGPointMake(node.parent.position.x - cameraScene.x, node.parent.position.y - cameraScene.y);
}




- (void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *first, *second;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        first = contact.bodyA;
        second = contact.bodyB;
    } else  {
        first = contact.bodyB;
        second = contact.bodyA;
    }
    if ([leader isAttacking] == YES){
    if ((first.categoryBitMask & HeroMask) != 0 && (second.categoryBitMask & EnemyMask) != 0) {
        [self killHim:(SKSpriteNode *)second.node];
    }
    }
    if ((first.categoryBitMask & HeroMask) != 0 && (second.categoryBitMask & EnemyObject) != 0) {
        [self takeAway:(SKSpriteNode*)first.node];
    }
    if ((first.categoryBitMask & EnemyMask) != 0 && (second.categoryBitMask & ObjectMask) != 0) {
        [self smokeStuff:(SKSpriteNode*)first.node withOther:(SKSpriteNode*)second.node];
    }
    if ((first.categoryBitMask & HeroMask) != 0 && (second.categoryBitMask & EnemyObject) != 0) {
        [self fireStuff:(SKSpriteNode*)first.node withOther:second.node];
    }
}


#pragma mark - Key Events
- (void)keyUp:(NSEvent *)theEvent {
    _keyIsPressed = NO;
    if ([[theEvent characters] isEqualToString:@"w"])
    {
        _isUp = NO;
        [leader stillFrame:directionOfCharacter];
    }
    if ([[theEvent characters] isEqualToString:@"s"]) {
        _isDown = NO;
        [leader stillFrame:directionOfCharacter];
    }
    if ([[theEvent characters] isEqualToString:@"d"]) {
        _isRight = NO;
        [leader stillFrame:directionOfCharacter];
    }
    if ([[theEvent characters] isEqualToString:@"a"]) {
        _isLeft = NO;
        [leader stillFrame:directionOfCharacter];
    }
    
    if ([[theEvent characters] isEqualToString:@"z"]) {
        myWorld.xScale = 1.0;
        myWorld.yScale = 1.0;
    }
    if ([[theEvent characters] isEqualToString:@" "]) {
        [leader setIsAttacking:NO];
        [leader stillFrame:directionOfCharacter];
    }

}
- (void)keyDown:(NSEvent *)theEvent {
    _keyIsPressed = YES;
    if ([[theEvent characters] isEqualToString:@"w"])
    {
        _isUp = YES;
        directionOfCharacter = 'u';
        
    }
    if ([[theEvent characters] isEqualToString:@"s"]) {
        _isDown = YES;
        directionOfCharacter = 'd';
    }
    if ([[theEvent characters] isEqualToString:@"d"]) {
        _isRight = YES;
        directionOfCharacter = 'r';
    }
    if ([[theEvent characters] isEqualToString:@"a"]) {
        _isLeft = YES;
        directionOfCharacter = 'l';
    }
    if ([[theEvent characters] isEqualToString:@"z"]) {
        myWorld.xScale = 0.5;
        myWorld.yScale = 0.5;
    }
    if ([[theEvent characters] isEqualToString:@" "]) {
        [leader setIsAttacking:YES];
        [leader doAction:myWorld withDirection:directionOfCharacter orDestroy:NO];
    }
}
- (void)killHim:(SKSpriteNode *)thing {
    
    for (NSUInteger i = 0; i<howManyEnemies; i++) {
        if (([thing.name isEqualToString:[NSString stringWithFormat:@"Lizard%lu",i]])==YES){
            [thing removeFromParent];
            [[enemyArray objectAtIndex:i] setPossiblyAlive:NO];
            killedEnemies++;

        }
    }
    if (killedEnemies == howManyEnemies){
        
        SKScene *theScene = [[RPGWin alloc] initWithSize:self.size];
        SKTransition *trans = [SKTransition flipHorizontalWithDuration:0.5];
        [self.view presentScene:theScene transition:trans];

    }
    
}
- (void)takeAway:(SKSpriteNode *)yeah {
    
    lives--;
    if (lives <= 0){
        [leader removeFromParent];
        
        SKScene *theScene = [[RPGLose alloc] initWithSize:self.size];
        SKTransition *trans = [SKTransition flipHorizontalWithDuration:0.5];
        [self.view presentScene:theScene transition:trans];

    }
}
- (void)smokeStuff: (SKSpriteNode *)what withOther:(SKSpriteNode *)the{
    
    [the removeFromParent];
    
    for (NSUInteger i = 0; i<howManyEnemies; i++) {
        if (([what.name isEqualToString:[NSString stringWithFormat:@"Lizard%lu",i]])==YES){
            [what removeFromParent];
            [[enemyArray objectAtIndex:i] setPossiblyAlive:NO];
            killedEnemies++;
        }
    }
    if (killedEnemies == howManyEnemies){
        
        SKScene *theScene = [[RPGWin alloc] initWithSize:self.size];
        SKTransition *trans = [SKTransition flipHorizontalWithDuration:0.5];
        [self.view presentScene:theScene transition:trans];

    }
    
}

- (void)fireStuff: (SKSpriteNode *)but withOther:(id)the{
    lives--;
    if (lives <= 0){
        [leader removeFromParent];
        
        [the removeFromParent];
  
        SKScene *theScene = [[RPGLose alloc] initWithSize:self.size];
        SKTransition *trans = [SKTransition flipHorizontalWithDuration:0.5];
        [self.view presentScene:theScene transition:trans];

        
    }
    
    
}
@end
