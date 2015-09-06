//
//  genderModel.h
//  Sd
//
//  Created by IOS on 15/7/22.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface genderModel : NSObject
@property(nonatomic,retain) NSArray * ary_gender;
- (instancetype) initGender;
+ (instancetype) gender;
@end
