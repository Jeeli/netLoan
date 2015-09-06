//
//  text-buttonH-buttonH.m
//  Sd
//
//  Created by IOS on 15/7/25.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "text-buttonH-buttonH.h"
#import "mybuttonH.h"
#import "addConstraints.h"
#import "myUILabel.h"
@interface text_buttonH_buttonH()
@property(nonatomic,weak) mybuttonH * btn_first;
@end
@implementation text_buttonH_buttonH
- (instancetype)initWithText:(NSString *)text andFirstBtText:(NSString *)firstText andFirstBtImage:(NSString *)firstImage andSecondBtText:(NSString *)secondText andSecondImage:(NSString *)secondImage{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        myUILabel * lb_name=[[myUILabel alloc] init];
        lb_name.text=text;
        lb_name.translatesAutoresizingMaskIntoConstraints=NO;
        
        mybuttonH * bt_first=[[mybuttonH alloc] init];
        _btn_first=bt_first;
        [bt_first setTitle:firstText forState:UIControlStateNormal];
        [bt_first setImage:[UIImage imageNamed:firstImage] forState:UIControlStateNormal];
        bt_first.translatesAutoresizingMaskIntoConstraints=NO;
        bt_first.imageView.contentMode=UIViewContentModeCenter;
        
        mybuttonH * bt_second=[[mybuttonH alloc] init];
        [bt_second setImage:[UIImage imageNamed:secondImage] forState:UIControlStateNormal];
        [bt_second setTitle:secondText forState:UIControlStateNormal];
        bt_second.translatesAutoresizingMaskIntoConstraints=NO;
        [bt_second setContentMode:UIViewContentModeCenter];
        [bt_second addTarget:self action:@selector(goMorePage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lb_name];
        [self addSubview:bt_first];
        [self addSubview:bt_second];
        
        NSDictionary * Dic_constraintsViews=@{@"lb_name":lb_name,@"bt_first":bt_first,@"bt_second":bt_second};
        NSDictionary * Dic_constraintsMertrics =@{@"topMargin":@0,@"leftMargin":@0,@"rightMargin":@0};
        NSArray * ary_constraints=@[
                                    @"H:|-0-[lb_name(==90)]-0-[bt_first(==100)]-[bt_second(==100)]",
                                    @"V:|-topMargin-[lb_name]-0-|"
                                    ];
        
        addConstraints * constraint=[[addConstraints alloc] init];
        [constraint addMetrics:Dic_constraintsMertrics andViews:Dic_constraintsViews andSuper:self andConstraints:ary_constraints];
    }
    return  self;
}
-(void)updateText:(NSString *)text{
    _btn_first.titleLabel.text=text;
    [_btn_first setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}
- (void) goMorePage:(mybuttonH *)sender{
    if (self.goMorePage==nil) {}else{
        self.goMorePage();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
