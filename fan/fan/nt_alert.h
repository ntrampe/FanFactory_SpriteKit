//
//  nt_alert.h
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "nt_alertButton.h"

@class nt_alert;

@protocol NTAlertDelegate <NSObject>

@optional
- (void)ntAlertDidDismissWithButtonIndex:(NSInteger)aIndex;

@end

@interface nt_alert : UIViewController
{
  UIWindow * m_window;
  UIWindow * m_previousWindow;
  UIView * m_containerView; 
  UIView * m_buttonView;
  UIImageView * m_backgroundView;
  
  UILabel * m_titleLabel;
  UILabel * m_messageLabel;
  
  NSMutableArray * m_buttons;
}
@property (weak, nonatomic) id <NTAlertDelegate> delegate;

- (id)initWithTitle:(NSString *)aTitle;
- (id)initWithTitle:(NSString *)aTitle message:(NSString *)aMessage;
- (id)initWithTitle:(NSString *)aTitle message:(NSString *)aMessage buttons:(NSArray *)aButtons;

- (void)addButtonWithImage:(NSString *)aImage block:(AlertButtonBlock)aBlock shouldDismiss:(BOOL)aShouldDismiss;
- (void)addButtonWithImage:(NSString *)aImage block:(AlertButtonBlock)aBlock;
- (void)addButtonWithImage:(NSString *)aImage;

- (void)showWithCompletion:(void (^)(void))aCompletion;
- (void)dismissWithCompletion:(void (^)(void))aCompletion;
- (void)show;
- (void)dismiss;

@end
