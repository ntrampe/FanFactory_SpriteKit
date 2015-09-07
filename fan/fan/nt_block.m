//
//  nt_block.m
//  fan
//
//  Created by Nicholas Trampe on 7/24/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#import "nt_block.h"

@implementation nt_block

+ (instancetype)blockWithType:(kBlockType)aType position:(CGPoint)aPosition angle:(CGFloat)aAngle
{
  return [[nt_block alloc] initWithType:aType position:aPosition angle:aAngle];
}


- (instancetype)initWithType:(kBlockType)aType position:(CGPoint)aPosition angle:(CGFloat)aAngle
{
  self = [super initWithImageNamed:[nt_block nameFromType:aType] position:aPosition angle:aAngle];
  
  if (self)
  {
    SKPhysicsBody* body;
    CGMutablePathRef path;
    CGFloat offsetX = self.frame.size.width * self.anchorPoint.x;
    CGFloat offsetY = self.frame.size.height * self.anchorPoint.y;
    
    
    switch (aType)
    {
      case kBlockTypeLongSmall:
      case kBlockTypeLongLarge:
      case kBlockTypeSquareSmall:
      case kBlockTypeSquareLarge:
        body = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        break;
      case kBlockTypeTriangleHole:
        
        path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 42 - offsetX, 83 - offsetY);
        CGPathAddLineToPoint(path, NULL, 84 - offsetX, 2 - offsetY);
        CGPathAddLineToPoint(path, NULL, 0 - offsetX, 2 - offsetY);
        
        CGPathCloseSubpath(path);
        
        body = [SKPhysicsBody bodyWithPolygonFromPath:path];
        
        break;
      case kBlockTypeTriangleWhole:
        
        path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 0 - offsetX, 84 - offsetY);
        CGPathAddLineToPoint(path, NULL, 81 - offsetX, 2 - offsetY);
        CGPathAddLineToPoint(path, NULL, 0 - offsetX, 2 - offsetY);
        
        CGPathCloseSubpath(path);
        
        body = [SKPhysicsBody bodyWithPolygonFromPath:path];
        
        break;
      case kBlockTypeCircle:
        body = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width / 2.0f];
        break;
        
      default:
        body = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width / 2.0f];
        break;
    }
    
    body.dynamic = NO;
    
    body.categoryBitMask = blockCategory;
    body.collisionBitMask = blockCategory | playerCategory | fanCategory;
    body.contactTestBitMask = blockCategory | playerCategory | fanCategory;
    
    self.physicsBody = body;
  }
  
  return self;
}


+ (NSString *)nameFromType:(kBlockType)aType
{
  NSString * res = @"";
  
  switch (aType)
  {
    case kBlockTypeLongSmall:
      res = @"block_long_small.png";
      break;
    case kBlockTypeLongLarge:
      res = @"block_long_large.png";
      break;
    case kBlockTypeSquareSmall:
      res = @"block_square_small.png";
      break;
    case kBlockTypeSquareLarge:
      res = @"block_square_large.png";
      break;
    case kBlockTypeTriangleHole:
      res = @"block_triangle_hole.png";
      break;
    case kBlockTypeTriangleWhole:
      res = @"block_triangle_whole.png";
      break;
    case kBlockTypeCircle:
      res = @"block_circle.png";
      break;
      
    default:
      break;
  }
  return res;
}

@end
