//
//  nt_player.h
//  fan
//
//  Created by Nicholas Trampe on 7/26/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_object.h"

@interface nt_player : nt_object <NSCopying>
{
  
}

+ (instancetype)playerWithPosition:(CGPoint)aPosition;
- (instancetype)initWithPosition:(CGPoint)aPosition;


@end
