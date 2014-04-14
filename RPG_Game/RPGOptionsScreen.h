//
//  RPGOptionsScreen.h
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "RPGConstants.h"

@interface RPGOptionsScreen : SKScene {
    SKLabelNode *diff;
    SKLabelNode *theDiffText;
    SKSpriteNode *leftArr, *rightArr, *optionsImage;
}
@property BOOL didStart;
- (void)didMoveToView:(SKView *)view;
- (void)createStuff;
- (void)mouseDown:(NSEvent *)theEvent;


@end
