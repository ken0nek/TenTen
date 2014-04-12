//
//  TTImageView+WithNumber.m
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/12.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTImageView+WithNumber.h"
#import <objc/runtime.h>

static char kImageViewWithNumber;

@implementation TTImageView (WithNumber)

- (void)setNumber:(id)number
{
    objc_setAssociatedObject(
                             self,
                             &kImageViewWithNumber,
                             number,
                             OBJC_ASSOCIATION_COPY_NONATOMIC
                             );
}

- (id)number
{
    return objc_getAssociatedObject(
                                    self,
                                    &kImageViewWithNumber
                                    );
}


@end
