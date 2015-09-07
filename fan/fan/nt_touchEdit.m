//
//  nt_touchEdit.m
//  fan
//
//  Created by Nicholas Trampe on 9/7/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_touchEdit.h"

@implementation nt_touchEdit


+ (instancetype)touchWithObject:(nt_object *)aObject touch:(UITouch *)aTouch
{
  return [[nt_touchEdit alloc] initWithObject:aObject touch:aTouch editingType:kEditingTypeNone];
}


- (instancetype)initWithObject:(nt_object *)aObject touch:(UITouch *)aTouch
{
  return [self initWithObject:aObject touch:aTouch editingType:kEditingTypeNone];
}


+ (instancetype)touchWithObject:(nt_object *)aObject touch:(UITouch *)aTouch editingType:(kEditingType)aEditingType
{
  return [[nt_touchEdit alloc] initWithObject:aObject touch:aTouch editingType:aEditingType];
}


- (instancetype)initWithObject:(nt_object *)aObject touch:(UITouch *)aTouch editingType:(kEditingType)aEditingType
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
