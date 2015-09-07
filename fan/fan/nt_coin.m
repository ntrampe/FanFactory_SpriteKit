//
//  nt_coin.m
//  fan
//
//  Created by Nicholas Trampe on 7/28/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_coin.h"

@implementation nt_coin

+ (instancetype)coinWithPosition:(CGPoint)aPosition
{
  return [[nt_coin alloc] initWithPosition:aPosition];
}


- (instancetype)initWithPosition:(CGPoint)aPosition
{
  self = [super initWithImageNamed:@"coin.png" position:aPosition angle:0];
  
  if (self)
  {
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width / 2.0f];
    
    self.physicsBody.categoryBitMask = coinCategory;
    self.physicsBody.collisionBitMask = coinCategory | blockCategory | playerCategory | fanCategory;
    self.physicsBody.contactTestBitMask = coinCategory | blockCategory | playerCategory | fanCategory;
    
    self.physicsBody.dynamic = NO;
  }
  
  return self;
}

@end
