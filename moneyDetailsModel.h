//
//  moneyDetailsModel.h
//  Sd
//
//  Created by IOS on 15/8/13.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface moneyDetailsModel : NSObject
@property(nonatomic,copy) NSString * moneyDetailsNumber;
@property(nonatomic,copy) NSString * moneyDetailsType;
@property(nonatomic,copy) NSString * Time;
@property(nonatomic,copy) NSString * moneyDetailsUseMoney;
-(instancetype) initWithDic:(NSDictionary *) dic;
@end
