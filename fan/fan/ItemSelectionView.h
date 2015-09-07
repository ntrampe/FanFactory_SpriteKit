//
//  ItemSelectionView.h
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemSelectionView : UIStackView
{
  
}

- (void)addItem:(UIImageView *)aItem;

- (NSInteger)itemIndexForTouch:(UITouch *)aTouch;
- (UIView *)itemForIndex:(NSInteger)aIndex;

@end
