//
//  newNoticeHeaderView.h
//  Sd
//
//  Created by IOS on 15/8/6.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  noticeModel;
@protocol newNoticeDelegate <NSObject>
-(void)changeCellState:(NSInteger) tag;
@end

@interface newNoticeHeaderView : UITableViewHeaderFooterView
@property(nonatomic,assign) id<newNoticeDelegate> delegate;
@property(nonatomic,retain) noticeModel * ntc_model;
-(void) setTag:(NSInteger) tag;
-(void) setDownImg;
-(void) setUpImg;
@end

