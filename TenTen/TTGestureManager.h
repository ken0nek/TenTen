//
//  TTGestureManager.h
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/09.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTViewController.h"
#import "TTViewManager.h"
#import "TTImageView.h"

@interface TTGestureManager : NSObject

+ (void)setDragForView:(UIView *)view;

+ (void)dragView:(UIPanGestureRecognizer *)sender;

+ (void)checkIntersection:(UIPanGestureRecognizer *)sender;

+ (void)didIntersect:(TTImageView *)aView withView:(TTImageView *)bView at:(CGPoint)point;

//+ (void)didIntersect:(UILabel *)aView withView:(UILabel *)bView at:(CGPoint)point;

+ (CGPoint)calculateDistance:(UIPanGestureRecognizer *)sender;
@end
