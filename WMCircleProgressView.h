//
//  WMCircleProgressView.h
//  R6Watch
//
//  Created by maginawin on 15/5/29.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMCircleProgressView : UIView

/** 初始化进度条, 必须实现 */
- (void)setupProgressLayerColor:(UIColor*)progressColor backgroundColor:(UIColor*)backgroundColor lineWidth:(CGFloat)lineWidth;

/** 更新进度条值 */
- (void)updateProgressCurrent:(CGFloat)aCurrent;
     
/** 取当前进度条值 */
- (CGFloat)current;



@end
