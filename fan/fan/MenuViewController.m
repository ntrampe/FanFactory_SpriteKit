//
//  MenuViewController.m
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "MenuViewController.h"
#import "nt_alert.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  
  UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.hudView.frame.size.width, self.hudView.frame.size.height)];
  [img setImage:[[UIImage imageNamed:@"stretch_container.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
  
  [self.hudView addSubview:img];
  [self.hudView sendSubviewToBack:img];
  
  [self.hudView setBackgroundColor:[UIColor clearColor]];
  
  [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  
}


- (IBAction)butonGameCenterPressed:(id)sender
{
  
}


- (IBAction)buttonCreditsPressed:(id)sender
{
  nt_alert * alert = [[nt_alert alloc] initWithTitle:@"Credits" message:@"Programming and Artwork:\nNicholas Trampe\n\nSpecial Thanks:\nBox2D, Cocos2D (original version)"];
  [alert addButtonWithImage:@"yes_button"];
  [alert show];
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  self.hudView.center = [[touches anyObject] locationInView:self.view];
  
  NSLog(@"%@", NSStringFromCGPoint(self.hudView.center));
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
