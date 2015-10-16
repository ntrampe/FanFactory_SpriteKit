//
//  ParallaxObject.h
//  fan
//
//  Created by Nicholas Trampe on 9/11/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface ParallaxObject : NSObject
{
  CGPoint m_ratio, m_originalPosition;
  __weak SKNode* m_node;
}
@property (weak, nonatomic) SKNode* node;
@property (readwrite, nonatomic) CGPoint ratio, originalPosition;

+ (instancetype)objectWithNode:(SKNode *)aNode position:(CGPoint)aPosition ratio:(CGPoint)aRatio;
- (instancetype)initWithNode:(SKNode *)aNode position:(CGPoint)aPosition ratio:(CGPoint)aRatio;

@end
