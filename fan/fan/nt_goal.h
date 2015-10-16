//
//  nt_goal.h
//  fan
//
//  Created by Nicholas Trampe on 9/9/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_object.h"

@interface nt_goal : nt_object <NSCopying>
{
  
}

+ (instancetype)goal;
+ (instancetype)goalWithPosition:(CGPoint)aPosition;
- (instancetype)initWithPosition:(CGPoint)aPosition;

@end
