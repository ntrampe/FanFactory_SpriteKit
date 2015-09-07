//
//  PackViewController.m
//  fan
//
//  Created by Nicholas Trampe on 9/7/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "PackViewController.h"
#import "GameViewController.h"
#import "LevelCollectionViewCell.h"
#import "nt_level.h"

static NSString *cellIdentifier = @"levelCell";

@interface PackViewController ()

@end

@implementation PackViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 24;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{ 
  LevelCollectionViewCell *cell = (LevelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
  
  [cell.labelNumber setText:[NSString stringWithFormat:@"%i", (int)indexPath.row+1]];
  
  if (cell.imageViewBackground.image == nil)
  {
    [cell.imageViewBackground setImage:[[UIImage imageNamed:@"stretch_container"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
  }
  
  return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 2;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}


- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
  
}


- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
  NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"levels/pack%i/%i", (int)indexPath.section+1, (int)indexPath.row+1] ofType:@"plist"]];
  m_level = [nt_level levelWithDictionary:dict];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  [(GameViewController *)[segue destinationViewController] setLevel:m_level];
}

@end
