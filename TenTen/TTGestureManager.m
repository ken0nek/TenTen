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
    
    // NSLog(@"tag of target = %d", (int)targetView.tag);
    
    // CGPoint p = [sender translationInView:targetView];
    
    CGPoint movedPoint = [self calculateDistance:sender];
    
    // NSLog(@"now at %@", NSStringFromCGPoint(movedPoint));
    
    targetView.center = movedPoint;
    
    [sender setTranslation:CGPointZero inView:targetView];
    
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [[vc view] addSubview:targetView];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self checkIntersection:sender];
    }
}

+ (void)checkIntersection:(UIPanGestureRecognizer *)sender
{
    //UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

    for (UIView *aView in sender.view.superview.subviews) {
        if ([[aView class] isSubclassOfClass:[TTImageView class]]) {
            if (CGRectIntersectsRect(aView.frame, sender.view.frame)) {
                if (aView.tag != sender.view.tag) {
                    [self didIntersect:(TTImageView *)aView withView:(TTImageView *)sender.view at:[self calculateDistance:sender]];
                    NSLog(@"Intersect! aView.tag = %d and sender.view.tag = %d", (int)aView.tag, (int)sender.view.tag);
                    break;
                }
            } else {
                NSLog(@"Not intersect!");
                
            }
        }
    }
//    for (UILabel *aView in sender.view.superview.subviews) {
//        if ([[aView class] isSubclassOfClass:[UILabel class]]) {
//            if (CGRectIntersectsRect(aView.frame, sender.view.frame)) {
//                if (aView.tag != sender.view.tag) {
//                    NSLog(@"Intersect! aView.tag = %d and sender.view.tag = %d", (int)aView.tag, (int)sender.view.tag);
//                    [self didIntersect:aView withView:(UILabel *)sender.view at:[self calculateDistance:sender]];
//                    break;
//                }
//            } else {
//                NSLog(@"Not intersect!");
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
//    //NSLog(@"%@", vc);
//    //[[vc view] addSubview:label5];
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"didAppearNewLabel" object:newLabel];
//    
//}

+ (void)didIntersect:(TTImageView *)aView withView:(TTImageView *)bView at:(CGPoint)point
{
    int aNumber = [aView.number intValue];
    int bNumber = [bView.number intValue];
    int sum = aNumber + bNumber;
    
    [aView removeFromSuperview];
    [bView removeFromSuperview];
    
    // UILabel *newLabel = [TTViewManager TTMakeLabel:point withTag:4 withNumber:sum];
    TTImageView *newImageView = [TTViewManager TTMakeImageView:point withTag:sum withNumber:sum];
    // [TTGestureManager setDragForView:newLabel];
    [TTGestureManager setDragForView:newImageView];
    
    //UIViewController*vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    //NSLog(@"%@", vc);
    //[[vc view] addSubview:label5];
    
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"didAppearNewLabel" object:newLabel];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didAppearNewImageView" object:newImageView];
}
@end
