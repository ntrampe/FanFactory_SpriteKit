//
//  LevelEditingScene.m
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "LevelEditingScene.h"

#define GUIDE_SIZE 65
#define GUIDE_HOLD_WIDTH 20

@interface LevelEditingScene (Private)



@end

@implementation LevelEditingScene


+ (instancetype)sceneWithLevel:(nt_level *)aLevel
{
  return [[LevelEditingScene alloc] initWithLevel:aLevel];
}


- (instancetype)initWithLevel:(nt_level *)aLevel
{
  self = [super initWithLevel:aLevel];
  
  if (self)
  {
    m_touchedObjects = [NSMutableArray array];
    m_selectedObjects = [NSMutableArray array];
    
    m_bounds = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [m_bounds setLineWidth:5.0];
    [self addChild:m_bounds];
  }
  
  return self;
}


- (void)addObject:(nt_object *)aObject atTouch:(UITouch *)aTouch
{
  for (nt_object* o in m_selectedObjects)
  {
    [o setGuideEnabled:NO];
  }
  
  [self addObject:aObject];
  
  [aObject setGuideEnabled:YES];
  [m_selectedObjects removeAllObjects];
  [self addSelectedObject:aObject];
  
  nt_touchEdit* t = [nt_touchEdit touchWithObject:aObject touch:aTouch];
  [m_touchedObjects addObject:t];
}


- (void)addSelectedObject:(nt_object *)anObject
{
  if (  anObject != nil &&
      [m_objects containsObject:anObject] &&
      ! [m_selectedObjects containsObject:anObject]
      )
  {
    [m_selectedObjects addObject:anObject];
  }
}


- (void)removeSelectedObject:(nt_object *)anObject
{
  if (  anObject != nil &&
      [m_objects containsObject:anObject] &&
      [m_selectedObjects containsObject:anObject]
      )
  {
    [m_selectedObjects removeObject:anObject];
  }
}


- (void)snapObject:(nt_object *)aObject
{
  CGPoint newPos = aObject.position;
  float newAngle = aObject.zRotation;
  CGSize grid = CGSizeMake(10, 10);
  float angleThresh = 45 / 57.2957795;
  
  newPos.x /= grid.width;
  newPos.y /= grid.height;
  
  newPos.x = roundf(newPos.x);
  newPos.y = roundf(newPos.y);
  
  newPos.x *= grid.width;
  newPos.y *= grid.height;
  
  newAngle /= angleThresh;
  
  newAngle = roundf(newAngle);
  
  newAngle *= angleThresh;
  
  [aObject runAction:[SKAction moveTo:newPos duration:0.1]];
  [aObject runAction:[SKAction rotateToAngle:newAngle duration:0.1]];
}


- (void)emptyTrash
{
  for (nt_object* o in m_selectedObjects)
    [self removeObject:o];
  
  [m_selectedObjects removeAllObjects];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesBegan:touches withEvent:event];
  
  for (UITouch * touch in touches)
  {
    nt_object* o = [self objectClosestToTouch:touch];
    
    if (o != nil && [self distanceFromObject:o atPoint:[touch locationInNode:self]] <= GUIDE_SIZE)
    {
      nt_touchEdit* t = [nt_touchEdit touchWithObject:o touch:touch];
      
      t.editingType = kEditingTypeNone;
      
      [m_touchedObjects addObject:t];
    }
  }
}


