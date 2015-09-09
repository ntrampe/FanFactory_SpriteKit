//
//  GameScene.h
//  fan
//

//  Copyright (c) 2015 Off Kilter Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LevelScene.h"
#import "nt_object.h"
#import "nt_player.h"
#import "nt_block.h"
#import "nt_coin.h"
#import "nt_fan.h"
#import "nt_touch.h"
#import "nt_level.h"

@interface GameScene : LevelScene <SKPhysicsContactDelegate>
{
  NSMutableArray * m_gameTouches;
  
  nt_player* m_player;
  SKConstraint* m_constraintPlayer;
}


- (void)start;
- (void)reset;

- (nt_fan *)fanForWindBody:(SKPhysicsBody *)aBody;
- (nt_block *)blockForBody:(SKPhysicsBody *)aBody;

@end
