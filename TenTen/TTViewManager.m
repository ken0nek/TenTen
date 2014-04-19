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

// -------------------------------------------------------
//  TODO: labelを貼った、imageViewを作っちゃう
// -------------------------------------------------------

//+ (TTImageView *)TTMakeImageView:(CGPoint)point withTag:(NSInteger)tagNumber withNumber:(int)imageNumber
//{
//    CGSize size = CGSizeMake(DigitImageWidth, DigitImageHeight);
//    CGRect rect = {point, size};
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(6, 10, 48, 60);
//    label.textColor = [UIColor blackColor];
//    label.contentMode = UIViewContentModeScaleAspectFill;
//    label.adjustsFontSizeToFitWidth = YES;
//    label.text = [NSString stringWithFormat:@"%d", imageNumber];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont fontWithName:@"Silom" size:40];
//    //NSLog(@"%@", label);
//    
//    TTImageView *imageView = [[TTImageView alloc] init];
//    imageView.frame = rect;
//    imageView.center = point;
//    imageView.number = [NSNumber numberWithInt:imageNumber];
//    imageView.image = [UIImage imageNamed:@"Background.png"];
//    imageView.userInteractionEnabled = YES;
//    
//    [imageView addSubview:label];
//    
//    return imageView;
//}

+ (TTImageView *)TTMakeImageView:(CGPoint)point withTag:(NSInteger)tagNumber withNumber:(int)imageNumber
{
    NSLog(@"%s", __func__);
    CGSize size = CGSizeMake(DigitImageWidth, DigitImageHeight);
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

+ (UIImageView *)TTMakeFieldImageView:(CGPoint)point withTag:(TTFiledType)type
{
    CGSize size = CGSizeMake(FieldImageWidth, FieldImageHeight);
    CGRect rect = {point, size};
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = rect;
    imageView.tag = type;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"field%d", type]];
    imageView.userInteractionEnabled = NO;
    
    return imageView;
}

+ (void)TTDeleteImageView
{
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    // UIViewController *vc = [[[[[UIApplication sharedApplication] delegate] window] rootViewController]presentingViewController];
    for (UIView *subview in vc.view.subviews) {
        if ([[subview class] isSubclassOfClass:[TTImageView class]]) {
            [subview removeFromSuperview];
        }
    }
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
