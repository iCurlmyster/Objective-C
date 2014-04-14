//
//  RPGLose.h
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface RPGLose : SKScene
{
    SKLabelNode *final;
}
@property BOOL didCreat;
-(void)didMoveToView:(SKView *)view;
- (void)createStuff;
- (void)mouseDown:(NSEvent *)theEvent;

@end
