//
//  TTFraction.h
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/19.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTFraction : NSObject

// 分子
@property (nonatomic) int numerator;
// 分母
@property (nonatomic) int denominator;
// 分数かどうか
@property (nonatomic) BOOL isFraction;

+ (TTFraction *)TTFractionCalculate:(TTFraction *)a with:(TTFraction *)b withOpe:(TTFiledType)type;
- (int)intValue;
+ (TTFraction *)numberWithInt:(int)value;
- (id)initWithInt:(int)numerator and:(int)denominator;
- (id)init;
//+ (TTFraction *)TTFractionAddition:(int)a with:(int) b;
//+ (TTFraction *)TTFractionSubtraction:(int)a with:(int) b;
//+ (TTFraction *)TTFractionMulplication:(int)a with:(int) b;
//+ (TTFraction *)TTFractionDivision:(int)a with:(int) b;

@end
