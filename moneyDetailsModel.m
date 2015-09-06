//
//  moneyDetailsModel.m
//  Sd
//
//  Created by IOS on 15/8/13.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "moneyDetailsModel.h"

@implementation moneyDetailsModel
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
        _Time=confromTimespStr;
        _moneyDetailsNumber=dic[@"total"];
        if ([NSNull null] != [dic objectForKey:@"remark"]) {
            _moneyDetailsType=dic[@"remark"];
        }else{
            _moneyDetailsType=@"NULL";
        }
        _moneyDetailsUseMoney=dic[@"money"];
    }
    return self;
}

@end
