//
//  PackViewController.h
//  fan
//
//  Created by Nicholas Trampe on 9/7/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "SubMenuViewController.h"

@class nt_level;

@interface PackViewController : SubMenuViewController <UICollectionViewDelegate, UICollectionViewDataSource>
{
  nt_level* m_level;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
