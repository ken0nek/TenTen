//
//  TTViewManager.h
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/09.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTViewManager : NSObject

+ (UIImageView *)TTMakeImageView:(CGRect)rect withTag:(NSInteger)tagNumber withImageName:(NSString *)imageName;

+ (UILabel *)TTMakeLabel:(CGPoint)point withTag:(NSInteger)tagNumber withNumber:(int)number;

@end
