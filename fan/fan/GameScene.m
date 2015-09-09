//
//  GameScene.m
//  fan
//
//  Created by Nicholas Trampe on 7/24/15.
//  Copyright (c) 2015 Off Kilter Studios. All rights reserved.
//

#import "GameScene.h"

@interface GameScene (Private)



@end

@implementation GameScene


+ (instancetype)sceneWithLevel:(nt_level *)aLevel
{
  return [[GameScene alloc] initWithLevel:aLevel];
}


- (instancetype)initWithLevel:(nt_level *)aLevel
{
  self = [super initWithLevel:aLevel];
  
  if (self)
  {
    srand((unsigned int)time(NULL));
    
    m_gameTouches = [NSMutableArray array];
    
    self.physicsWorld.contactDelegate = self;
    
    m_player = [nt_player playerWithPosition:CGPointMake(0, 0)];
    [self addObject:m_player];
    
    m_constraintPlayer = [SKConstraint distance:[SKRange rangeWithLowerLimit:50 upperLimit:100] toNode:m_player];
    
    SKShapeNode* bounds = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [bounds setLineWidth:5.0];
    [bounds setStrokeColor:[UIColor darkGrayColor]];
    [self addChild:bounds];
    
    [self setZoom:2.0f];
    
    [self reset];
  }
  
  return self;
}


- (void)didMoveToView:(SKView *)view
{
  [super didMoveToView:view];
  
  
}


- (void)start
{ 
  m_player.physicsBody.dynamic = YES;
  
//  [m_camera runAction:[SKAction scaleTo:2.0f duration:1.0f]];
//  [m_camera runAction:[SKAction moveTo:m_player.position duration:1.0f] completion:^
//  {
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    [m_camera setConstraints:[m_camera.constraints arrayByAddingObject:[SKConstraint distance:[SKRange rangeWithLowerLimit:-screenSize.width upperLimit:screenSize.width] toNode:m_player]]];
//    
//    m_player.physicsBody.dynamic = YES;
//  }];
  
  for (nt_fan * f in self.fans)
  {
    [f setAnimating:YES];
  }
}


- (void)reset
{
  m_player.physicsBody.dynamic = NO;
  m_player.position = CGPointMake(131/2.0f, 238);
  
  [self setZoom:self.camera.xScale];
  
//  self.camera.position = m_player.position;
  
//  [self.camera runAction:[SKAction moveTo:m_player.position duration:1.0f]];
  
  for (nt_fan * f in self.fans)
  {
    [f setAnimating:NO];
  }
}


- (nt_fan *)fanForWindBody:(SKPhysicsBody *)aBody
{
  for (nt_fan * f in self.fans)
  {
    if ([f containsWind:aBody])
    {
      return f;
    }
  }
  
  return nil;
}


- (nt_block *)blockForBody:(SKPhysicsBody *)aBody
{
  for (nt_block * b in self.blocks)
  {
    if (b.physicsBody == aBody)
    {
      return b;
    }
  }
  
  return nil;
}


- (void)didBeginContact:(nonnull SKPhysicsContact *)contact
{
  SKPhysicsBody * bodyA, * bodyB;
  
  bodyA = contact.bodyA;
  bodyB = contact.bodyB;
  
  if ((bodyA.categoryBitMask == playerCategory && bodyB.categoryBitMask == fanCategory) ||
      (bodyA.categoryBitMask == fanCategory && bodyB.categoryBitMask == playerCategory))
  {
    [self reset];
  }
}


- (void)didEndContact:(nonnull SKPhysicsContact *)contact
{
  SKPhysicsBody * bodyA, * bodyB;
  
  bodyA = contact.bodyA;
  bodyB = contact.bodyB;
  
  
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesBegan:touches withEvent:event];
  
  m_panning = NO;
  
  for (UITouch *touch in touches)
  {
    nt_object* o = [self objectClosestToTouch:touch];
    
    if (o != nil && [self distanceFromObject:o atPoint:[touch locationInNode:self]] < OBJECT_DISTANCE_THRESHOLD)
    {
      nt_touch* t = [nt_touch touchWithObject:o touch:touch];
      [m_gameTouches addObject:t];
    }
    
    for (nt_fan* f in self.fans)
    {
      if ([f isTouchOnFan:touch])
      {
        nt_touch* t = [nt_touch touchWithObject:f touch:touch];
        [m_gameTouches addObject:t];
      }
    }
  }
}


- (void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
  m_panning = YES;
  
  for (UITouch *touch in touches)
  {
    nt_touch * objtouch = nil;
    CGPoint location = [touch locationInNode:self];
    CGPoint prevLocation =  [touch previousLocationInNode:self];
    //CGPoint deltaPos = CGPointMake(location.x - prevLocation.x, location.y - prevLocation.y);
    BOOL updateCamera = YES;
    
    for (nt_touch * ot in m_gameTouches)
      if (ot.touch == touch)
        objtouch = ot;
    
    if (objtouch != nil)
    {
      nt_object * obj = objtouch.object;
      float angleInDegrees =      [self angleOnObject:obj atPoint:location];
      float prevAngleInDegrees =  [self angleOnObject:obj atPoint:prevLocation];
      float distance =            [self distanceFromObject:obj atPoint:location];
      float changeInAngle =       angleInDegrees - prevAngleInDegrees;
      
      if ([obj isKindOfClass:[nt_fan class]])
      {
        nt_fan* f = (nt_fan *)obj;
        
        if (distance > OBJECT_DISTANCE_THRESHOLD)
        {
          [f setZRotation:f.zRotation + changeInAngle*(M_PI/180)];
        }
        else
        {
          [f setZRotation:angleInDegrees*(M_PI/180)];
        }
        
        [f setPower:distance];
        
        updateCamera = NO;
      }
    }
    
    if (updateCamera)
    {
      [super touchesMoved:touches withEvent:event];
    }
  }
}


- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
  [super touchesEnded:touches withEvent:event];
  
  if (m_panning == NO)
  { 
    for (UITouch *touch in touches)
    {
      nt_touch * objtouch = nil;
      
      for (nt_touch * ot in m_gameTouches)
        if (ot.touch == touch)
          objtouch = ot;
      
      if (objtouch != nil)
      {
        [m_gameTouches removeObject:objtouch];
      }
      
//      CGPoint location = [touch locationInNode:self];
//      SKNode* n = [self nodeAtPoint:location];
//      
//      if (n != nil && [n isKindOfClass:[nt_block class]])
//      {
//        n.physicsBody.dynamic = !n.physicsBody.dynamic;
//      }
//      else
//      {
//        nt_block* b = [nt_block blockWithType:rand() % 7 position:location angle:0];
//        [self addObject:b];
//        
////        nt_coin* c = [nt_coin coinWithPosition:location];
////        [self addObject:c];
//      }
    }
  }
}


- (void)update:(CFTimeInterval)currentTime
{
  [super update:currentTime];
  
  NSArray* bodies = m_player.physicsBody.allContactedBodies;
  
  for (SKPhysicsBody* b in bodies)
  {
    nt_fan* f = [self fanForWindBody:b];
    
    if (f != nil)
    {
      [f updateOnObject:m_player];
    }
  }
}


@end
