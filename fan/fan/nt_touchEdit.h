//
//  nt_touchEdit.h
//  fan
//
//  Created by Nicholas Trampe on 9/7/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_touch.h"

typedef enum
{
  kEditingTypeNone = 0,
  kEditingTypeTranslating = 1,
  kEditingTypeRotating = 2
}kEditingType;

@interface nt_touchEdit : nt_touch
{
  
}
@property (readwrite) kEditingType editingType;

+ (instancetype)touchWithObject:(nt_object *)aObject touch:(UITouch *)aTouch editingType:(kEditingType)aEditingType;
- (instancetype)initWithObject:(nt_object *)aObject touch:(UITouch *)aTouch editingType:(kEditingType)aEditingType;

@end
