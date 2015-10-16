//
//  nt_fan.h
//  fan
//
//  Created by Nicholas Trampe on 7/24/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_object.h"

@interface nt_fan : nt_object <NSCopying>
{
  float m_power;
  
  // used for setting power
  float m_arrowLength;
  CGSize m_fanSize;
  
  SKSpriteNode* m_arrow;
}
@property (readonly) float power;

+ (instancetype)fanWithPosition:(CGPoint)aPosition angle:(CGFloat)aAngle;
- (instancetype)initWithPosition:(CGPoint)aPosition angle:(CGFloat)aAngle;

- (void)setPower:(float)aPower;
- (void)setAnimating:(BOOL)isAnimating;

- (BOOL)containsWind:(SKPhysicsBody *)aWind;
- (void)updateOnObject:(nt_object *)aObject;

- (CGPoint)arrowTipLocation;
- (BOOL)isTouchOnFan:(UITouch *)aTouch;

@end
