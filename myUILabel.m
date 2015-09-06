//
//  myUILabel.m
//  Sd
//
//  Created by IOS on 15/7/23.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "myUILabel.h"

@implementation myUILabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    if (self=[super init]) {
    }
    return self;
}
- (void)addAry_name:(NSString *)name{
    if (_ary_name==nil) {
        _ary_name=[[NSMutableArray alloc] init];
    }
    [_ary_name addObject:name];
}
- (instancetype)getName{
    return _ary_name[0];
}

@end
