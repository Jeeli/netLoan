//
//  macroAndEnum.h
//  block
//
//  Created by IOS on 15/8/25.
//  Copyright (c) 2015年 IOS. All rights reserved.
//
/**
 *  LCiOS 宏、枚举文件
 */
#import <Foundation/Foundation.h>
@interface macroAndEnum : NSObject
/**
 *  TimeHelp
 */
typedef enum TIME{
    TIME_YEAR=0,
    TIME_MONTH=1<<0,
    TIME_DAY=1<<1,
    TIME_HOUR=1<<2,
    TIME_MINUTE=1<<3,
    TIME_SECOND=1<<4,
    TIME_ALL=1<<5
}TIME_PARANETER;
/**
 *  RefreshHelp
 */
@end
