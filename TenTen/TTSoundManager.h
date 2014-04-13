//
//  TTSoundManager.h
//  TenTen
//
//  Created by Ken Tominaga on 2014/04/14.
//  Copyright (c) 2014年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AudioToolbox;

@interface TTSoundManager : NSObject

- (void)playSounds:(TTActionType)type;

+ (id)init;
@end
