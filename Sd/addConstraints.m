//
//  addConstraints.m
//  通讯录
//
//  Created by IOS on 15/7/10.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "addConstraints.h"

@implementation addConstraints
- (void)addMetrics:(NSDictionary *)Metrics andViews:(NSDictionary *)Views andSuper:(UIView *)Super andConstraints:(NSArray *)array{
    for (NSString * str_obj in array) {
        [Super addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:str_obj options:NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop metrics:Metrics views:Views]];
    }
}

@end
