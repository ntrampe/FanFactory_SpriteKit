//
//  ScrollingScene.m
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "ScrollingScene.h"

@interface ScrollingScene (Private)

- (void)updateConstraints;

@end

@implementation ScrollingScene
@synthesize isPanning = m_panning;

- (id)initWithSize:(CGSize)size
{
  self = [super initWithSize:size];
  
  if (self)
  {
    m_touches = [NSMutableArray array];
    m_camera = [SKCameraNode node];
    m_originalSize = size;
    m_velocity = CGPointZero;
    
    [self addChild:m_camera];
    
    self.camera = m_camera;
    
    self.zooms = YES;
    self.bounded = YES;
    self.maxScale = 2.0f;
    self.minScale = 0.5f;
    
    [self updateConstraints];
  }
  
  return self;
}


- (void)didMoveToView:(SKView *)view
{
  [super didMoveToView:view];
  
}


- (void)setZoom:(CGFloat)aZoom
{
  [self.camera setScale:aZoom];
  
  [self updateConstraints];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  m_panning = NO;
  m_touching = YES;
  
  for (UITouch *touch in touches)
    [m_touches addObject:touch];
}


- (void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
  m_panning = YES;
    
  if (m_touches.count > 1 && self.zooms)
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
      if (newScale <= self.maxScale && newScale >= self.minScale)
      {
        [self setZoom:newScale];
        
        CGFloat deltaX = (curPosLayer.x - self.frame.size.width) * (self.camera.xScale - prevScale);
        CGFloat deltaY = (curPosLayer.y - self.frame.size.height) * (self.camera.xScale - prevScale);
        self.camera.position = CGPointMake(self.camera.position.x - deltaX/2.0f, self.camera.position.y - deltaY/2.0f);
      }
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
  m_touching = NO;
  
  for (UITouch *touch in touches)
    [m_touches removeObject:touch];
  
}


- (void)update:(NSTimeInterval)currentTime
{
  [super update:currentTime];
  
  float friction = 0.98f;
  static CGPoint lastPos = (CGPoint){0,0};
  
  if (!m_touching)
  {  
    m_velocity.x *= friction;
    m_velocity.y *= friction;
    
    CGPoint pos = self.camera.position;
    
    pos.x += m_velocity.x;
    pos.y += m_velocity.y;
    
    self.camera.position = pos;
    
    if (fabs(m_velocity.x) <= 0.5 && fabs(m_velocity.y) <= 0.5)
    {
      m_velocity = CGPointMake(0, 0);
    }
  }
  else
  {
    m_velocity.x = (self.camera.position.x - lastPos.x);
    m_velocity.y = (self.camera.position.y - lastPos.y);
  }
  
  lastPos = self.camera.position;
}


- (void)setBounded:(BOOL)bounded
{
  _bounded = bounded;
  
  [self updateConstraints];
}


- (void)updateConstraints
{
  if (!self.bounded)
  {
    [self.camera setConstraints:nil];
    return;
  }
  
  CGSize screenSize = [[UIScreen mainScreen] bounds].size;
  
  CGFloat left = (screenSize.width / 2.0)*self.camera.xScale;
  CGFloat right = m_originalSize.width - (screenSize.width / 2.0)*self.camera.yScale;
  CGFloat bottom = (screenSize.height / 2.0)*self.camera.xScale;
  CGFloat top = m_originalSize.height - (screenSize.height / 2.0)*self.camera.yScale;
  
  //NSLog(@"%.2f, %.2f, %.2f, %.2f", left, right, bottom, top);
  
  [self.camera setConstraints:@[[SKConstraint positionX:[SKRange rangeWithLowerLimit:left
                                                                          upperLimit:right]
                                                      Y:[SKRange rangeWithLowerLimit:bottom
                                                                          upperLimit:top]]]];
}


@end
