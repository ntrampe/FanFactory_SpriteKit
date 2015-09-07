//
//  MenuViewController.h
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
{
  
}
@property (weak, nonatomic) IBOutlet UIView *hudView;

- (IBAction)butonGameCenterPressed:(id)sender;
- (IBAction)buttonCreditsPressed:(id)sender;


@end
