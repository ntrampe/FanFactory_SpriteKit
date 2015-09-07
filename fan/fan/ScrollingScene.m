//
//  ScrollingScene.m
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "ScrollingScene.h"

@implementation ScrollingScene
@synthesize isPanning = m_panning;

- (id)initWithSize:(CGSize)size
{
  self = [super initWithSize:size];
  
  if (self)
  {
    m_touches = [NSMutableArray array];
    m_camera = [SKCameraNode node];
    
    self.camera = m_camera;
    
//    [self.camera setScale:0.5];
    
    [self.camera setPosition:CGPointMake(size.width / 2, 60)];
  }
  
  return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  m_panning = NO;
  
  for (UITouch *touch in touches)
    [m_touches addObject:touch];
}


- (void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
  m_panning = YES;
    
  if (m_touches.count > 1)
  {
    UITouch * touch1 = [m_touches objectAtIndex:0];
    UITouch * touch2 = [m_touches objectAtIndex:1];
    CGPoint curPosTouch1 = [touch1 locationInNode:self];
    CGPoint prevPosTouch1 =  [touch1 previousLocationInNode:self];
    CGPoint curPosTouch2 = [touch2 locationInNode:self];
    CGPoint prevPosTouch2 =  [touch2 previousLocationInNode:self];
    //midpoints
    CGPoint curPosLayer = CGPointMake((curPosTouch1.x + curPosTouch2.x) * 0.5f, (curPosTouch1.y + curPosTouch2.y) * 0.5f);
    CGPoint prevPosLayer = CGPointMake((prevPosTouch1.x + prevPosTouch2.x) * 0.5f, (prevPosTouch1.y + prevPosTouch2.y) * 0.5f);
    
    float curDist = sqrtf(powf((curPosTouch2.x - curPosTouch1.x), 2) + powf((curPosTouch2.y - curPosTouch1.y), 2));
    float prevDist = sqrtf(powf((prevPosTouch2.x - prevPosTouch1.x), 2) + powf((prevPosTouch2.y - prevPosTouch1.y), 2));
    
    CGFloat prevScale = self.camera.xScale;
    CGFloat newScale = self.camera.xScale / (curDist / prevDist);
    
    if (newScale != prevScale)
    {
      [self.camera setScale:newScale];
      
      CGFloat deltaX = (curPosLayer.x - self.anchorPoint.x * self.frame.size.width) * (self.camera.xScale - prevScale);
      CGFloat deltaY = (curPosLayer.y - self.anchorPoint.y * self.frame.size.height) * (self.camera.xScale - prevScale);
      self.camera.position = CGPointMake(self.camera.position.x + deltaX, self.camera.position.y + deltaY);
    }
    
    if (!CGPointEqualToPoint(prevPosLayer, curPosLayer))
    {
//      CGPoint percent = CGPointMake(((m_maxStretch.x - m_stretch.x)/m_maxStretch.x), ((m_maxStretch.y - m_stretch.y)/m_maxStretch.y));
      CGPoint delta = CGPointMake((curPosLayer.x - prevPosLayer.x), (curPosLayer.y - prevPosLayer.y));
      CGPoint pos = self.camera.position;
      
      pos.x = pos.x - delta.x;
      pos.y = pos.y - delta.y;
      
      self.camera.position = pos;
    }
  }
  else
  {
    CGPoint location = [[m_touches objectAtIndex:0] locationInNode:self];
    CGPoint prevLocation =  [[m_touches objectAtIndex:0] previousLocationInNode:self];
    CGPoint deltaPos = CGPointMake(location.x - prevLocation.x, location.y - prevLocation.y);
    [self.camera setPosition:CGPointMake(self.camera.position.x - deltaPos.x, self.camera.position.y - deltaPos.y)];
  }
}


- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
  for (UITouch *touch in touches)
    [m_touches removeObject:touch];
}


@end
