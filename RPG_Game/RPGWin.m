//
//  RPGWin.m
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import "RPGWin.h"
#import "RPGMyScene.h"

@implementation RPGWin
-(void)didMoveToView:(SKView *)view {
    if (!_didCreate)
        [self createStuff];
    _didCreate = YES;
}

- (void)createStuff {
    self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    final = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    final.fontSize = 65;
    final.text = @"YOU WIN!";
    final.fontColor = [SKColor blueColor];
    final.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    [self addChild:final];
                                 
    
}
- (void)mouseDown:(NSEvent *)theEvent {

    SKScene *theScene = [[RPGMyScene alloc] initWithSize:self.size];
    SKTransition *trans = [SKTransition flipHorizontalWithDuration:0.5];
    [self.view presentScene:theScene transition:trans];
}
@end
