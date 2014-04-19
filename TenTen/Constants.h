//
//  Constants.h
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/12.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#ifndef TenTen_Constants_h
#define TenTen_Constants_h

#define DigitImageWidth 60
#define DigitImageHeight 80

#define FieldImageWidth 140
#define FieldImageHeight 140

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

typedef enum : int {
    TTFiledTypeAddtion,
    TTFiledTypeSubtraction,
    TTFiledTypeMultiplication,
    TTFiledTypeDivision
} TTFiledType;

typedef enum : int {
    TTActionTypeDidIntersect,
    TTActionTypeDidClear,
    TTActionTypeDidMiss
} TTActionType;

typedef enum : int {
    TTGameLevelEasy,
    TTGameLevelMidium,
    TTGameLevelHard
} TTGameLevel;

//typedef enum : int {
//    TTGameState,
//    <#MyEnumValueB#>,
//    TTGemeStateEnded,
//} TTGameState;

#endif
