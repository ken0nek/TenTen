//
//  TTViewManager.m
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/09.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTViewManager.h"

@implementation TTViewManager

#pragma mark - UIImageView

+ (UIImageView *)TTMakeImageView:(CGRect)rect withTag:(NSInteger)tagNumber withImageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = rect;
    imageView.userInteractionEnabled = YES;
    return imageView;
}

+ (UILabel *)TTMakeLabel:(CGPoint)point withTag:(NSInteger)tagNumber withNumber:(int)number
{
    CGSize size = CGSizeMake(60, 60);
    CGRect rect = {point, size};
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = rect;
    label.center = point;
    label.tag = tagNumber;
    label.font = [UIFont systemFontOfSize:25];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%d", number];
    label.userInteractionEnabled = YES;
    return label;
}
@end
