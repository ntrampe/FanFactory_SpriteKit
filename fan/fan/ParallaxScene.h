//
//  ParallaxScene.h
//  fan
//
//  Created by Nicholas Trampe on 9/11/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "ParallaxObject.h"

@interface ParallaxScene : SKScene
{
  NSMutableArray* m_objects;
}

- (void)addObject:(ParallaxObject*)aObject;
- (void)addObjectWithNode:(SKNode *)aNode position:(CGPoint)aPosition ratio:(CGPoint)aRatio;
- (void)addContinuousObjectsWithPosition:(CGPoint)aPosition ratio:(CGPoint)aRatio objects:(SKNode*)aFirstObject, ...;

- (void)updateWithVelocity:(CGFloat)aVelocity;
- (void)updateWithPosition:(CGFloat)aPosition;

@end
