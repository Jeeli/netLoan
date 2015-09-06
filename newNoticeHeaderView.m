//
//  newNoticeHeaderView.m
//  Sd
//
//  Created by IOS on 15/8/6.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "newNoticeHeaderView.h"
#import "addConstraints.h"
#import "noticeModel.h"
@interface newNoticeHeaderView()
@property(nonatomic,weak) UILabel * lb_name;
@property(nonatomic,weak) UIButton * btn;
@property(nonatomic,weak) UIImageView * img;
@end
@implementation newNoticeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel * lb_name=[[UILabel alloc] init];
        lb_name.translatesAutoresizingMaskIntoConstraints=NO;
        UIImageView * img=[[UIImageView alloc] init];
        img.image=[UIImage imageNamed:@"down1.jpg"];
        self.lb_name=lb_name;
        [self.contentView addSubview:lb_name];
        [self.contentView addSubview:img];
        UIButton * btn=[[UIButton alloc] init];
        btn.translatesAutoresizingMaskIntoConstraints=NO;
        btn.backgroundColor=[UIColor clearColor];
        _btn=btn;
        [self.contentView addSubview:btn];
        [btn addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchDown];
        UIView * v=[[UIView alloc] init];
        v.translatesAutoresizingMaskIntoConstraints=NO;
        v.backgroundColor=Color(136, 155, 171);
        [self.contentView addSubview:v];
        
        img.translatesAutoresizingMaskIntoConstraints=NO;
        NSDictionary * dic_views=@{@"lb_name":lb_name,@"img":img,@"btn":btn,@"v":v};
        NSArray * ary_constraints=@[
                                    @"H:|-5-[lb_name(==200)]",
                                    @"V:|-0-[lb_name]-0-|",
                                    @"H:[img(==40)]-0-|",
                                    @"V:|-0-[img]-0-|",
                                    @"H:|-0-[btn]-0-|",
                                    @"V:|-0-[btn]-0-|",
                                    @"H:|-0-[v]-0-|",
                                    @"V:[v(==0.5)]-0-|"
                                    ];
        addConstraints * constraints=[[addConstraints alloc] init];
        [constraints addMetrics:nil andViews:dic_views andSuper:self.contentView andConstraints:ary_constraints];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        btn.backgroundColor=[UIColor clearColor];
        _img=img;
    }
    return self;
}
-(void)btn_click:(UIButton *) sender{
    [self.delegate changeCellState:sender.tag];
}
- (void) setName:(NSString * ) name{
    self.lb_name.text=name;
}
- (void)setTag:(NSInteger)tag{
    _btn.tag=tag;
}
-(void)setDownImg{
    _img.image=[UIImage imageNamed:@"down1"];
}
- (void)setUpImg{
     _img.image=[UIImage imageNamed:@"up1"];
}
@end
