//
//  TimeHelp.m
//  block
//
//  Created by IOS on 15/8/25.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "TimeHelp.h"
@implementation TimeHelp
+(NSString *) getNowTime:(TIME_PARANETER) parameter{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* date= [formatter stringFromDate:[NSDate date]];
    
    NSDate* now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    NSDateComponents *dt = [cal components:unitFlags fromDate:now];
    NSInteger y = [dt year];
    NSInteger m = [dt month];
    NSInteger d = [dt day];
    NSInteger hour = [dt hour];
    NSInteger min = [dt minute];
    NSInteger sec = [dt second];
    NSString * time;
    switch (parameter){
        case TIME_YEAR:
            time=[NSString stringWithFormat:@"%ld",(long)y];
            break;
        case TIME_MONTH:
            time=[NSString stringWithFormat:@"%ld",(long)m];
            break;
        case TIME_DAY:
            time=[NSString stringWithFormat:@"%ld",(long)d];
            break;
        case TIME_HOUR:
            time=[NSString stringWithFormat:@"%ld",(long)hour];
            break;
        case TIME_MINUTE:
            time=[NSString stringWithFormat:@"%ld",(long)min];
            break;
        case TIME_SECOND:
            time=[NSString stringWithFormat:@"%ld",(long)sec];
            break;
        default:
            time=date;
            break;
    }
    return time;
}
@end
