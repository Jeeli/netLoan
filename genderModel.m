//
//  genderModel.m
//  Sd
//
//  Created by IOS on 15/7/22.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "genderModel.h"

@implementation genderModel

- (instancetype)initGender{
    if (self=[super init]) {
        _ary_gender=[NSArray arrayWithObjects:@"男",@"女", nil];
    }
    return self;
}
+ (instancetype)gender{
    return [[self alloc] initGender];
}
@end
