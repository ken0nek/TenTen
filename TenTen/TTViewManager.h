//
//  TTViewManager.h
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/09.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTImageView.h"

@interface TTViewManager : NSObject

+ (TTImageView *)TTMakeImageView:(CGPoint)point withTag:(NSInteger)tagNumber withNumber:(int)imageNumber;

// + (UILabel *)TTMakeLabel:(CGPoint)point withTag:(NSInteger)tagNumber withNumber:(int)number;

+ (UIImageView *)TTMakeFieldImageView:(CGPoint)point withTag:(int)type;

@end
