//
//  nt_level.h
//  fan
//
//  Created by Nicholas Trampe on 9/6/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface nt_level : NSObject <NSCopying>
{
  float m_length;
  NSMutableSet * m_objects;
}
@property (readwrite) float length;
@property (strong) NSMutableSet * objects;

+ (instancetype)levelWithObjects:(NSSet *)aObjects length:(float)aLength;
+ (instancetype)levelWithDictionary:(NSDictionary *)aDictionary;

- (instancetype)initWithObjects:(NSSet *)aObjects length:(float)aLength;
- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end
