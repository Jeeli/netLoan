//
//  upRefresh.h
//  Sd
//
//  Created by IOS on 15/8/10.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Refresh : UIView
@property(nonatomic,copy) void (^loadingBlock)();
@property(nonatomic,copy) void (^finshBlock)(NSString *,NSString *);
@property(nonatomic,copy) void (^beforeLoadingBlock)(NSString *,NSString *);
@property(nonatomic,copy) void (^initBlock) (NSString *,NSString *,NSString *);
@end
