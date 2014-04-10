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
{
    
}


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
    
    NSLog(@"tag of target = %d", (int)targetView.tag);
    
    // CGPoint p = [sender translationInView:targetView];
    
    CGPoint movedPoint = [self calculateDistance:sender];
    
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
    //UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

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

    for (UILabel *aView in sender.view.superview.subviews) {
        if ([[aView class] isSubclassOfClass:[UILabel class]]) {
            if (CGRectIntersectsRect(aView.frame, sender.view.frame)) {
                if (aView.tag != sender.view.tag) {
                    NSLog(@"Intersect! aView.tag = %d and sender.view.tag = %d", (int)aView.tag, (int)sender.view.tag);
                    [self didIntersect:aView withView:(UILabel *)sender.view at:[self calculateDistance:sender]];
                    break;
                }
            } else {
                NSLog(@"Not intersect!");
                
            }
        }
    }
}

+ (void)didIntersect:(UILabel *)aView withView:(UILabel *)bView at:(CGPoint)point
{
    int aNumber = [aView.text intValue];
    int bNumber = [bView.text intValue];
    int sum = aNumber + bNumber;
    
    [aView removeFromSuperview];
    [bView removeFromSuperview];
    
    UILabel *label5 = [TTViewManager TTMakeLabel:point  withTag:4 withNumber:sum];
    NSLog(@"%@", label5);
    
    //UIViewController*vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    //NSLog(@"%@", vc);
    //[[vc view] addSubview:label5];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"add-label" object:label5];
    
}
@end
