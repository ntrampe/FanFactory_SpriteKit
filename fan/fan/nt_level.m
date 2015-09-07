//
//  nt_level.m
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_level.h"

#import "nt_object.h"
#import "nt_fan.h"
#import "nt_block.h"
#import "nt_coin.h"

@implementation nt_level
@synthesize length = m_length;
@synthesize objects = m_objects;

+ (instancetype)levelWithObjects:(NSArray *)aObjects length:(float)aLength
{
  return [[nt_level alloc] initWithObjects:aObjects length:aLength];
}


+ (instancetype)levelWithDictionary:(NSDictionary *)aDictionary
{
  return [[nt_level alloc] initWithDictionary:aDictionary];
}


- (instancetype)initWithObjects:(NSArray *)aObjects length:(float)aLength
{
  self = [super init];
  
  if (self)
  {
    m_objects = [NSMutableArray arrayWithArray:aObjects];
    m_length = aLength;
  }
  
  return self;
}


- (instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
  self = [super init];
  
  if (self)
  {
    m_length = [[aDictionary objectForKey:@"length"] floatValue];
    m_objects = [NSMutableArray array];
    
    NSArray * objs = [aDictionary objectForKey:@"objects"];
    
    for (NSDictionary * d in objs)
    {
      NSString * name = [d objectForKey:@"name"];
      CGPoint pos = CGPointMake([[d objectForKey:@"x"] floatValue], [[d objectForKey:@"y"] floatValue]);
      float angle = [[d objectForKey:@"angle"] floatValue];
      
      if ([name isEqualToString:@"fan"])
      {
        nt_fan * f = [nt_fan fanWithPosition:pos angle:angle];
        
        [f setPower:[[d objectForKey:@"power"] floatValue]];
        
        [m_objects addObject:f];
      }
      else if ([name isEqualToString:@"block"])
      {
        nt_block * b = [nt_block blockWithType:(kBlockType)[[d objectForKey:@"type"] integerValue] position:pos angle:angle];
        
        [m_objects addObject:b];
      }
      else if ([name isEqualToString:@"coin"])
      {
        nt_coin * c = [nt_coin coinWithPosition:pos];
        
        [m_objects addObject:c];
      }
    }
  }
  
  return self;
}


@end
