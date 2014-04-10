//
//  TTViewController.m
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/09.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTViewController.h"

#import "TTGestureManager.h"

#import "TTViewManager.h"

@interface TTViewController ()
{
    TTViewManager *vm;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
}

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    label1 = [TTViewManager TTMakeLabel:CGPointMake(100, 200) withTag:0 withNumber:1];
//    label2 = [TTViewManager TTMakeLabel:CGPointMake(200, 200) withTag:1 withNumber:2];
//    label3 = [TTViewManager TTMakeLabel:CGPointMake(100, 300) withTag:2 withNumber:3];
//    label4 = [TTViewManager TTMakeLabel:CGPointMake(200, 300) withTag:3 withNumber:4];
//    
//    [self.view addSubview:label1];
//    [self.view addSubview:label2];
//    [self.view addSubview:label3];
//    [self.view addSubview:label4];
//    
//    [TTGestureManager setDragForView:label1];
//    [TTGestureManager setDragForView:label2];
//    [TTGestureManager setDragForView:label3];
//    [TTGestureManager setDragForView:label4];
    
    for (int i  = 0; i < 4; i++) {
        int x, y;
        if ((i + 1) % 2) {
            x = 100;
            y += 100;
        }else{
            x += 100;
        }
        
        UILabel *label = [[UILabel alloc] init];
        label = [TTViewManager TTMakeLabel:CGPointMake(x, y) withTag:i withNumber:(i + 1)];
        [self.view addSubview:label];
        [TTGestureManager setDragForView:label];
    }
    
//    NSLog(@"%@", NSStringFromClass([[self.view viewWithTag:0] class]));
//    NSLog(@"%@", [self.view subviews]);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"add-label"
                                                      object:nil queue:nil usingBlock:^(NSNotification *note) {
                                                          [self.view addSubview:note.object];
                                                      }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// -------------------------------------------------------
//  10ができる組み合わせのデータ
// -------------------------------------------------------

// -------------------------------------------------------
//  画像の名前は1.png-9.png
// -------------------------------------------------------

// -------------------------------------------------------
//  UIImageView+TTを作って、@property numberを加える
// -------------------------------------------------------

@end
