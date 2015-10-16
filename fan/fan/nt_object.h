//
//  nt_object.h
//  fan
//
//  Created by Nicholas Trampe on 7/24/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "types.h"

@interface nt_object : SKSpriteNode <NSCopying>
{
  SKSpriteNode * m_guide;
  NSString* m_spriteName;
}
@property (strong) SKSpriteNode* guide;

+ (instancetype)objectWithImageNamed:(NSString *)aName position:(CGPoint)aPosition angle:(CGFloat)aAngle;
- (instancetype)initWithImageNamed:(NSString *)aName position:(CGPoint)aPosition angle:(CGFloat)aAngle;

- (void)setGuideEnabled:(BOOL)aEnabled;
- (BOOL)isGuideEnabled;

@end
