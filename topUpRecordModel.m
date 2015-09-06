//
//  topUpRecordModel.m
//  Sd
//
//  Created by IOS on 15/8/11.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "topUpRecordModel.h"

@implementation topUpRecordModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self=[super init]) {
        //转换时间格式
        //如何如何将一个字符串如“ 20110826134106”装化为任意的日期时间格式，
        /*NSString* string = @"20110826134106";
        NSDateFormatter *inputFormatter =[[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
        NSDate* inputDate = [inputFormatter dateFromString:string];
        NSDateFormatter *outputFormatter =[[NSDateFormatter alloc] init];
        [outputFormatter setLocale:[NSLocale currentLocale]];
        [outputFormatter setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒"];
        NSString *str = [outputFormatter stringFromDate:inputDate];
        myLog(@"str=%@",str);*/
        
        //从服务器段获取到的字符串转化为时间
        
        //网络请求获取的数据
        
        NSString *time = [NSString stringWithFormat:@"%@",dic[@"addtime"]];
        NSInteger num = [time integerValue];
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
        NSDate  *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];
        NSString  *confromTimespStr = [formatter stringFromDate:confromTimesp];
        _topUpNumber=dic[@"payment"];
        if ([dic[@"status"] isEqual:@"0"]) {
            _topUpStatus=@"待审核";
        }else if([dic[@"status"] isEqual:@"1"]){
            _topUpStatus=@"成功";

        }else{
            _topUpStatus=@"失败";
        }
        _topUpTime=confromTimespStr;
        _topUpType=dic[@"remark"];
    }
    return self;
}
@end
