//
//  LevelEditingScene.h
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LevelScene.h"
#import "nt_touchEdit.h"

@interface LevelEditingScene : LevelScene
{
  NSMutableArray * m_touchedObjects;
  NSMutableArray * m_selectedObjects;
  
  SKShapeNode* m_bounds;
  
  BOOL m_rectSelection;
  SKShapeNode* m_selectionRectShape;
  CGRect m_selectionRect;
}


- (void)addObject:(nt_object *)aObject atTouch:(UITouch *)aTouch;
- (void)addSelectedObject:(nt_object *)anObject;
- (void)removeSelectedObject:(nt_object *)anObject;

- (void)snapObject:(nt_object *)aObject;

- (void)emptyTrash;

@end
