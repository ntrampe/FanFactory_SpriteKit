//
//  ParallaxScene.m
//  fan
//
//  Created by Nicholas Trampe on 9/11/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "ParallaxScene.h"


@interface ParallaxScene (Private)

- (void)addContinuousObjects:(NSArray *)aObjects position:(CGPoint)aPosition ratio:(CGPoint)aRatio;

@end

@implementation ParallaxScene


- (instancetype)initWithSize:(CGSize)size
{
  self = [super initWithSize:size];
  
  if (self)
  {
    m_objects = [NSMutableArray array];
    self.scaleMode = SKSceneScaleModeResizeFill;
  }
  
  return self;
}


- (void)addObject:(ParallaxObject*)aObject
{
  [self addChild:aObject.node];
  [m_objects addObject:aObject];
}


- (void)addObjectWithNode:(SKNode *)aNode position:(CGPoint)aPosition ratio:(CGPoint)aRatio
{
  ParallaxObject* o = [ParallaxObject objectWithNode:aNode position:aPosition ratio:aRatio];
  [self addObject:o];
}


- (void)addContinuousObjectsWithPosition:(CGPoint)aPosition ratio:(CGPoint)aRatio objects:(SKNode *)aFirstObject, ...
{
  va_list args;
  va_start(args, aFirstObject);
  
  NSMutableArray* argArray = [NSMutableArray array];
  for (SKNode *arg = aFirstObject; arg != nil; arg = va_arg(args, SKNode*))
  {
    [argArray addObject:arg];
  }
  
  va_end(args);
  
  [self addContinuousObjects:argArray position:aPosition ratio:aRatio];
}


- (void)addContinuousObjects:(NSArray *)aObjects position:(CGPoint)aPosition ratio:(CGPoint)aRatio
{
  CGPoint pos = aPosition;
  
  for (SKNode* n in aObjects)
  {
    NSLog(@"%@", NSStringFromCGPoint(pos));
    [self addObjectWithNode:n position:pos ratio:aRatio];
    pos = CGPointMake(pos.x + n.frame.size.width, pos.y);
  }
}


- (void)updateWithVelocity:(CGFloat)aVelocity
{
  for (ParallaxObject* o in m_objects)
  {
    o.node.position = CGPointMake(o.node.position.x + aVelocity * o.ratio.x, o.node.position.y);
    
    if (o.node.position.x > self.frame.size.width + o.node.frame.size.width / 2.0f)
    {
      o.node.position = CGPointMake(-o.node.frame.size.width / 2.0f - o.originalPosition.x, o.node.position.y);
    }
  }
}


- (void)updateWithPosition:(CGFloat)aPosition
{
  for (ParallaxObject* o in m_objects)
  {
    float offset = aPosition * o.ratio.x;
    o.node.position = CGPointMake(o.originalPosition.x + offset, o.node.position.y);
    
    if (o.node.position.x - o.node.frame.size.width / 2.0f > self.frame.size.width)
    {
      o.node.position = CGPointMake(-o.node.frame.size.width / 2.0f, o.node.position.y);
    }
  }
}

@end
