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
  BOOL m_panning;
  SKCameraNode * m_camera;
}
@property (readonly) BOOL isPanning;
@property (readwrite, nonatomic) float maxScale, minScale;

@end
