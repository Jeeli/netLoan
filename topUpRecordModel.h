//
//  topUpRecordModel.h
//  Sd
//
//  Created by IOS on 15/8/11.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface topUpRecordModel : NSObject
@property(nonatomic,copy) NSString * topUpNumber;
@property(nonatomic,copy) NSString * topUpType;
@property(nonatomic,copy) NSString * topUpStatus;
@property(nonatomic,copy) NSString * topUpTime;
-(instancetype) initWithDic:(NSDictionary *) dic;
@end
