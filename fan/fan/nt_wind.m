//
//  nt_wind.m
//  fan
//
//  Created by Nicholas Trampe on 7/27/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_wind.h"

@implementation nt_wind
@synthesize object = m_object;
@synthesize fan = m_fan;


+ (instancetype)windWithObject:(nt_object *)aObject fan:(nt_fan *)aFan
{
  return [[nt_wind alloc] initWithObject:aObject fan:aFan];
}


- (instancetype)initWithObject:(nt_object *)aObject fan:(nt_fan *)aFan
{
  self = [super init];
  
  if (self)
  {
    m_object = aObject;
    m_fan = aFan;
  }
  
  return self;
}


- (void)blow
{
  [m_fan updateOnObject:m_object];
}


@end
