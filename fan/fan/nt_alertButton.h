//
//  nt_alertButton.h
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertButtonBlock)();

@interface nt_alertButton : UIButton
{
  
}
@property (strong, nonatomic) AlertButtonBlock block;
@property (readwrite) BOOL shouldDismiss;

@end
