//
//  TTSoundManager.m
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/14.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import "TTSoundManager.h"

@interface TTSoundManager ()
{
    NSArray *soundNameArray;
}

@end

@implementation TTSoundManager

- (void)playSounds:(TTActionType)type
{
    //音声ファイルを読み込んで、soundURLを生成
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundURL;
    SystemSoundID soundID;
    NSString *soundName = soundNameArray[type];
    DLog(@"%@", soundName);
    CFStringRef soundNameCF = (__bridge CFStringRef)soundName;
    soundURL = CFBundleCopyResourceURL(mainBundle, soundNameCF,CFSTR("mp3"),nil);
    AudioServicesCreateSystemSoundID(soundURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
}

+ (id)init{
    return [[self alloc] init];
}

- (id)init{
    self = [super init];

    DLog(@"setSoundArray");
    
    soundNameArray = @[@"poyo", @"surprise"];
    
    return self;
}

@end
