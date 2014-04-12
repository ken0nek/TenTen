//
//  TTViewController.m
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/09.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTViewController.h"


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
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"didAppearNewImageView"
                                                      object:nil queue:nil usingBlock:^(NSNotification *note) {
                                                          NSLog(@"%@", note.object);
                                                          [self.view addSubview:note.object];
                                                      }];
    
    [self loadTextFile];
    
    [self convertToArray:aLine];
    
    // [self displayDigitImageView];
    
    NSLog(@"%s", __func__);
    
    
    for (int i  = 0, dx = 0, dy = 0; i < 4; i++) {
        if ((i + 1) % 2) {
            dx = 100;
            dy += 100;
        } else {
            dx += 100;
        }
        
        //        UILabel *label = [[UILabel alloc] init];
        //        label = [TTViewManager TTMakeLabel:CGPointMake(x, y) withTag:i withNumber:figures[i]];
        //        [self.view addSubview:label];
        //        [TTGestureManager setDragForView:label];
        
        TTImageView *imageView = [[TTImageView alloc] init];
        imageView = [TTViewManager TTMakeImageView:CGPointMake(dx, dy) withTag:i withNumber:figures[i]];
        [self.view addSubview:imageView];
        [TTGestureManager setDragForView:imageView];
    }
    
    for (int j = 0, fx = 0, fy = 140; j < 4; j++) {
        if ((j + 1) % 2) {
            fx = 20;
            fy += fieldImageHeight;
        } else {
            fx += fieldImageWidth;
        }
        UIImageView *imageView =[[UIImageView alloc] init];
        imageView = [TTViewManager TTMakeFieldImageView:CGPointMake(fx, fy) withTag:j];
        [self.view addSubview:imageView];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Define Methods

- (void)loadTextFile
{
    NSLog(@"%s", __func__);
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"combination" ofType:@"txt"];
    if (filePath) {
        NSString *contentOfFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        //NSArray *lines = [contentOfFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSArray *lines = [contentOfFile componentsSeparatedByString:@"\n"];
        NSLog(@"%@", lines);
        int randomNumber = arc4random() % [lines count];
        aLine = lines[randomNumber];
        NSLog(@"%d", [aLine intValue]);
    }
}

- (void)convertToArray:(NSString *)combinationString
{
    NSLog(@"%s", __func__);
    int combinationInt = [combinationString intValue];
    for (int i = 0; i < 4; i++) {
        figures[i] = combinationInt % 10;
        NSLog(@"%d", figures[i]);
        combinationInt /= 10;
    }
}

// -------------------------------------------------------
//  TODO: [self ~];だとimageViewが表示されない
// -------------------------------------------------------

- (void)displayDigitImageView
{
    NSLog(@"%s", __func__);
    for (int i  = 0; i < 4; i++) {
        int x, y;
        if ((i + 1) % 2) {
            x = 100;
            y += 100;
        }else{
            x += 100;
        }
        
        //        UILabel *label = [[UILabel alloc] init];
        //        label = [TTViewManager TTMakeLabel:CGPointMake(x, y) withTag:i withNumber:figures[i]];
        //        [self.view addSubview:label];
        //        [TTGestureManager setDragForView:label];
        TTImageView *imageView = [[TTImageView alloc] init];
        // imageView = [TTViewManager TTMakeImageView:CGPointMake(x, y) withTag:i withNumber:figures[i]];
        imageView = [TTViewManager TTMakeImageView:CGPointMake(x, y) withTag:i withNumber:(i + 1)];
        [self.view addSubview:imageView];
        [TTGestureManager setDragForView:imageView];
    }
}

@end
