//
//  RPGOptionsScreen.m
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import "RPGOptionsScreen.h"
#import "RPGMyScene.h"

@implementation RPGOptionsScreen
- (void)didMoveToView:(SKView *)view {

    if (!_didStart)
        [self createStuff];
    _didStart = YES;
}
- (void)createStuff {
    
    self.backgroundColor = [SKColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    diff = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    diff.fontSize = 45;
    diff.fontColor = [SKColor blueColor];
    diff.text = @"Starting Difficulty:";
    diff.position = CGPointMake(250, CGRectGetMidY(self.frame));
    
    theDiffText = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    theDiffText.fontSize = 45;
    theDiffText.fontColor = [SKColor blueColor];
    theDiffText.position = CGPointMake(700, CGRectGetMidY(self.frame));
    
    leftArr = [SKSpriteNode spriteNodeWithImageNamed:@"LeftArrow"];
    leftArr.size = CGSizeMake(40, 40);
    leftArr.position = CGPointMake(theDiffText.position.x - 120, theDiffText.position.y);
    
    rightArr = [SKSpriteNode spriteNodeWithImageNamed:@"RightArrow"];
    rightArr.size = CGSizeMake(40, 40);
    rightArr.position = CGPointMake(theDiffText.position.x + 120, theDiffText.position.y);
    
    optionsImage = [SKSpriteNode spriteNodeWithImageNamed:@"optionsImage"];
    optionsImage.position = CGPointMake(40, 53);
    optionsImage.size = CGSizeMake(30, 30);

    
    NSTextField *myText = [[NSTextField alloc] initWithFrame:NSMakeRect(100,100, 40, 40)];
    
    [self.view addSubview:myText];
    [self addChild:optionsImage];
    [self addChild:leftArr];
    [self addChild:rightArr];
    [self addChild:diff];
    [self addChild:theDiffText];
}
-(void)update:(NSTimeInterval)currentTime
{
    if (difficulty == EasyDiff){
        theDiffText.text = @"easy";
    } else if (difficulty == NormalDiff) {
        theDiffText.text = @"normal";
    } else if (difficulty == HardDiff) {
        theDiffText.text = @"hard";
    }
    if (difficulty == 0)
        [leftArr setAlpha:0.0];
    if (difficulty == 2)
        [rightArr setAlpha:0.0];
    if (difficulty > 0)
        [leftArr setAlpha:1.0];
    if (difficulty < 2)
        [rightArr setAlpha:1.0];

    
}
- (void)mouseDown:(NSEvent *)theEvent {

    CGPoint location = [theEvent locationInNode:self];
    if (CGRectContainsPoint(leftArr.frame,location )){
        if(difficulty>0){
            difficulty--;
        }
        
    }
    if (CGRectContainsPoint(rightArr.frame, location)) {
        if (difficulty <2)
            difficulty++;
    }
    if (CGRectContainsPoint(optionsImage.frame, location)) {
        SKScene *theScene = [[RPGMyScene alloc] initWithSize:self.size];
        SKTransition *move = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.5];
        [self.view presentScene:theScene transition:move];
    }

}
@end
