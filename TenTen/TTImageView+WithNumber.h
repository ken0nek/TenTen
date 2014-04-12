//
//  TTImageView+WithNumber.h
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/12.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTImageView.h"

@interface TTImageView (WithNumber)

@property (nonatomic) id number;

- (void)setNumber:(id)number;

- (id)number;

@end
