//
//  TTMenuViewController.m
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/16.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTMenuViewController.h"

@interface TTMenuViewController ()

@end

@implementation TTMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)goSingle:(id)sender
{
    [self performSegueWithIdentifier:@"goSingle" sender:self];
}

- (IBAction)goMulti:(id)sender
{
    [self performSegueWithIdentifier:@"goMulti" sender:self];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
