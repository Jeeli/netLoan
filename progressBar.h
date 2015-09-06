//
//  progressBar.h
//  进度条
//
//  Created by IOS on 15/7/27.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface progressBar : UIView
//内圆颜色
@property (strong, nonatomic)UIColor *centerColor;
//进度条背景色（外圆颜色）
@property (strong, nonatomic)UIColor *progressBarBackgroundColor;
//进度条进度颜色
@property (strong, nonatomic)UIColor *progressBarFinishColor;
@property (strong, nonatomic)UIColor *progressBarUnfinishColor;
//百分比数值（0-1）
@property (assign, nonatomic)float percent;
//圆环宽度
@property (assign, nonatomic)float width;

@property(nonatomic,copy) NSString * flag;
@property(nonatomic,copy) NSString * type;
@property(nonatomic,copy) NSString * state;

@end
