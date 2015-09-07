//
//  nt_object.m
//  fan
//
//  Created by Nicholas Trampe on 7/24/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_object.h"

@implementation nt_object
@synthesize guide = m_guide;

+ (instancetype)objectWithImageNamed:(NSString *)aName position:(CGPoint)aPosition angle:(CGFloat)aAngle
{
  return [[nt_object alloc] initWithImageNamed:aName position:aPosition angle:aAngle];
}


- (instancetype)initWithImageNamed:(NSString *)aName position:(CGPoint)aPosition angle:(CGFloat)aAngle
{
  self = [super initWithImageNamed:aName];
  
  if (self)
  {
    self.position = aPosition;
    self.zRotation = aAngle;
    
    SKPhysicsBody* body = [SKPhysicsBody bodyWithTexture:self.texture size:CGSizeMake(self.size.width-2, self.size.height-2)];
    
    self.physicsBody = body;
    
    m_guide = nil;
  }
  
  return self;
}


- (void)setGuideEnabled:(BOOL)aEnabled
{
  if (aEnabled)
  {
    if (m_guide == nil)
    {
      m_guide = [SKSpriteNode spriteNodeWithImageNamed:@"object_guide.png"];
      
      m_guide.alpha = 0.0f;
      [m_guide setScale:0.5f];
      
      [self addChild:m_guide];
      
      SKAction* fade = [SKAction fadeInWithDuration:0.1f];
      SKAction* scale = [SKAction scaleTo:1.0f duration:0.1f];
      
      [m_guide runAction:fade];
      [m_guide runAction:scale];
      
//      CGFloat duration = 0.1;
//      CGFloat scale = 1.0f;
//      CGFloat alpha = 1.0f;
//      CGFloat initialScale = m_guide.xScale;
//      CGFloat initialAlpha = m_guide.alpha;
//      SKAction *scaleAction = [SKAction customActionWithDuration:duration actionBlock:^(SKNode *node, CGFloat elapsedTime) {
//        CGFloat t = elapsedTime/duration;
//        CGFloat p = t*t;
//        CGFloat s = initialScale*(1-p) + scale * p;
//        CGFloat a = initialAlpha*(1-p) + alpha * p;
//        
//        [node setScale:s];
//        [node setAlpha:a];
//      }];
//      
//      [m_guide runAction:scaleAction];
    }
  }
  else
  {
    if (m_guide != nil)
    {
      SKAction* fade = [SKAction fadeOutWithDuration:0.1f];
      SKAction* scale = [SKAction scaleTo:0.5f duration:0.1f];
      
      [m_guide runAction:fade];
      [m_guide runAction:scale completion:^
      {
        [m_guide removeFromParent];
        m_guide = nil;
      }];
    }
  }
}


- (BOOL)isGuideEnabled
{
  return (m_guide != nil);
}



@end
