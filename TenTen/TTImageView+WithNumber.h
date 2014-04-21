//
//  TTImageView+WithNumber.h
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/12.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTImageView.h"

@interface TTImageView (WithNumber)

@property (nonatomic) id numeratorNumber;
@property (nonatomic) id denominatorNumber;

- (void)setNumeratorNumber:(id)numeratorNumber;
- (id)numeratorNumber;

- (void)setDenominatorNumber:(id)denominatorNumber;
- (id)denominatorNumber;

@end
