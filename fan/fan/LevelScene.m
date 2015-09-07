//
//  LevelScene.m
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "LevelScene.h"

@implementation LevelScene


+ (instancetype)sceneWithLevel:(nt_level *)aLevel
{
  return [[LevelScene alloc] initWithLevel:aLevel];
}

- (instancetype)initWithLevel:(nt_level *)aLevel
{
  self = [super initWithSize:CGSizeMake((aLevel != nil ? aLevel.length : 1000), 1000)];
  
  if (self)
  { 
    m_objects = [NSMutableArray array];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.physicsBody.dynamic = NO;
    
    if (aLevel != nil)
    {
      for (nt_object * o in aLevel.objects)
      {
        [self addObject:o];
      }
    }
  }
  
  return self;
}


- (void)addObject:(nt_object *)aObject
{
  [m_objects addObject:aObject];
  [self addChild:[m_objects lastObject]];
}


- (void)removeObject:(nt_object *)aObject
{
  [m_objects removeObject:aObject];
  [aObject removeFromParent];
}


- (float)angleOnObject:(nt_object *)aObject atPoint:(CGPoint)aPoint
{
  CGPoint objPoint = aObject.position;
  CGPoint dt = CGPointMake(objPoint.x - aPoint.x, objPoint.y - aPoint.y);
  
  return atan2(dt.y, dt.x) * 180 / M_PI + 90;
}


- (float)distanceFromObject:(nt_object *)aObject atPoint:(CGPoint)aPoint
{
  CGPoint objPoint = aObject.position;
  
  return sqrtf(powf(objPoint.x - aPoint.x, 2) + powf(objPoint.y - aPoint.y, 2));
}


- (nt_object *)objectClosestToTouch:(UITouch *)aTouch
{
  float closestDist = 1000;
  float newDist = 0;
  nt_object* res = nil;
  
  for (nt_object * o in m_objects)
  {
    newDist = [self distanceFromObject:o atPoint:[aTouch locationInNode:self]];
    if (newDist < closestDist)
    {
      closestDist = newDist;
      res = o;
    }
  }
  
  return res;
}


- (NSArray *)objects
{
  NSArray * res = [NSArray arrayWithArray:m_objects];
  
  return res;
}


- (NSArray *)fans
{
  NSMutableArray * res = [NSMutableArray array];
  
  for (nt_object * o in m_objects)
  {
    if ([o isKindOfClass:[nt_fan class]])
    {
      [res addObject:o];
    }
  }
  
  return res;
}


- (NSArray *)blocks
{
  NSMutableArray * res = [NSMutableArray array];
  
  for (nt_object * o in m_objects)
  {
    if ([o isKindOfClass:[nt_block class]])
    {
      [res addObject:o];
    }
  }
  
  return res;
}




@end
