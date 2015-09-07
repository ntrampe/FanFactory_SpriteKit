//
//  LevelScene.h
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ScrollingScene.h"
#import "nt_object.h"
#import "nt_block.h"
#import "nt_coin.h"
#import "nt_fan.h"
#import "nt_level.h"

#define OBJECT_DISTANCE_THRESHOLD 65

@interface LevelScene : ScrollingScene
{
  NSMutableArray * m_objects;
}

+ (instancetype)sceneWithLevel:(nt_level *)aLevel;
- (instancetype)initWithLevel:(nt_level *)aLevel;

- (void)addObject:(nt_object *)aObject;
- (void)removeObject:(nt_object *)aObject;

- (float)angleOnObject:(nt_object *)aObject atPoint:(CGPoint)aPoint;
- (float)distanceFromObject:(nt_object *)aObject atPoint:(CGPoint)aPoint;

- (nt_object *)objectClosestToTouch:(UITouch *)aTouch;

- (NSArray *)objects;
- (NSArray *)fans;
- (NSArray *)blocks;

@end
