//
//  nt_alert.m
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_alert.h"
#import "UIImage+ImageEffects.h"

@interface nt_alert (Private)

- (void)removeWindow;

- (void)buttonPressed:(nt_alertButton *)aButton;

@end

@implementation nt_alert


- (id)init
{
  return [self initWithTitle:nil message:nil buttons:nil];
}


- (id)initWithTitle:(NSString *)aTitle
{
  return [self initWithTitle:aTitle message:nil buttons:nil];
}


- (id)initWithTitle:(NSString *)aTitle message:(NSString *)aMessage
{
  return [self initWithTitle:aTitle message:aMessage buttons:nil];
}


- (id)initWithTitle:(NSString *)aTitle message:(NSString *)aMessage buttons:(NSArray *)aButtons
{
  self = [super init];
  
  if (self)
  {
    CGRect frame = [UIScreen mainScreen].bounds;
    
    m_window = [[UIWindow alloc] initWithFrame:frame];
    m_window.windowLevel = UIWindowLevelAlert;
    m_window.backgroundColor = [UIColor clearColor];
    m_window.rootViewController = self;
    
    m_backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.view addSubview:m_backgroundView];
    
    m_containerView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, frame.size.width - 200, frame.size.height - 100)];
    [self.view addSubview:m_containerView];
    
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_containerView.frame.size.width, m_containerView.frame.size.height)];
    [img setImage:[[UIImage imageNamed:@"stretch_container.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20]];
    [m_containerView addSubview:img];
    
    
    if (aTitle != nil && ![aTitle isEqualToString:@""])
    {
      m_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, m_containerView.frame.size.width, 25)];
      m_titleLabel.backgroundColor = [UIColor clearColor];
      m_titleLabel.textColor = [UIColor whiteColor];
      
      m_titleLabel.text = aTitle;
      
      [m_titleLabel setTextAlignment:NSTextAlignmentCenter];
      [m_titleLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:20]];
      
      [m_containerView addSubview:m_titleLabel];
    }
    
    if (aMessage != nil && ![aMessage isEqualToString:@""])
    {
      m_messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, m_containerView.frame.size.width, m_containerView.frame.size.height - 35 - 10)];
      m_messageLabel.backgroundColor = [UIColor clearColor];
      m_messageLabel.textColor = [UIColor whiteColor];
      
      m_messageLabel.numberOfLines = 30;
      
      m_messageLabel.text = aMessage;
      
      [m_messageLabel setTextAlignment:NSTextAlignmentCenter];
      [m_messageLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:20]];
      
      [m_containerView addSubview:m_messageLabel];
    }
    
    m_buttonView = nil;
    m_buttons = [NSMutableArray array];
  }
  
  return self;
}


