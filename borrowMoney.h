//
//  borrowMoney.h
//  Sd
//
//  Created by IOS on 15/7/28.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface borrowMoney : UIViewController
@property(nonatomic,copy) NSString * (^idBlock)();
@property(nonatomic,copy) NSString * (^nameBlock)();
@end
