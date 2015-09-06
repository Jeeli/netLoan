//
//  noticeModel.h
//  Sd
//
//  Created by IOS on 15/8/7.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface noticeModel : NSObject
@property(nonatomic,assign) BOOL isHidden;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * time;
@property(nonatomic,copy) NSString * img_flag;
@end
