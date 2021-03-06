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
  CGSize size = CGSizeMake(1500, 1000);
  
  if (aLevel != nil)
  {
    float highestPoint = 0;
    
    for (nt_object* o in aLevel.objects)
      if (o.position.y > highestPoint)
        highestPoint = o.position.y;
    
    size = CGSizeMake(aLevel.length, MAX(highestPoint, 500) + 100);
  }
  
  self = [super initWithSize:size];
  
  if (self)
  { 
    m_objects = [NSMutableSet set];
    
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
  
  m_goal = [nt_goal goal];
  
  [m_goal setPosition:CGPointMake(self.frame.size.width - m_goal.frame.size.width / 2.0f, m_goal.frame.size.height / 2.0f)];
  
  [self addChild:m_goal];
  
  return self;
}


- (void)addObject:(nt_object *)aObject
{
  [m_objects addObject:aObject];
  [self addChild:aObject];
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


- (nt_level *)level
{
  NSMutableSet* objs = [NSMutableSet set];
  
  for (nt_object* o in m_objects)
  {
    nt_object* oc = [o copy];
    oc.physicsBody = [o.physicsBody copy];
    [objs addObject:oc];
  }
  
  return [nt_level levelWithObjects:[NSSet setWithSet:objs] length:m_originalSize.width];
}


- (NSSet *)objects
{
  NSSet * res = [NSSet setWithSet:m_objects];
  
  return res;
}


- (NSSet *)fans
{
  NSMutableSet * res = [NSMutableSet set];
  
  for (nt_object * o in m_objects)
  {
    if ([o isKindOfClass:[nt_fan class]])
    {
      [res addObject:o];
    }
  }
  
  return res;
}


- (NSSet *)blocks
{
  NSMutableSet * res = [NSMutableSet set];
  
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
