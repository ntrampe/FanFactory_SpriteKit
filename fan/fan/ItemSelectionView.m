//
//  ItemSelectionView.m
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "ItemSelectionView.h"
#import "nt_block.h"


@interface ItemSelectionView (Private)

- (void)handleTap:(UITapGestureRecognizer *)sender;

@end


@implementation ItemSelectionView


- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  
  if (self)
  {
    UIImageView * trash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trashcan"]];
    [self addItem:trash];
    
    for (int i = 0; i < 7; i++)
    {
      UIImageView * block = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[nt_block nameFromType:(kBlockType)i]]];
      [self addItem:block];
    }
    
    UIImageView * fan = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fan_1"]];
    [self addItem:fan];
    
    UIImageView * coin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coin"]];
    [self addItem:coin];
  }
  
  return self;
}


- (void)addItem:(UIImageView *)aItem
{
  aItem.tag = self.subviews.count;
  
  [self addArrangedSubview:aItem];
}


- (NSInteger)itemIndexForTouch:(UITouch *)aTouch
{
  CGPoint location = [aTouch locationInView:self];
  
  for (UIView * v in self.subviews)
  {
    if (CGRectContainsPoint(v.frame, location))
    {
      return v.tag;
    }
  }
  
  return -1;
}


- (UIView *)itemForIndex:(NSInteger)aIndex
{
  for (UIView * v in self.subviews)
  {
    if (v.tag == aIndex)
    {
      return v;
    }
  }
  
  return nil;
}



@end
