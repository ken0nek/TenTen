//
//  TTGestureManager.m
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/09.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTGestureManager.h"
#import "TTViewController.h"
#import "TTViewManager.h"


@interface TTGestureManager ()


@end

@implementation TTGestureManager

+ (void)setDragForView:(UIView *)view
{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

+ (void)dragView:(UIPanGestureRecognizer *)sender
{
    UIView *targetView = sender.view;
    
    NSLog(@"tag of target = %d", (int)targetView.tag);
    
    CGPoint p = [sender translationInView:targetView];
    
    CGPoint movedPoint = CGPointMake(targetView.center.x + p.x, targetView.center.y + p.y);
    
    NSLog(@"now at %@", NSStringFromCGPoint(movedPoint));
    
    targetView.center = movedPoint;
    
    [sender setTranslation:CGPointZero inView:targetView];
    
//    TTViewController *vc = [[TTViewController alloc] init];
//    [vc.view bringSubviewToFront:targetView];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self checkIntersection:sender];
    }
}

+ (void)checkIntersection:(UIPanGestureRecognizer *)sender
{
    TTViewController *vc = [[TTViewController alloc] init];
    
//    for (UIView *aView in vc.view.subviews) {
//        if (CGRectIntersectsRect(aView.frame, sender.view.frame)) {
//            if (aView.tag == sender.view.tag) {
//                break;
//            }
//            NSLog(@"Intersect! aView.tag = %d and sender.view.tag = %d", (int)aView.tag, (int)sender.view.tag);
//            [self didIntersect:aView with:sender.view];
//        } else {
//            NSLog(@"Not intersect!");
//     
//        }
//    }

    for (UILabel *aView in vc.view.subviews) {
        if (CGRectIntersectsRect(aView.frame, sender.view.frame)) {
            NSLog(@"Intersect! aView.tag = %d and sender.view.tag = %d", (int)aView.tag, (int)sender.view.tag);
            [self didIntersect:aView with:sender.view];
            break;
        } else {
            NSLog(@"Not intersect!");
            
        }
    }
}

+ (void)didIntersect:(UILabel *)aView with:(UILabel *)bView
{
    int aNumber = [aView.text intValue];
    int bNumber = [bView.text intValue];
    int sum = aNumber + bNumber;
    
    //[aView removeFromSuperview];
    //[bView removeFromSuperview];
    
    TTViewController *vc = [[TTViewController alloc] init];
    UILabel *label5 = [TTViewManager TTMakeLabel:CGPointMake(200, 400)  withTag:4 withNumber:sum];
    NSLog(@"%@", label5);
    [vc.view addSubview:label5];
    NSLog(@"%@", NSStringFromClass([[label5 superclass] class]));
}
@end
