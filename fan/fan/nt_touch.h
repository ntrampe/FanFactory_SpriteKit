//
//  nt_touch.h
//  fan
//
//  Created by Nicholas Trampe on 7/26/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "nt_object.h"

@interface nt_touch : NSObject
{
  nt_object * m_object;
  UITouch * m_touch;
}

@property (nonatomic, strong) nt_object * object;
@property (nonatomic, strong) UITouch * touch;

+ (instancetype)touchWithObject:(nt_object *)aObject touch:(UITouch *)aTouch;
- (instancetype)initWithObject:(nt_object *)aObject touch:(UITouch *)aTouch;

@end
