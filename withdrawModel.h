//
//  withdrawModel.h
//  Sd
//
//  Created by IOS on 15/8/12.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface withdrawModel : NSObject
@property(nonatomic,copy) NSString * withdrawNumber;
@property(nonatomic,copy) NSString * withdrawStatus;
@property(nonatomic,copy) NSString * withdrawTime;
-(instancetype) initWithDic:(NSDictionary *) dic;
@end
