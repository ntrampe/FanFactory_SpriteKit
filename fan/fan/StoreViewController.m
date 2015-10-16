//
//  StoreViewController.m
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  m_background = [ParallaxScene sceneWithSize:self.view.frame.size];
  
  SKView* sceneView = [[SKView alloc] initWithFrame:self.view.frame];
  sceneView.showsFPS = YES;
  sceneView.showsNodeCount = YES;
  sceneView.userInteractionEnabled = NO;
  
  [sceneView presentScene:m_background];
  
  [self.view addSubview:sceneView];
}


- (void)viewDidAppear:(BOOL)animated
{
  SKSpriteNode* window = [SKSpriteNode spriteNodeWithImageNamed:@"window"];
  [m_background addObjectWithNode:window position:CGPointMake(0, 150) ratio:CGPointMake(0.08, 0.02)];
  
  SKSpriteNode* light = [SKSpriteNode spriteNodeWithImageNamed:@"light"];
  [m_background addObjectWithNode:light position:CGPointMake(0, 200) ratio:CGPointMake(0.15, 0.1)];
  
  SKSpriteNode* back = [SKSpriteNode spriteNodeWithImageNamed:@"boxes_back"];
  [m_background addObjectWithNode:back position:CGPointMake(0, 50) ratio:CGPointMake(0.1, 0.02)];
  
  SKSpriteNode* front = [SKSpriteNode spriteNodeWithImageNamed:@"boxes_front"];
  SKSpriteNode* front1 = [SKSpriteNode spriteNodeWithImageNamed:@"boxes_front"];
  SKSpriteNode* front2 = [SKSpriteNode spriteNodeWithImageNamed:@"boxes_front"];
  SKSpriteNode* front3 = [SKSpriteNode spriteNodeWithImageNamed:@"boxes_front"];
//  [m_background addObjectWithNode:front position:CGPointMake(0, 0) ratio:CGPointMake(0.8, 0.8)];
  [m_background addContinuousObjectsWithPosition:CGPointMake(0, 0) ratio:CGPointMake(0.8, 0.8) objects:front, front1, nil];
  
  
  [m_background updateWithPosition:0];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  for (UITouch* touch in touches)
  {
    CGPoint prevLoc = [touch previousLocationInView:self.view];
    CGPoint loc = [touch locationInView:self.view];
    
    [m_background updateWithVelocity:prevLoc.x - loc.x];
    NSLog(@"%.2f", loc.x);
  }
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