- (void)addButtonWithImage:(NSString *)aImage block:(AlertButtonBlock)aBlock shouldDismiss:(BOOL)aShouldDismiss
{
  if (m_buttonView == nil)
  {
    m_buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    m_buttonView.backgroundColor = [UIColor clearColor];
    [m_containerView addSubview:m_buttonView];
  }
  
  UIImage * img = [UIImage imageNamed:aImage];
  nt_alertButton * button = [[nt_alertButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
  
  [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [button setBlock:aBlock];
  [button setShouldDismiss:aShouldDismiss];
  [button setBackgroundImage:img forState:UIControlStateNormal];
  [button setTag:m_buttons.count];
  
  [m_buttonView addSubview:button];
  [m_buttons addObject:button];
  
  float offset = 10;
  float largestHeight = 0;
  float totalWidth = offset;
  
  for (UIButton * b in m_buttons)
    if (b.frame.size.height > largestHeight)
      largestHeight = b.frame.size.height;
  
  for (UIButton * b in m_buttons)
  {    
    [b setFrame:CGRectMake(totalWidth, largestHeight / 2.0f - b.frame.size.height / 2.0f, b.frame.size.width, b.frame.size.height)];
    totalWidth += b.frame.size.width + offset;
  }
  
  [m_buttonView setFrame:CGRectMake(0, m_containerView.frame.size.height - largestHeight - 20, totalWidth, largestHeight)];
  [m_buttonView setCenter:CGPointMake(m_containerView.frame.size.width / 2.0f, m_buttonView.center.y)];
  
  [m_messageLabel setFrame:CGRectMake(m_messageLabel.frame.origin.x, m_messageLabel.frame.origin.y, m_messageLabel.frame.size.width, m_containerView.frame.size.height - largestHeight - 20 - 10)];
}


- (void)addButtonWithImage:(NSString *)aImage block:(AlertButtonBlock)aBlock
{
  [self addButtonWithImage:aImage block:aBlock shouldDismiss:YES];
}


- (void)addButtonWithImage:(NSString *)aImage
{
  [self addButtonWithImage:aImage block:nil shouldDismiss:YES];
}


- (void)showWithCompletion:(void (^)(void))aCompletion
{
  m_previousWindow = [[UIApplication sharedApplication] keyWindow];
  
  self.view.alpha = 0.0f;
  
  UIView *appView = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
  UIImage *image = [UIImage convertViewToImage:appView];
  UIImage *blurSnapshotImage = [image applyBlurWithRadius:5.0f
                                                tintColor:[UIColor colorWithWhite:0.2f
                                                                            alpha:0.7f]
                                    saturationDeltaFactor:1.8f
                                                maskImage:nil];
  
  m_backgroundView.image = blurSnapshotImage;
  m_backgroundView.alpha = 1.0f;
  
  m_containerView.center = CGPointMake(m_containerView.center.x, m_containerView.center.y + 500);
  
  [m_window makeKeyAndVisible];
  
  [UIView animateWithDuration:0.4 delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:0.8 options:UIViewAnimationOptionAllowAnimatedContent animations:^
  {
    self.view.alpha = 1.0f;
    
    m_containerView.center = CGPointMake(m_containerView.center.x, m_containerView.center.y - 500);
  }
                   completion:^(BOOL finished)
  {
    if (aCompletion != nil)
    {
      aCompletion();
    }
  }];
}


- (void)dismissWithCompletion:(void (^)(void))aCompletion
{
  [UIView animateWithDuration:0.4 delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:0.8 options:UIViewAnimationOptionAllowAnimatedContent animations:^
   {
     self.view.alpha = 0.0f;
     
     m_containerView.center = CGPointMake(m_containerView.center.x, m_containerView.center.y + 500);
   }
                   completion:^(BOOL finished)
   {
     
     [self removeWindow];
     
     if (aCompletion != nil)
     {
       aCompletion();
     }
     
   }];
}


- (void)show
{
  [self showWithCompletion:nil];
}


- (void)dismiss
{
  [self dismissWithCompletion:nil];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  UITouch* touch = [touches anyObject];
  CGPoint location = [touch locationInView:self.view];
  
  if (!CGRectContainsPoint(m_containerView.frame, location))
  {
    [self dismiss];
  }
}


- (void)removeWindow
{
  [m_backgroundView removeFromSuperview];
  [m_window setHidden:YES];
  
  [m_previousWindow makeKeyAndVisible];
  m_previousWindow = nil;
}


- (void)buttonPressed:(nt_alertButton *)aButton
{
  if (aButton.shouldDismiss)
  {
    [self dismissWithCompletion:^
     {
       if (aButton.block)
       {
         aButton.block();
       }
       
       if ([self.delegate respondsToSelector:@selector(ntAlertDidDismissWithButtonIndex:)])
       {
         [self.delegate ntAlertDidDismissWithButtonIndex:aButton.tag];
       }
     }];
  }
  else
  {
    [self removeWindow];
    
    if (aButton.block)
    {
      aButton.block();
    }
  }
}


@end
