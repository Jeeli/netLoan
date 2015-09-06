//
//  noticeTablewViewCellTableViewCell.h
//  Sd
//
//  Created by IOS on 15/8/19.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  noticeModel;
@protocol newNoticeheightDelegate <NSObject>
-(void)webViewDidFinishLoad:(UIWebView *) wView;
@end

@interface noticeTablewViewCellTableViewCell : UITableViewCell
@property(nonatomic,copy) NSDictionary * noticeModel;
@property(nonatomic,assign) id<newNoticeheightDelegate> delegate;
-(void) setName:(NSString *) str;
@end
