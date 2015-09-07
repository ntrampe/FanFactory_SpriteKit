//
//  GameViewController.m
//  fan
//
//  Created by Nicholas Trampe on 7/24/15.
//  Copyright (c) 2015 Off Kilter Studios. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
  /* Retrieve scene file path from the application bundle */
  NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
  /* Unarchive the file to an SKScene object */
  NSData *data = [NSData dataWithContentsOfFile:nodePath
                                        options:NSDataReadingMappedIfSafe
                                          error:nil];
  NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
  [arch setClass:self forClassName:@"SKScene"];
  SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
  [arch finishDecoding];
  
  return scene;
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  m_gameView = [[SKView alloc] initWithFrame:self.view.frame];
  m_gameView.showsFPS = YES;
  m_gameView.showsNodeCount = YES;
  m_gameView.ignoresSiblingOrder = YES;
  m_gameView.multipleTouchEnabled = YES;
  m_gameView.showsPhysics = YES;
  
  [self.view addSubview:m_gameView];
  [self.view sendSubviewToBack:m_gameView];
}


- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  GameScene *scene = [GameScene sceneWithLevel:m_level];
  scene.scaleMode = SKSceneScaleModeAspectFill;
  
  [m_gameView presentScene:scene];
}


- (void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];
  
  
}


- (void)setLevel:(nt_level *)aLevel
{
  m_level = aLevel;
}


- (IBAction)pausedPressed:(id)sender
{
  nt_alert * alert = [[nt_alert alloc] initWithTitle:@"Paused"];
  
  [alert addButtonWithImage:@"retry_button" block:^
  {
    [(GameScene *)m_gameView.scene reset];
  }];
  
  [alert addButtonWithImage:@"menu_button" block:^
  {
    [self.navigationController popViewControllerAnimated:YES];
  } shouldDismiss:NO];
  
  [alert show];
}


- (IBAction)startPressed:(id)sender
{
  [(GameScene *)m_gameView.scene start];
}


- (IBAction)retryPressed:(id)sender
{
  [(GameScene *)m_gameView.scene reset];
}


- (void)ntAlertDidDismissWithButtonIndex:(NSInteger)aIndex
{
  switch (aIndex)
  {
    case 0:
      
      break;
      
    default:
      break;
  }
}


- (BOOL)shouldAutorotate
{
  return YES;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return UIInterfaceOrientationMaskAllButUpsideDown;
  } else {
    return UIInterfaceOrientationMaskAll;
  }
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}


- (BOOL)prefersStatusBarHidden
{
  return YES;
}

@end
