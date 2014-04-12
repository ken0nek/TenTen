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

+ (TTImageView *)TTMakeImageView:(CGPoint)point withTag:(NSInteger)tagNumber withNumber:(int)imageNumber
{
    NSLog(@"%s", __func__);
    CGSize size = CGSizeMake(digitImageWidth, digitImageHeight);
    CGRect rect = {point, size};

    TTImageView *imageView = [[TTImageView alloc] init];
    imageView.frame = rect;
    imageView.center = point;
    imageView.tag = tagNumber;
    imageView.number = [NSNumber numberWithInt:imageNumber];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", imageNumber]];
    imageView.userInteractionEnabled = YES;
    
    return imageView;
}

+ (UIImageView *)TTMakeFieldImageView:(CGPoint)point withTag:(int)type
{
    CGSize size = CGSizeMake(fieldImageWidth, fieldImageHeight);
    CGRect rect = {point, size};
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = rect;
    imageView.tag = type;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"field%d", type]];
    imageView.userInteractionEnabled = NO;
    
    return imageView;
}

//+ (UILabel *)TTMakeLabel:(CGPoint)point withTag:(NSInteger)tagNumber withNumber:(int)number
//{
//    CGSize size = CGSizeMake(60, 60);
//    CGRect rect = {point, size};
//
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = rect;
//    label.center = point;
//    label.tag = tagNumber;
//    label.font = [UIFont systemFontOfSize:25];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = [NSString stringWithFormat:@"%d", number];
//    label.userInteractionEnabled = YES;
//    return label;
//}
                       
@end
