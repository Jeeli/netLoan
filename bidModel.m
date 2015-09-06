//
//  bidModel.m
//  Sd
//
//  Created by IOS on 15/8/7.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "bidModel.h"

@implementation bidModel
-(instancetype) initWithDic:(NSDictionary *)dic{
    if (self=[super init]) {
        _ID=dic[@"id"];
        _name=dic[@"name"];
        _scale=dic[@"apr"];
        _time_limit_day=dic[@"time_limit_day"];
        _account=dic[@"account"];
        _time_limit=dic[@"time_limit"];
        _bidscale=dic[@"scale"];
    }
    return  self;
}
+ (instancetype)bidModelSetWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}
@end
