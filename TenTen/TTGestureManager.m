//
//  TTGestureManager.m
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/09.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTGestureManager.h"


@interface TTGestureManager ()

@end

@implementation TTGestureManager

+ (void)setDragForView:(UIView *)view
{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

+ (CGPoint)calculateDistance:(UIPanGestureRecognizer *)sender
{
    CGPoint p1 = sender.view.center;
    
    CGPoint p2 = [sender translationInView:sender.view];
    
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

+ (void)dragView:(UIPanGestureRecognizer *)sender
{
    UIView *targetView = sender.view;
    
    // DLog(@"tag of target = %d", (int)targetView.tag);
    
    // CGPoint p = [sender translationInView:targetView];
    
    CGPoint movedPoint = [self calculateDistance:sender];
    
    // DLog(@"now at %@", NSStringFromCGPoint(movedPoint));
    
    targetView.center = movedPoint;
    
    [sender setTranslation:CGPointZero inView:targetView];
    
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    //  UIViewController *vc = [[[[[UIApplication sharedApplication] delegate] window] rootViewController]presentingViewController];
    [[vc view] addSubview:targetView];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self checkIntersection:sender];
        
        // [self determineOperator:sender];
    }
}

+ (void)checkIntersection:(UIPanGestureRecognizer *)sender
{
    //UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

    for (UIView *aView in sender.view.superview.subviews) {
        if ([[aView class] isSubclassOfClass:[TTImageView class]]) {
            if (CGRectIntersectsRect(aView.frame, sender.view.frame)) {
                if (aView.tag != sender.view.tag) {
                    [self didIntersect:sender intersect:(TTImageView *)aView with:(TTImageView *)sender.view];
                    
                    TTSoundManager *sm = [TTSoundManager init];
                    [sm playSounds:TTActionTypeDidIntersect];
                    sm = nil;
                    DLog(@"Intersect! aView.tag = %d and sender.view.tag = %d", (int)aView.tag, (int)sender.view.tag);
                    
                    break;
                }
            } else {
                DLog(@"Not intersect!");
                
            }
        }
    }
//    for (UILabel *aView in sender.view.superview.subviews) {
//        if ([[aView class] isSubclassOfClass:[UILabel class]]) {
//            if (CGRectIntersectsRect(aView.frame, sender.view.frame)) {
//                if (aView.tag != sender.view.tag) {
//                    DLog(@"Intersect! aView.tag = %d and sender.view.tag = %d", (int)aView.tag, (int)sender.view.tag);
//                    [self didIntersect:aView withView:(UILabel *)sender.view at:[self calculateDistance:sender]];
//                    break;
//                }
//            } else {
//                DLog(@"Not intersect!");
//                
//            }
//        }
//    }
}

//+ (void)didIntersect:(UILabel *)aView withView:(UILabel *)bView at:(CGPoint)point
//{
//    int aNumber = [aView.text intValue];
//    int bNumber = [bView.text intValue];
//    int sum = aNumber + bNumber;
//    
//    [aView removeFromSuperview];
//    [bView removeFromSuperview];
//    
//    UILabel *newLabel = [TTViewManager TTMakeLabel:point withTag:4 withNumber:sum];
//    [TTGestureManager setDragForView:newLabel];
//    
//    //UIViewController*vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
//    //DLog(@"%@", vc);
//    //[[vc view] addSubview:label5];
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"didAppearNewLabel" object:newLabel];
//    
//}

+ (void)didIntersect:(UIPanGestureRecognizer *)sender intersect:(TTImageView *)aView with:(TTImageView *)bView
{
//    int aNumber = [aView.number intValue];
//    int bNumber = [bView.number intValue];
    
    TTFraction *aNumber = [[TTFraction alloc] initWithInt:[aView.numeratorNumber intValue] and:[aView.denominatorNumber intValue]];
    TTFraction *bNumber = [[TTFraction alloc] initWithInt:[bView.numeratorNumber intValue] and:[bView.denominatorNumber intValue]];
    
    CGPoint point = [self calculateDistance:sender];
    
    [aView removeFromSuperview];
    [bView removeFromSuperview];
    
    int ope = [self determineOperator:aView];
    
    //int output = [self calculateOutput:aNumber and:bNumber withOpe:ope];
    
    TTFraction *output = [TTFraction TTFractionCalculate:aNumber with:bNumber withOpe:ope];
    
    // -------------------------------------------------------
    //  TODO: tagの処理
    // -------------------------------------------------------
    
    int tagNumber = [output intValue] + [aNumber intValue];
    
    // UILabel *newLabel = [TTViewManager TTMakeLabel:point withTag:4 withNumber:sum];
    TTImageView *newImageView = [TTViewManager TTMakeImageView:point withTag:tagNumber withNumber:output];
    //DLog(@"%d", [newImageView.number intValue]);
    // [TTGestureManager setDragForView:newLabel];
    [TTGestureManager setDragForView:newImageView];
    
//    if ([newImageView.number intValue] == 10) {
//        TTSoundManager *sm = [TTSoundManager init];
//        [sm playSounds:TTActionTypeDidClear];
//        sm = nil;
//    }

    if ([newImageView.numeratorNumber  isEqual:@10] && [newImageView.denominatorNumber isEqual:@1]) {
        TTSoundManager *sm = [TTSoundManager init];
        [sm playSounds:TTActionTypeDidClear];
        sm = nil;
    }
    
    //UIViewController*vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    //DLog(@"%@", vc);
    //[[vc view] addSubview:label5];
    
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"didAppearNewLabel" object:newLabel];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didAppearNewImageView" object:newImageView];
}


// -------------------------------------------------------
//  要らなくなる
// -------------------------------------------------------
+ (int)calculateOutput:(int)a and:(int)b withOpe:(TTFiledType)fieldType
{
    int output = 0;
    DLog(@"fieldType = %d", fieldType);
    switch (fieldType) {
        case TTFiledTypeAddtion:
            output = a + b;
            break;
        case TTFiledTypeSubtraction:
            output = a - b;
            break;
        case TTFiledTypeMultiplication:
            output = a * b;
            break;
        case TTFiledTypeDivision:
            if (a % b == 0) {
                output =  a / b;
            } else {
                DLog(@"fraction");
            }
        default:
            break;
    }
    DLog(@"output = %d", output);
    return output;
    
    
}
               
               
+ (int)determineOperator:(TTImageView *)aView
{
    int ope = 0;
    
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    // UIViewController *vc = [[[[[UIApplication sharedApplication] delegate] window] rootViewController]presentingViewController];
    
    for (UIView *aField in [[vc view] subviews]) {
        DLog(@"????????????????");
        if (![[aField class] isSubclassOfClass:[TTImageView class]] && CGRectContainsRect(aField.frame, aView.frame)) {
            DLog(@"%@", aField);
            ope = (int)aField.tag;
            DLog(@"ope = %d", ope);
            break;
        } else {
            DLog(@"えるす");
        }
    }
    DLog(@"ope = %d", ope);
    return ope;
}
@end
