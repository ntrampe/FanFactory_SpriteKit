//
//  nt_touch.m
//  fan
//
//  Created by Nicholas Trampe on 7/26/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_touch.h"

@implementation nt_touch
@synthesize object = m_object;
@synthesize touch = m_touch;


+ (instancetype)touchWithObject:(nt_object *)aObject touch:(UITouch *)aTouch
{
  return [[nt_touch alloc] initWithObject:aObject touch:aTouch];
}


- (instancetype)initWithObject:(nt_object *)aObject touch:(UITouch *)aTouch
{
  self = [super init];
  
  if (self)
  {
    m_object = aObject;
    m_touch = aTouch;
  }
  
  return self;
}


@end
