//
//  mybutton.m
//  Sd
//
//  Created by IOS on 15/7/13.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "mybuttonV.h"
#import "addConstraints.h"
@interface mybutton()
@end
@implementation mybutton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame=CGRectMake(0, 0, self.frame.size.width,self.frame.size.height/3*2);
    self.imageView.contentMode=UIViewContentModeCenter;
    self.titleLabel.frame=CGRectMake(0, self.frame.size.height/3*2+1,self.frame.size.width,self.frame.size.height/3-1);
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:12];//title字体大小
}
// 重写去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted {}

@end
