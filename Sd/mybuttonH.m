//
//  mybuttonH.m
//  Sd
//
//  Created by IOS on 15/7/17.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "mybuttonH.h"

@implementation mybuttonH

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)addAry_name:(NSString *)name{
    if (_ary_name==nil) {
        _ary_name=[[NSMutableArray alloc] init];
    }
    [_ary_name addObject:name];
}
- (instancetype)getName{
    return _ary_name[0];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame=CGRectMake(0, 0, self.frame.size.width/3,self.frame.size.height);
    self.imageView.contentMode=UIViewContentModeCenter;
    self.titleLabel.frame=CGRectMake(self.frame.size.width/3, 0,self.frame.size.width/3*2,self.frame.size.height);
    self.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
    //self.titleLabel.textColor=Color(189, 84, 79);
    self.imageView.contentMode=UIViewContentModeRight;
}
- (void)setHighlighted:(BOOL)highlighted{}

@end
