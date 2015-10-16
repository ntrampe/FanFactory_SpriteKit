//
//  nt_goal.m
//  fan
//
//  Created by Nicholas Trampe on 9/9/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_goal.h"

@implementation nt_goal


+ (instancetype)goal
{
  return [[nt_goal alloc] initWithPosition:CGPointMake(0, 0)];
}


+ (instancetype)goalWithPosition:(CGPoint)aPosition
{
  return [[nt_goal alloc] initWithPosition:aPosition];
}

- (instancetype)initWithPosition:(CGPoint)aPosition
{
  self = [super initWithImageNamed:@"goal.png" position:aPosition angle:0];
  
  if (self)
  {
    self.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(-self.frame.size.width / 2.0f, -self.frame.size.height / 2.0f)
                                                    toPoint:CGPointMake(-self.frame.size.width / 2.0f, self.frame.size.height / 2.0f)];
    
    self.physicsBody.categoryBitMask = playerCategory;
    self.physicsBody.collisionBitMask = playerCategory | blockCategory | fanCategory;
    self.physicsBody.contactTestBitMask = playerCategory | blockCategory | fanCategory;
    
  }
  
  return self;
}


- (id)copyWithZone:(NSZone *)zone
{
  nt_goal* copy = [nt_goal goalWithPosition:self.position];
  return copy;
}


@end
