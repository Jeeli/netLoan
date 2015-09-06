//
//  withdrawModel.m
//  Sd
//
//  Created by IOS on 15/8/12.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "withdrawModel.h"

@implementation withdrawModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self=[super init]) {
        //网络请求获取的数据
        
        NSString *time = [NSString stringWithFormat:@"%@",dic[@"addtime"]];
        NSInteger num = [time integerValue];
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
        NSDate  *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];
        NSString  *confromTimespStr = [formatter stringFromDate:confromTimesp];
        _withdrawNumber=dic[@"total"];
        if ([dic[@"status"] isEqual:@"0"]) {
            _withdrawStatus=@"待审核";
        }else if([dic[@"status"] isEqual:@"1"]){
            _withdrawStatus=@"成功";
            
        }else{
            _withdrawStatus=@"失败";
        }
        _withdrawTime=confromTimespStr;
    }
    return self;
}

@end