- (void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
  BOOL updateCamera = NO;
  m_panning = YES;
  
  if (touches.count == 3 || m_rectSelection)
  {
    if (touches.count == 3)
    {
      CGPoint avgLoc = CGPointMake(0, 0);
      
      for (UITouch * touch in touches.allObjects)
      {
        CGPoint loc = [touch locationInNode:self];
        
        avgLoc = CGPointMake(avgLoc.x + loc.x, avgLoc.y + loc.y);
      }
      
      avgLoc.x /= touches.count;
      avgLoc.y /= touches.count;
      
      if (!m_rectSelection)
      {
        m_selectionRectShape = [SKShapeNode shapeNodeWithRectOfSize:CGSizeZero];
        [m_selectionRectShape setLineWidth:3.0];
        [self addChild:m_selectionRectShape];
        
        m_selectionRect.origin = avgLoc;
        m_rectSelection = YES;
      }
      
      m_selectionRect.size = CGSizeMake(avgLoc.x - m_selectionRect.origin.x, avgLoc.y - m_selectionRect.origin.y);
      
      CGPathRef rect = CGPathCreateWithRect(m_selectionRect, NULL);
      CGFloat ellipseWidth = 5;
      CGFloat pattern[2];
      pattern[0] = 10.0;
      pattern[1] = 10.0;
      CGPathRef dashed =
      CGPathCreateCopyByDashingPath(rect,
                                    NULL,
                                    0,
                                    pattern,
                                    2);
      
      CGMutablePathRef mut = CGPathCreateMutableCopy(dashed);
      
      CGPathAddEllipseInRect(mut, NULL, CGRectMake(m_selectionRect.origin.x - ellipseWidth / 2.0f, m_selectionRect.origin.y - ellipseWidth / 2.0f, ellipseWidth, ellipseWidth));
      CGPathAddEllipseInRect(mut, NULL, CGRectMake(m_selectionRect.origin.x + m_selectionRect.size.width - ellipseWidth / 2.0f, m_selectionRect.origin.y - ellipseWidth / 2.0f, ellipseWidth, ellipseWidth));
      CGPathAddEllipseInRect(mut, NULL, CGRectMake(m_selectionRect.origin.x - ellipseWidth / 2.0f, m_selectionRect.origin.y + m_selectionRect.size.height - ellipseWidth / 2.0f, ellipseWidth, ellipseWidth));
      CGPathAddEllipseInRect(mut, NULL, CGRectMake(m_selectionRect.origin.x + m_selectionRect.size.width - ellipseWidth / 2.0f, m_selectionRect.origin.y + m_selectionRect.size.height - ellipseWidth / 2.0f, ellipseWidth, ellipseWidth));
      
      [m_selectionRectShape setPath:mut];
    }
  }
  else if (touches.count == 1)
  {
    if (m_touchedObjects.count > 0)
    { 
      for (UITouch *touch in touches)
      {
        nt_touchEdit * objtouch = nil;
        CGPoint location = [touch locationInNode:self];
        CGPoint prevLocation =  [touch previousLocationInNode:self];
        CGPoint deltaPos = CGPointMake(location.x - prevLocation.x, location.y - prevLocation.y);
        
        for (nt_touchEdit * ot in m_touchedObjects)
          if (ot.touch == touch)
            objtouch = ot;
        
        if (objtouch != nil && [m_selectedObjects containsObject:objtouch.object])
        {
          nt_object * obj = objtouch.object;
          float angleInDegrees =      [self angleOnObject:obj atPoint:location];
          float prevAngleInDegrees =  [self angleOnObject:obj atPoint:prevLocation];
          float distance = [self distanceFromObject:obj atPoint:location];
          float changeInAngle =       angleInDegrees - prevAngleInDegrees;
          
          if (objtouch.editingType == kEditingTypeNone)
          {
            if (distance < GUIDE_SIZE - GUIDE_HOLD_WIDTH)
            {
              objtouch.editingType = kEditingTypeTranslating;
            }
            else
            {
              objtouch.editingType = kEditingTypeRotating;
            }
          }
          
          for (nt_object* o in m_selectedObjects)
          {
            if (objtouch.editingType == kEditingTypeTranslating)
            {
              o.position = CGPointMake(o.position.x + deltaPos.x, o.position.y + deltaPos.y);
            }
            else if (objtouch.editingType == kEditingTypeRotating)
            {
              [o setZRotation:o.zRotation + changeInAngle*(M_PI/180)];
            }
          }
        }
        else
        {
          updateCamera = YES;
        }
      }
    }
    else
    {
      updateCamera = YES;
    }
  }
  else if (touches.count == 2)
  {
    updateCamera = YES;
  }
  
  if (updateCamera)
  {
    [super touchesMoved:touches withEvent:event];
  }
}


- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
  [super touchesEnded:touches withEvent:event];
  
  if (!self.isPanning)
  {
    for (UITouch * touch in touches)
    {
      nt_object * obj = nil;
      for (nt_touchEdit * ot in m_touchedObjects)
        if (ot.touch == touch)
          obj = ot.object;
      
      for (nt_object* o in m_selectedObjects)
        [o setGuideEnabled:NO];
      [m_selectedObjects removeAllObjects];
      
      if (obj != nil)
      {
        if (!obj.isGuideEnabled)
        {
          [obj setGuideEnabled:YES];
          [self addSelectedObject:obj];
        }
      }
    }
  }
  
  for (nt_object* o in m_selectedObjects)
  {
    [self snapObject:o];
  }
  
  if (m_rectSelection)
  {
    for (nt_object* o in self.objects)
    {
      if (CGRectContainsPoint(m_selectionRect, o.position))
      {
        [o setGuideEnabled:YES];
        [self addSelectedObject:o];
      }
    }
    
    if (m_selectionRectShape != nil)
    {
      [m_selectionRectShape removeFromParent];
      m_selectionRectShape = nil;
    }
    
    m_rectSelection = NO;
  }
  
  for (UITouch * touch in touches)
  {
    for (nt_touchEdit * t in m_touchedObjects)
    {
      if (t.touch == touch)
      {
        [m_touchedObjects removeObject:t]; 
        break;
      }
    }
  }
}


@end
