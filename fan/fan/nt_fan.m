//
//  nt_fan.m
//  fan
//
//  Created by Nicholas Trampe on 7/24/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_fan.h"

#define FAN_HEIGHT 0.75f
#define WIND_HEIGHT 15.0f
#define DISTANCE_DIVISOR 400
#define MAX_POWER 15
#define FAN_ANIMATION_TAG 99

@implementation nt_fan
@synthesize power = m_power;

+ (instancetype)fanWithPosition:(CGPoint)aPosition angle:(CGFloat)aAngle
{
  return [[nt_fan alloc] initWithPosition:aPosition angle:aAngle];
}


- (instancetype)initWithPosition:(CGPoint)aPosition angle:(CGFloat)aAngle
{
  self = [super initWithImageNamed:@"fan_1.png" position:aPosition angle:aAngle];
  
  if (self)
  {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width - 5, self.size.height - 5)];
    self.physicsBody.dynamic = NO;
    
    self.physicsBody.categoryBitMask = fanCategory;
    self.physicsBody.collisionBitMask = fanCategory | playerCategory | blockCategory;
    self.physicsBody.contactTestBitMask = fanCategory | playerCategory | blockCategory;
    
    m_arrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow.png"];
    m_arrow.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:m_arrow.size];
    m_arrow.physicsBody.dynamic = NO;
    
    m_arrow.physicsBody.categoryBitMask = windCategory;
    m_arrow.physicsBody.collisionBitMask = windCategory | playerCategory;
    m_arrow.physicsBody.contactTestBitMask = windCategory | playerCategory;
    
//    SKPhysicsJointFixed* joint = [SKPhysicsJointFixed jointWithBodyA:self.physicsBody bodyB:m_arrow.physicsBody anchor:self.position];
    m_arrow.position = CGPointMake(0, 10 + self.size.height / 2 + m_arrow.size.height / 2);
    
    [self addChild:m_arrow];
    
    m_arrowLength = m_arrow.frame.size.height;
    m_fanSize = self.frame.size;
    
    [self setPower:1.0f];
  }
  
  return self;
}


- (void)setPower:(float)aPower
{
  m_power = aPower;
  
  float scaleY = m_power/m_arrowLength;
  
  m_arrow.yScale = scaleY;
  m_arrow.position = CGPointMake(0, m_fanSize.height/2 + m_arrowLength*scaleY/2);
}


- (void)setAnimating:(BOOL)isAnimating
{
  if (isAnimating)
  {
//    SKTextureAtlas * fanAtlas = [SKTextureAtlas atlasNamed:@"fan"];
//    NSMutableArray * fanImages = [NSMutableArray array];
//    
//    for (int i = 1; i <= fanAtlas.textureNames.count; i++)
//    {
//      NSString *textureName = [NSString stringWithFormat:@"fan_%i", i];
//      SKTexture *temp = [fanAtlas textureNamed:textureName];
//      [fanImages addObject:temp];
//    }
//    
//    
//    [self runAction:[SKAction repeatActionForever:
//                     [SKAction animateWithTextures:fanImages
//                                      timePerFrame:0.015f
//                                            resize:YES
//                                           restore:YES]] withKey:@"spinning"];
    
    m_arrow.alpha = 0.0f;
  }
  else
  {
    m_arrow.alpha = 1.0f;
    [self removeActionForKey:@"spinning"];
  }
}


- (BOOL)containsWind:(SKPhysicsBody *)aWind
{
  return (m_arrow.physicsBody == aWind);
}


- (void)updateOnObject:(nt_object *)aObject
{
  CGPoint p1 = self.position;
  CGPoint p2 = self.arrowTipLocation;
  
  float distance = sqrtf(powf(p1.x - aObject.position.x, 2) + powf(p1.y - aObject.position.y, 2))/2;
  
  CGVector vec = CGVectorMake(p2.x - p1.x, p2.y - p1.y);
  vec = CGVectorMake(vec.dx / fabs(vec.dx), vec.dy / fabs(vec.dy));
  
  CGVector impulse = CGVectorMake(vec.dx, vec.dy);
  
  impulse = CGVectorMake((impulse.dx * m_power * 0) / distance, (impulse.dy * m_power * 50) / distance);
  
  [aObject.physicsBody applyForce:impulse atPoint:aObject.position];
}


- (CGPoint)arrowTipLocation
{
  CGPoint res = CGPointMake(0, 0);
  double hyp = (double)m_arrow.frame.size.height;
  double ang = self.zRotation;
  double opp = cos(ang) * hyp;
  double adj = sin(ang) * hyp;
  
  res = CGPointMake(self.position.x - adj, self.position.y + opp);
  
  return res;
}


- (BOOL)isTouchOnFan:(UITouch *)aTouch
{
  CGPoint location = [aTouch locationInNode:self.parent];
  CGPoint tip = [self arrowTipLocation];
  float dist = sqrtf(powf(tip.x - location.x, 2) + powf(tip.y - location.y, 2));
  
  if (dist < 65)
  {
    return YES;
  }
  
  return NO;
}


@end
