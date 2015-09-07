//
//  GameViewController.h
//  fan
//

//  Copyright (c) 2015 Off Kilter Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

#import "nt_alert.h"

@class nt_level;

@interface GameViewController : UIViewController
{
  SKView * m_gameView;
  nt_level* m_level;
}

- (void)setLevel:(nt_level *)aLevel;

- (IBAction)pausedPressed:(id)sender;
- (IBAction)startPressed:(id)sender;
- (IBAction)retryPressed:(id)sender;

@end
