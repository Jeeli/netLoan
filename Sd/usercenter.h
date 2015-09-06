//
//  usercenter.h
//  Sd
//
//  Created by IOS on 15/7/13.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol userCenterDelegate <NSObject>
-(void) goHome;
@end


@interface usercenter : UIViewController
@property(nonatomic,copy) NSString * flag;
@property(nonatomic,assign) id<userCenterDelegate> delegate;
@end
