//
//  ScrollingScene.h
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ScrollingScene : SKScene
{
  NSMutableArray * m_touches;
  SKCameraNode * m_camera;
  BOOL m_panning;
  BOOL m_touching;
  CGPoint m_velocity;
  CGSize m_originalSize;
}
@property (readwrite, nonatomic) BOOL zooms, bounded;
@property (readonly) BOOL isPanning;
@property (readwrite, nonatomic) float maxScale, minScale;

- (void)setZoom:(CGFloat)aZoom;

@end
