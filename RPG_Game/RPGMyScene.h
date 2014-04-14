//
//  RPGMyScene.h
//  RPG_Game
//

//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface RPGMyScene : SKScene
{
    SKLabelNode *myLabel;
    SKLabelNode *pressScreen;
    SKLabelNode *startButton;
    SKLabelNode *optionButton;
    SKSpriteNode *optionsImage;
    SKAction *fade;
    BOOL pressedFirst;
}


@end
