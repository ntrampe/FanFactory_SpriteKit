//
//  nt_player.m
//  fan
//
//  Created by Nicholas Trampe on 7/26/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_player.h"

@implementation nt_player


+ (instancetype)playerWithPosition:(CGPoint)aPosition
{
  return [[nt_player alloc] initWithPosition:aPosition];
}

- (instancetype)initWithPosition:(CGPoint)aPosition
{
  self = [super initWithImageNamed:@"player.png" position:aPosition angle:0];
  
  if (self)
  {
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2.0f];
    
    self.physicsBody.categoryBitMask = playerCategory;
    self.physicsBody.collisionBitMask = playerCategory | blockCategory | fanCategory;
    self.physicsBody.contactTestBitMask = playerCategory | blockCategory | fanCategory;
    
    float mass = 2.136190966;
    float radius = ((self.frame.size.height*self.xScale/2 - 2));
    self.physicsBody.density = 1.16;//mass/(M_PI*powf(radius, 2));  //1.16
    self.physicsBody.friction = 1.0f;
    self.physicsBody.restitution = 0.4f;
  }
  
  return self;
}

- (id)copyWithZone:(NSZone *)zone
{
  nt_player* copy = [nt_player playerWithPosition:self.position];
  return copy;
}


@end
