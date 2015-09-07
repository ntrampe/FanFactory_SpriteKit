//
//  nt_level.h
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface nt_level : NSObject
{
  float m_length;
  NSMutableArray * m_objects;
}
@property (readwrite) float length;
@property (strong) NSMutableArray * objects;

+ (instancetype)levelWithObjects:(NSArray *)aObjects length:(float)aLength;
+ (instancetype)levelWithDictionary:(NSDictionary *)aDictionary;

- (instancetype)initWithObjects:(NSArray *)aObjects length:(float)aLength;
- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end
