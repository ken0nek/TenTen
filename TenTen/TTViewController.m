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
    int figures[4];
    NSArray *lines;
    NSMutableArray *linesByLevel;
    int level;
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
    
    
    level = TTGameLevelEasy;
    
    [self loadCSVFile];
    
    [self loadCSVFileWithLevel:level];
    
    [self convertToArray];
    
    [self displayDigitImageView];
    
    NSLog(@"%s", __func__);
    
//    for (int i  = 0, dx = 0, dy = 0; i < 4; i++) {
//        if ((i + 1) % 2) {
//            dx = 100;
//            dy += 100;
//        } else {
//            dx += 100;
//        }
//        
//        //        UILabel *label = [[UILabel alloc] init];
//        //        label = [TTViewManager TTMakeLabel:CGPointMake(x, y) withTag:i withNumber:figures[i]];
//        //        [self.view addSubview:label];
//        //        [TTGestureManager setDragForView:label];
//        
//        TTImageView *imageView = [[TTImageView alloc] init];
//        imageView = [TTViewManager TTMakeImageView:CGPointMake(dx, dy) withTag:i withNumber:figures[i]];
//        NSLog(@"%@", imageView);
//        [self.view addSubview:imageView];
//        [TTGestureManager setDragForView:imageView];
//    }
    
    for (int j = 0, fx = 0, fy = 140; j < 4; j++) {
        if ((j + 1) % 2) {
            fx = 20;
            fy += FieldImageHeight;
        } else {
            fx += FieldImageWidth;
        }
        UIImageView *imageView =[[UIImageView alloc] init];
        imageView = [TTViewManager TTMakeFieldImageView:CGPointMake(fx, fy) withTag:j];
        [self.view addSubview:imageView];
    }
    
//    TTImageView *imageView = [[TTImageView alloc] init];
//    imageView = [TTViewManager TTMakeImageView:CGPointMake(120, 200) withTag:0 withNumber:49];
//    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Define Methods

- (void)loadCSVFile
{
    NSLog(@"%s", __func__);
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"combination_all" ofType:@"csv"];
    if (filePath) {
        NSString *contentOfFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        //NSArray *lines = [contentOfFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        lines = [contentOfFile componentsSeparatedByString:@"\n"];
        NSLog(@"%@", lines);
    }
}

- (void)loadCSVFileWithLevel:(TTGameLevel)gameLevel
{
    linesByLevel = [[NSMutableArray alloc] init];
    
    for (NSString *item in lines) {
        NSArray *itemArray = [item componentsSeparatedByString:@","];
        if ([itemArray[0] intValue] == gameLevel) {
            [linesByLevel addObject:itemArray[1]];
        }
    }
    NSLog(@"%@", linesByLevel);
}

- (IBAction)levelButtonPushed:(UIButton *)sender
{
    switch (sender.tag) {
        case TTGameLevelEasy:
            [self loadCSVFileWithLevel:TTGameLevelEasy];
            break;
        case TTGameLevelMidium:
            [self loadCSVFileWithLevel:TTGameLevelMidium];
            break;
        case TTGameLevelHard:
            [self loadCSVFileWithLevel:TTGameLevelHard];
            break;
        default:
            break;
    }
}

- (void)convertToArray
{
    [self loadCSVFileWithLevel:level];
    
    int randomNumber = arc4random() % [linesByLevel count];
    NSString *aLine = linesByLevel[randomNumber];
    NSLog(@"%d", [aLine intValue]);
    
    NSLog(@"%s", __func__);
    int combinationInt = [aLine intValue];
    for (int i = 0; i < 4; i++) {
        figures[i] = combinationInt % 10;
        NSLog(@"%d", figures[i]);
        combinationInt /= 10;
    }
}

- (void)displayDigitImageView
{
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
}

- (IBAction)Refresh
{
    [TTViewManager TTDeleteImageView];
    
    [self convertToArray];
    
    [self displayDigitImageView];
}

- (IBAction)Undone
{
    [TTViewManager TTDeleteImageView];
    
    [self displayDigitImageView];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
