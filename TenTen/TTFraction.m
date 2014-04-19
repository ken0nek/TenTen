//
//  TTFraction.m
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/19.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTFraction.h"

@implementation TTFraction

#pragma mark - Initializer..

- (id)initWithInt:(int)numerator and:(int)denominator
{
    if (denominator < 0) {
        self.numerator = -numerator;
        self.denominator =  -denominator;
    } else if (denominator > 0) {
        self.numerator = numerator;
        self.denominator = denominator;
    } else {
        DLog(@"分母が0");
    }
    
    int gcd = [TTFraction TTCalculateGCD:self.numerator and:self.denominator];
    
    int newNumerator = numerator / gcd;
    int newDenominator = denominator / gcd;
    
    self.numerator = newNumerator;
    self.denominator = newDenominator;
    
    return self;
}

- (id)init
{
    return self;
}

- (int)intValue
{
    return self.numerator;
}

+ (TTFraction *)numberWithInt:(int)value
{
    TTFraction *fraction = [[TTFraction alloc] initWithInt:value and:1];
    
    return fraction;
}

#pragma mark - forCalculation

// 約分する（使ってない）
+ (TTFraction *)TTReduction:(TTFraction *)fraction
{
    int numerator = fraction.numerator;
    int denominator = fraction.denominator;
    
    int gcd = [TTFraction TTCalculateGCD:numerator and:denominator];
    
    int newNumerator = numerator / gcd;
    int newDenominator = denominator / gcd;
    
    TTFraction *newFraction = [[TTFraction alloc] initWithInt:newNumerator and:newDenominator];
    
    return newFraction;
}

// 最大公約数を返す
+ (int)TTCalculateGCD:(int)a and:(int)b
{
    int number;
    
    while (b != 0) {
        number = a % b;
        a = b;
        b = number;
    }
    
    if (a > 0) {
        return  a;
    } else {
        return -a;
    }
}

// 逆数をとる
+ (TTFraction *)TTInverse:(TTFraction *)fraction
{
    int newNumerator;
    int newDenominator;
    
    if (fraction.numerator == 0) {
        newNumerator = 0;
        newDenominator = 1;
    } else if (fraction.numerator > 0) {
        newNumerator = fraction.denominator;
        newDenominator = fraction.numerator;
    } else {
        newNumerator =  - fraction.denominator;
        newDenominator = - fraction.numerator;
    }
    
    TTFraction *newFraction = [[TTFraction alloc] initWithInt:newNumerator and:newDenominator];
    
    return  newFraction;
}

#pragma mark - Calculation

+ (TTFraction *)TTFractionCalculate:(TTFraction *)a with:(TTFraction *)b withOpe:(TTFiledType)type
{
    TTFraction *output = [[TTFraction alloc] init];
    switch (type) {
        case TTFiledTypeAddtion:
            output = [TTFraction TTFractionAddition:a with:b];
            break;
        case TTFiledTypeSubtraction:
            output = [TTFraction TTFractionSubtraction:a with:b];
            break;
        case TTFiledTypeMultiplication:
            output = [TTFraction TTFractionMulplication:a with:b];
            break;
        case TTFiledTypeDivision:
            output = [TTFraction TTFractionDivision:a with:b];
            break;
        default:
            break;
    }
    return output;
}

+ (TTFraction *)TTFractionAddition:(TTFraction *)a with:(TTFraction *)b
{
    int newNumerator;
    int newDenominator;
    
    newNumerator = a.numerator * b.denominator + a.denominator * b.numerator;
    newDenominator = a.denominator * b.denominator;
    
    TTFraction *newFraction = [[TTFraction alloc] initWithInt:newNumerator and:newDenominator];
    return newFraction;
}

+ (TTFraction *)TTFractionSubtraction:(TTFraction *)a with:(TTFraction *)b
{
    [b setNumerator:b.numerator*(-1)]; // 一方を(-1)倍する
    TTFraction *newFraction = [TTFraction TTFractionAddition:a with:b];
    return newFraction;
}

+ (TTFraction *)TTFractionMulplication:(TTFraction *)a with:(TTFraction *)b
{
    int newNumerator;
    int newDenominator;
    
    newNumerator = a.numerator * b.numerator;
    newDenominator = a.denominator * b.denominator;
    
    TTFraction *newFraction = [[TTFraction alloc] initWithInt:newNumerator and:newDenominator];
    return newFraction;
}

+ (TTFraction *)TTFractionDivision:(TTFraction *)a with:(TTFraction *)b
{
    TTFraction *newFraction = [TTFraction TTFractionMulplication:a with:[TTFraction TTInverse:b]];
    return newFraction;
}

@end
