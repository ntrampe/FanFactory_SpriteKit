//
//  ParallaxObject.m
//  fan
//
//  Created by Nicholas Trampe on 9/11/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "ParallaxObject.h"

@implementation ParallaxObject
@synthesize node = m_node, originalPosition = m_originalPosition, ratio = m_ratio;

+ (instancetype)objectWithNode:(SKNode *)aNode position:(CGPoint)aPosition ratio:(CGPoint)aRatio
{
  return [[ParallaxObject alloc] initWithNode:aNode position:aPosition ratio:aRatio];
}


- (instancetype)initWithNode:(SKNode *)aNode position:(CGPoint)aPosition ratio:(CGPoint)aRatio
{
  self = [super init];
  
  if (self)
  {
    m_node = aNode;
    m_node.position = CGPointMake(m_node.frame.size.width / 2.0f + aPosition.x, m_node.frame.size.height / 2.0f + aPosition.y);
    m_originalPosition = m_node.position;
    m_ratio = aRatio;
  }
  
  return self;
}


@end
