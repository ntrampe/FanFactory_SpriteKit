//
//  nt_block.h
//  fan
//
//  Created by Nicholas Trampe on 7/24/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_object.h"

@interface nt_block : nt_object
{
  
}

+ (instancetype)blockWithType:(kBlockType)aType position:(CGPoint)aPosition angle:(CGFloat)aAngle;
- (instancetype)initWithType:(kBlockType)aType position:(CGPoint)aPosition angle:(CGFloat)aAngle;

+ (NSString *)nameFromType:(kBlockType)aType;

@end
