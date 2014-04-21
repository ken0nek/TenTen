//
//  TTImageView+WithNumber.m
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/12.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTImageView+WithNumber.h"
#import <objc/runtime.h>

static char kImageViewNumerator;
static char kImageViewDenominator;

@implementation TTImageView (WithNumber)

- (void)setNumeratorNumber:(id)numeratorNumber
{
    objc_setAssociatedObject(
                             self,
                             &kImageViewNumerator,
                             numeratorNumber,
                             OBJC_ASSOCIATION_COPY_NONATOMIC
                             );
}

- (id)numeratorNumber
{
    return objc_getAssociatedObject(
                                    self,
                                    &kImageViewNumerator
                                    );
}

- (void)setDenominatorNumber:(id)denominatorNumber
{
    objc_setAssociatedObject(
                             self,
                             &kImageViewDenominator,
                             denominatorNumber,
                             OBJC_ASSOCIATION_COPY_NONATOMIC
                             );
}

- (id)denominatorNumber
{
    return objc_getAssociatedObject(
                                    self,
                                    &kImageViewDenominator
                                    );
}

@end
