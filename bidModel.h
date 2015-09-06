//
//  bidModel.h
//  Sd
//
//  Created by IOS on 15/8/7.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bidModel : NSObject
@property(nonatomic,copy) NSString* ID;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * scale;
@property(nonatomic,copy) NSString * time_limit_day;
@property(nonatomic,copy) NSString * account;
@property(nonatomic,copy) NSString * time_limit;
@property(nonatomic,copy) NSString * bidscale;

+(instancetype) bidModelSetWithDic:(NSDictionary *) dic;
-(instancetype) initWithDic:(NSDictionary *) dic;
@end
