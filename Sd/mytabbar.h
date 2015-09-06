//
//  mytabbar.h
//  Sd
//
//  Created by IOS on 15/7/13.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol selectindexDelegate <NSObject>
-(void) selecttindex:(UIButton *) button;
@end
@interface mytabbar : UIView
@property(nonatomic,strong) id<selectindexDelegate> mytabardelegate;
- (instancetype) initWithbutton:(int) number andSuper:(UIView *) Super;
+(instancetype) tabarWithbutton:(int) number andSuper:(UIView *) Super;
@end
