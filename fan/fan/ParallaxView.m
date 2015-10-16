//
//  ParallaxView.m
//  fan
//
//  Created by Nicholas Trampe on 9/11/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "ParallaxView.h"

@interface ParallaxView (Private)

- (void)commonInit;

@end

@implementation ParallaxView


- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if (self)
  {
    [self commonInit];
  }
  
  return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  
  if (self)
  {
    [self commonInit];
  }
  
  return self;
}


- (void)commonInit
{
  self.backgroundColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];
  
  m_scene = [ParallaxScene sceneWithSize:self.frame.size];
  
  [self presentScene:m_scene];
}


- (void)addObject:(ParallaxObject*)aObject
{
  [m_scene addObject:aObject];
}


- (void)addObjectWithNode:(SKNode *)aNode position:(CGPoint)aPosition ratio:(CGPoint)aRatio
{
  [m_scene addObjectWithNode:aNode position:aPosition ratio:aRatio];
}


- (void)addContinuousObjectsWithPosition:(CGPoint)aPosition ratio:(CGPoint)aRatio objects:(SKNode*)aFirstObject, ...
{
  [m_scene addContinuousObjectsWithPosition:aPosition ratio:aRatio objects:aFirstObject];
}


- (void)updateWithXPosition:(CGFloat)aPosition
{
  [m_scene updateWithPosition:aPosition];
}


@end
