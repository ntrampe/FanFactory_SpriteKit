//
//  LevelEditorViewController.m
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "LevelEditorViewController.h"
#import "GameViewController.h"
#import "nt_block.h"
#import "nt_alert.h"

@interface LevelEditorViewController ()

@end

@implementation LevelEditorViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  m_levelView = [[SKView alloc] initWithFrame:self.view.frame];
  m_levelView.showsFPS = YES;
  m_levelView.showsNodeCount = YES;
  m_levelView.ignoresSiblingOrder = YES;
  m_levelView.multipleTouchEnabled = YES;
  m_levelView.backgroundColor = [UIColor clearColor];
  
  [self.view addSubview:m_levelView];
  //  [self.view sendSubviewToBack:m_levelView];
  
  nt_level * l = [nt_level levelWithObjects:nil length:1000];
  LevelEditingScene *scene = [LevelEditingScene sceneWithLevel:l];
  scene.backgroundColor = [UIColor clearColor];
  scene.scaleMode = SKSceneScaleModeResizeFill;
  
  [m_levelView presentScene:scene];
  
  for (id child in self.view.subviews)
  {
    if ([child isKindOfClass:[UIButton class]])
    {
      [self.view bringSubviewToFront:child];
    }
  }
}


- (void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];
  
  
}


- (IBAction)buttonPausedPressed:(id)sender
{
  nt_alert * alert = [[nt_alert alloc] initWithTitle:@"Paused"];
  
  [alert addButtonWithImage:@"back_button" block:^
   {
     [self.navigationController popViewControllerAnimated:YES];
     [m_levelView removeFromSuperview];
     m_levelView = nil;
   } shouldDismiss:NO];
  
  [alert addButtonWithImage:@"next_button" block:^
   {
     
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     GameViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
     [vc setLevel:[(LevelEditingScene *)m_levelView.scene level]];
     [vc setModalPresentationStyle:UIModalPresentationFullScreen];
     
     [self.navigationController pushViewController:vc animated:YES];
     
   } shouldDismiss:NO];
  
  [alert show];
}


- (LevelEditingScene *)levelScene
{
  return (LevelEditingScene *)m_levelView.scene;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  UITouch * touch = [touches anyObject];
  CGPoint location = [touch locationInNode:self.levelScene];
  NSInteger index = [self.itemSelectionView itemIndexForTouch:touch];
  
  if (index >= 1 && index <= 7)
  {
    nt_object * o = [nt_block blockWithType:(kBlockType)(index-1) position:location angle:0];
    [self.levelScene addObject:o atTouch:touch];
  }
  else if (index == 8)
  {
    nt_fan* f = [nt_fan fanWithPosition:location angle:0];
    [self.levelScene addObject:f atTouch:touch];
  }
  else if (index == 9)
  {
    nt_coin* c = [nt_coin coinWithPosition:location];
    [self.levelScene addObject:c atTouch:touch];
  }
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  if (CGRectContainsPoint([[self.itemSelectionView itemForIndex:0] frame], [[touches anyObject] locationInView:self.view]))
  {
    [self.levelScene emptyTrash];
  }
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  nt_level* l = self.levelScene.level;
  [(GameViewController *)[segue destinationViewController] setLevel:[l copy]];
}

@end
