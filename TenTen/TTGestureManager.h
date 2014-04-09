//
//  TTGestureManager.h
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/09.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTGestureManager : NSObject

+ (void)setDragForView:(UIView *)view;

+ (void)dragView:(UIPanGestureRecognizer *)sender;

+ (void)checkIntersection:(UIPanGestureRecognizer *)sender;

+ (void)didIntersect:(UIView *)aView with:(UIView *)bView;
@end
