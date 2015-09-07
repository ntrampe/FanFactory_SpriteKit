//
//  LevelEditorViewController.h
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "MenuViewController.h"
#import "ItemSelectionView.h"
#import "LevelEditingScene.h"
#import "nt_touch.h"

@interface LevelEditorViewController : UIViewController
{
  SKView * m_levelView;
}
@property (weak, nonatomic) IBOutlet ItemSelectionView *itemSelectionView;

- (IBAction)buttonPausedPressed:(id)sender;

- (LevelEditingScene *)levelScene;

@end
