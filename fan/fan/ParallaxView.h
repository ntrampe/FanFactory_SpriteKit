//
//  ParallaxView.h
//  fan
//
//  Created by Nicholas Trampe on 9/11/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

#import "ParallaxScene.h"

@interface ParallaxView : SKView
{
  ParallaxScene* m_scene;
}

- (void)addObject:(ParallaxObject*)aObject;
- (void)addObjectWithNode:(SKNode *)aNode position:(CGPoint)aPosition ratio:(CGPoint)aRatio;
- (void)addContinuousObjectsWithPosition:(CGPoint)aPosition ratio:(CGPoint)aRatio objects:(SKNode*)aFirstObject, ...;

- (void)updateWithXPosition:(CGFloat)aPosition;

@end
