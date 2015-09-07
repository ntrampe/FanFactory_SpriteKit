//
//  nt_wind.h
//  fan
//
//  Created by Nicholas Trampe on 7/27/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "nt_fan.h"

@interface nt_wind : NSObject
{
  nt_object* m_object;
  nt_fan* m_fan;
}

@property (nonatomic, strong) nt_object* object;
@property (nonatomic, strong) nt_fan* fan;


+ (instancetype)windWithObject:(nt_object *)aObject fan:(nt_fan *)aFan;
- (instancetype)initWithObject:(nt_object *)aObject fan:(nt_fan *)aFan;


- (void)blow;

@end
