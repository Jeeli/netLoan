//
//  Login.h
//  Sd
//
//  Created by IOS on 15/7/14.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol setContentDelegate <NSObject>
-(void) setContent:(NSString *) txtContent;
@end

@interface Login : UIViewController
@property(nonatomic,assign) id<setContentDelegate> setdelegate;
@end
