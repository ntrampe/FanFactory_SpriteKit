//
//  types.h
//  fan
//
//  Created by Nicholas Trampe on 7/24/15.
//  Copyright © 2015 Off Kilter Studios. All rights reserved.
//

#ifndef types_h
#define types_h


typedef enum
{
  kBlockTypeLongSmall = 0,
  kBlockTypeLongLarge = 1,
  kBlockTypeSquareSmall = 2,
  kBlockTypeSquareLarge = 3,
  kBlockTypeTriangleHole = 4,
  kBlockTypeTriangleWhole = 5,
  kBlockTypeCircle = 6
}kBlockType;


typedef enum
{
  kObjectMovementTypeNone = 0,
  kObjectMovementTypeOscillateVertical = 1,
  kObjectMovementTypeOscillateHorizontal = 2,
  kObjectMovementTypeRotate = 3,
}kObjectMovementType;


typedef struct
{
  BOOL snaps, guide, invert;
  kObjectMovementType movement;
  float time;
}kObjectAttributes;


enum kTag
{
  kTagPlayer = 7,
  kTagFan = 8,
  kTagWind = 9,
  kTagBlock = 10,
  kTagGround = 11,
  kTagFinish = 12,
  kTagPoof = 13,
  kTagLevelEdit = 14,
  kTagTrashCan = 15,
  kTagCoin = 16
};


typedef enum
{
  kGameStateRunning = 0,
  kGameStatePaused = 1,
  kGameStateEditing = 2,
  kGameStateOver = 3
}kGameState;


static const uint32_t playerCategory      =  0x1 << 0;
static const uint32_t blockCategory       =  0x1 << 1;
static const uint32_t fanCategory         =  0x1 << 2;
static const uint32_t windCategory        =  0x1 << 3;
static const uint32_t coinCategory        =  0x1 << 4;


#endif /* types_h */
