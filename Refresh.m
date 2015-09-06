//
//  upRefresh.m
//  Sd
//
//  Created by IOS on 15/8/10.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "Refresh.h"
#import "addConstraints.h"
@implementation Refresh

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype) init{
    if(self=[super init]){
        UIActivityIndicatorView * act=[[UIActivityIndicatorView alloc] init];
        [self addSubview:act];
        //act.translatesAutoresizingMaskIntoConstraints=NO;
        UILabel * lb_name=[[UILabel alloc] init];
        UIImageView * img=[[UIImageView alloc] init];
        img.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:img];
        
        lb_name.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:lb_name];
        UILabel * lb_time=[[UILabel alloc] init];
        CGFloat width=[[UIScreen mainScreen] bounds].size.width/2;
        NSDictionary * dic_metrics=@{@"left":[NSNumber numberWithFloat:width-40]};
        //act.center=CGPointMake(width,50);
        [lb_time setTextAlignment:NSTextAlignmentCenter];
        lb_time.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:lb_time];
        NSArray * ary_constraints=@[
                                    @"H:|-left-[img]-0-[lb_name(==100)]",
                                    @"V:|-50-[lb_name(==20)]",
                                    @"H:|-0-[lb_time]-0-|",
                                    @"V:|-70-[lb_time(==20)]"
                                    ];
        
        NSDictionary * dic_views=@{@"act":act,@"lb_name":lb_name,@"lb_time":lb_time,@"img":img};
        addConstraints * addconstraints=[[addConstraints alloc] init];
        [addconstraints addMetrics:dic_metrics andViews:dic_views andSuper:self andConstraints:ary_constraints];
        _loadingBlock=^(){
            lb_name.text=@"正在加载...";
            [act startAnimating];
            img.hidden=YES;
        };
        _finshBlock=^(NSString * name,NSString * imgName){
            lb_name.text=name;
            [act stopAnimating];
            img.hidden=NO;
            img.image=[UIImage imageNamed:imgName];
        };
        _beforeLoadingBlock=^(NSString * time,NSString * imgName){
            lb_name.text=@"松手刷新";
            lb_time.text=[NSString stringWithFormat:@"上次刷新:%@",time];
            img.image=[UIImage imageNamed:imgName];
        };
        _initBlock=^(NSString * name,NSString * imgName,NSString * time){
            lb_name.text=name;
            img.image=[UIImage imageNamed:imgName];
            lb_time.text=time;
        };
        self.backgroundColor=[UIColor clearColor];
        
    }
    return self;
}


@end
