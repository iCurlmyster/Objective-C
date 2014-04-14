//
//  RPGMyScene.m
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import "RPGMyScene.h"
#import "RPGLevelOne.h"
#import "RPGOptionsScreen.h"

@implementation RPGMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"The RPG Game";
        myLabel.fontColor = [SKColor blackColor];
        myLabel.fontSize = 55;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        myLabel.alpha = 0.0;
        
        pressScreen = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        pressScreen.text = @"Click the screen";
        pressScreen.fontColor = [SKColor blackColor];
        pressScreen.fontSize = 35;
        pressScreen.position = CGPointMake(myLabel.position.x, myLabel.position.y - 60);
        pressScreen.alpha = 0.0;
        
        
        
        
        [self addChild:pressScreen];
        [self addChild:myLabel];
        
        SKAction *wait = [SKAction waitForDuration:0.5];
        fade = [SKAction fadeInWithDuration:2.0];
        SKAction *fadePress = [SKAction fadeInWithDuration:4.3];
        
        [myLabel runAction:wait];
        [myLabel runAction:fade];
        [pressScreen runAction:wait];
        [pressScreen runAction:fadePress];
        
    }
    return self;
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
    if (!pressedFirst) {
        [pressScreen removeFromParent];
        SKAction *goUp = [SKAction moveToY:650 duration:0.5];
        [myLabel runAction:goUp];
        
        
        startButton = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        startButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        startButton.fontColor = [SKColor blueColor];
        startButton.fontSize = 45;
        startButton.text = @"Start";
        startButton.alpha = 0.0;
        
        optionButton = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        optionButton.text = @"Options";
        optionButton.fontColor = [SKColor blackColor];
        optionButton.fontSize = 35;
        optionButton.position = CGPointMake(120, 40);
        optionButton.alpha = 0.0;
        
        
        optionsImage = [SKSpriteNode spriteNodeWithImageNamed:@"optionsImage"];
        optionsImage.position = CGPointMake(40, 53);
        optionsImage.size = CGSizeMake(30, 30);
        optionsImage.alpha = 0.0;
        
        
        
        [self addChild:startButton];
        [self addChild:optionButton];
        [self addChild:optionsImage];
        [optionsImage runAction:fade];
        [startButton runAction:fade];
        [optionButton runAction:fade];
        pressedFirst = YES;
    }
    if (CGRectContainsPoint(startButton.frame, location)) {
        SKScene *theScene = [[RPGLevelOne alloc] initWithSize:self.size];
        SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
        [self.view presentScene:theScene transition:doors];
    } if (CGRectContainsPoint(optionsImage.frame, location)) {
        SKScene *theScene = [[RPGOptionsScreen alloc] initWithSize:self.size];
        SKTransition *move = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.5];
        [self.view presentScene:theScene transition:move];
    }
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
