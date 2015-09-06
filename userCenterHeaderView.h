//
//  userCenterHeadView.h
//  Sd
//
//  Created by IOS on 15/7/20.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol goControllerDelegate <NSObject>
-(void) goWithdraw;
-(void) goBid;
@end
@interface userCenterHeaderView : UIView
- (instancetype) initWithUserImage:(NSString *) imageName andUserName:(NSString *) userName andAvailable:(NSString *) available andFreeze:(NSString *) freeze andTotal:(NSString *) total;
@property(nonatomic,copy) void (^block_userName)(NSString *);
@property(nonatomic,copy) void (^setDataBlock)(NSDictionary *);
@property(nonatomic,assign) id<goControllerDelegate> delegate;
@property(nonatomic,copy) void (^gobidBlock)();
@property(nonatomic,copy) void (^goLoginBlock)();
-(void) setImage:(NSString *) url;
@end
