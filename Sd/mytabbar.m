//
//  mytabbar.m
//  Sd
//
//  Created by IOS on 15/7/13.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "mytabbar.h"
#import "addConstraints.h"
#import "mybuttonV.h"
@interface mytabbar()
@property(nonatomic,weak) UIButton * btn_old;
@property(nonatomic,assign) NSInteger i;
@end
@implementation mytabbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithbutton:(int)number andSuper:(UIView *)Super
{
    if(self=[super init])
    {
        _i=0;
        NSArray *array_name=@[@"首页",@"我要理财",@"用户中心",@"设置"];
        NSArray *array_image=@[@"home.png",@"finance.png",@"usercenter.png",@"set.png",@"首页",@"我要理财",@"账户中心",@"设置"];
        double width=Super.frame.size.width/number;
        for (int i=0; i<number; i++) {
            mybutton * my_button=[mybutton buttonWithType:UIButtonTypeCustom];
            [self addSubview:my_button];
            [my_button setTag:i];
            if (i==0) {
                my_button.selected=YES;
                _btn_old=my_button;
            }
            [my_button setTitle:array_name[i] forState:UIControlStateNormal];
            [my_button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [my_button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [my_button setImage:[UIImage imageNamed:array_image[i]] forState:UIControlStateNormal];
            [my_button setImage:[UIImage imageNamed:array_image[i+4]] forState:UIControlStateSelected];
            my_button.translatesAutoresizingMaskIntoConstraints=NO;
             NSDictionary *metrcs=@{@"my_button_width":[NSNumber numberWithDouble:width],@"button_margin":[NSNumber numberWithDouble:width*i]};
             NSDictionary *viewsDic=@{@"my_button":my_button};
             NSArray *array=@[
                             @"H:|-button_margin-[my_button(==my_button_width)]",
                             @"V:|-0-[my_button]-0-|"];
            //添加约束
            addConstraints *addconstraints=[[addConstraints alloc] init];
            [addconstraints addMetrics:metrcs andViews:viewsDic andSuper:self andConstraints:array];
            [my_button addTarget:self action:@selector(selectbutton:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    return  self;
}
+ (instancetype)tabarWithbutton:(int)number andSuper:(UIView *)Super{
    return  [[self alloc] initWithbutton:number andSuper:Super];
}

-(void)selectbutton:(UIButton *)select{
    if (_i==0) {
        _btn_old.selected=NO;
        _i+=1;
    }
    [self.mytabardelegate selecttindex:select];
}

@end
