//
//  LevelController.m
//  fan
//
//  Created by Nicholas Trampe on 9/7/15.
//  Copyright 2015 Off Kilter Studios. All rights reserved.
//

#import "LevelController.h"

@interface LevelController (Private) 

- (void)initController;

@end

@implementation LevelController

#pragma mark -
#pragma mark Init


- (id)init
{
  self = [super init];
  if (self)
  {
    [self initController];
  }
  
  return self;
}


- (void)initController
{
  
}


#pragma mark -
#pragma mark Singleton


+ (instancetype)sharedLevelController
{
  static dispatch_once_t pred = 0;
  static LevelController *sharedLevelController = nil;
  
  dispatch_once( &pred, ^{
    sharedLevelController = [[super alloc] init];
  });
  return sharedLevelController;
}


@end
