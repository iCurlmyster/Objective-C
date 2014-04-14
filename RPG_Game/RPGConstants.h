//
//  RPGConstants.h
//  RPG_Game
//
//  Created by Joshua Matthews on 3/1/14.
//  Copyright (c) 2014 Joshua Matthews. All rights reserved.
//

#ifndef RPG_Game_RPGConstants_h
#define RPG_Game_RPGConstants_h

enum {
    NoMask = 0,
    HeroMask = 1,
    EnemyMask = 2,
    ObjectMask = 4,
    EnemyObject = 8,
    WallMask = 32
};

enum {
    EasyDiff = 0,
    NormalDiff,
    HardDiff
};

static unsigned int lives;
static unsigned int difficulty = NormalDiff;
static unsigned int killedEnemies = 0;

#endif
