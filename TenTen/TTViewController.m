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
    NSString *aLine;
    int figures[4];
}

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"combination" ofType:@"txt"];
    if (filePath) {
        NSString *contentOfFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSArray *lines = [contentOfFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSLog(@"%@", lines);
        int randomNumber = arc4random() % [lines count];
        aLine = lines[randomNumber];
        NSLog(@"%d", [aLine intValue]);
    }
    
    [self convertToArray:aLine];
    
    for (int i  = 0; i < 4; i++) {
        int x, y;
        if ((i + 1) % 2) {
            x = 100;
            y += 100;
        }else{
            x += 100;
        }
        
        UILabel *label = [[UILabel alloc] init];
        label = [TTViewManager TTMakeLabel:CGPointMake(x, y) withTag:i withNumber:figures[i]];
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

- (void)convertToArray:(NSString *)combinationString
{
    int combinationInt = [combinationString intValue];
    for (int i = 0; i < 4; i++) {
        figures[i] = combinationInt % 10;
        NSLog(@"%d", figures[i]);
        combinationInt /= 10;
    }
    
    
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
