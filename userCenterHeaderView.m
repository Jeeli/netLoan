//
//  userCenterHeadView.m
//  Sd
//
//  Created by IOS on 15/7/20.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "userCenterHeaderView.h"
#import  "addConstraints.h"
#import "withdraw.h"
#import "UIImageView+WebCache.h"
#import "globalVariable.h"
@interface userCenterHeaderView()
@property(nonatomic,weak) UILabel * lb_userName;
@property(nonatomic,weak) UILabel * lb_availableNumber;
@property(nonatomic,weak) UILabel * lb_freezeNumber;
@property(nonatomic,weak) UILabel * lb_totalNumber;
@property(nonatomic,weak) UIImageView * img_display;
@end
@implementation userCenterHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithUserImage:(NSString *)imageName andUserName:(NSString *)userName andAvailable:(NSString *)available andFreeze:(NSString *)freeze andTotal:(NSString *)total{
    if (self=[super init]) {
        UIImageView * imgv_userImage=[[UIImageView alloc] init];
        imgv_userImage.image=[UIImage imageNamed:imageName];
        imgv_userImage.translatesAutoresizingMaskIntoConstraints=NO;
        imgv_userImage.contentMode=UIViewContentModeCenter;
        
        imgv_userImage.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
        [imgv_userImage addGestureRecognizer:tapGesture];
 
        
        //imgv_userImage.backgroundColor=[UIColor blueColor];
        [self addSubview:imgv_userImage];
        _img_display=imgv_userImage;
        UILabel * lb_userName=[[UILabel alloc] init];
        lb_userName.text=userName;
        _lb_userName=lb_userName;
        lb_userName.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:lb_userName];
        [lb_userName setTextColor:Color(189, 84, 79)];
        [lb_userName setTextAlignment:NSTextAlignmentCenter];
        
         lb_userName.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap2:)];
        [lb_userName addGestureRecognizer:tapGesture2];
        
        UIView * v_top=[[UIView alloc] init];
        v_top.backgroundColor=Color(228, 228, 228);
        v_top.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:v_top];
        
        UIView * v_margin_left=[[UIView alloc] init];
        v_margin_left.backgroundColor=Color(228, 228, 228);
        v_margin_left.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:v_margin_left];
        
        UIView * v_margin_right=[[UIView alloc] init];
        v_margin_right.backgroundColor=Color(228, 228, 228);
        v_margin_right.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:v_margin_right];
        
        UIView * v_bottom=[[UIView alloc] init];
        v_bottom.backgroundColor=Color(228, 228, 228);
        v_bottom.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:v_bottom];
        
        UILabel * lb_available=[[UILabel alloc] init];
        lb_available.text=@"可用余额";
        [lb_available setTextColor:Color(121, 120, 121)];
        lb_available.translatesAutoresizingMaskIntoConstraints=NO;
        [lb_available setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lb_available];
        
        NSString * st_availabelNumber=[NSString stringWithFormat:@"%@%@",@"¥",available];
        UILabel * lb_availableNumber=[[UILabel alloc] init];
        _lb_availableNumber=lb_availableNumber;
        lb_availableNumber.text=st_availabelNumber;
        [lb_availableNumber setTextColor:Color(121, 120, 121)];
        [lb_availableNumber setTextAlignment:NSTextAlignmentCenter];
        lb_availableNumber.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:lb_availableNumber];
        
        NSString * st_freezeNumber=[NSString stringWithFormat:@"%@%@",@"¥",freeze];
        UILabel * lb_freezeNumber=[[UILabel alloc] init];
        lb_freezeNumber.text=st_freezeNumber;
        _lb_freezeNumber=lb_freezeNumber;
        [lb_freezeNumber setTextColor:Color(121, 120, 121)];
        [lb_freezeNumber setTextAlignment:NSTextAlignmentCenter];
        lb_freezeNumber.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:lb_freezeNumber];

        NSString * st_totalNumber=[NSString stringWithFormat:@"%@%@",@"¥",total];
        UILabel * lb_totalNumber=[[UILabel alloc] init];
        lb_totalNumber.text=st_totalNumber;
        _lb_totalNumber=lb_totalNumber;
        [lb_totalNumber setTextColor:Color(121, 120, 121)];
        [lb_totalNumber setTextAlignment:NSTextAlignmentCenter];
        lb_totalNumber.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:lb_totalNumber];

        UILabel * lb_freeze=[[UILabel alloc] init];
        lb_freeze.text=@"冻结金额";
        [lb_freeze setTextColor:Color(121, 120, 121)];
        [self addSubview:lb_freeze];
        [lb_freeze setTextAlignment:NSTextAlignmentCenter];
        lb_freeze.translatesAutoresizingMaskIntoConstraints=NO;
        
        UILabel * lb_total=[[UILabel alloc] init];
        lb_total.text=@"资产总额";
        [lb_total setTextColor:Color(121, 120, 121)];
        [lb_total setTextAlignment:NSTextAlignmentCenter];
        lb_total.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:lb_total];
        
        UIButton * bt_withdraw=[[UIButton alloc] init];
        [bt_withdraw setTitle:@"提现" forState:UIControlStateNormal];
        bt_withdraw.translatesAutoresizingMaskIntoConstraints=NO;
        bt_withdraw.backgroundColor=Color(80, 121, 178);
        [self addSubview:bt_withdraw];
        [bt_withdraw addTarget:self action:@selector(goWithdraw) forControlEvents:UIControlEventTouchUpInside];
        
        /*[bt_topUp.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [bt_topUp.layer setBorderWidth:1.0];   //边框宽度
        CGColorSpaceRef colorSpace_topUp= CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref_topUp = CGColorCreate(colorSpace_topUp,(CGFloat[]){ 1, 0, 3, 1 });
        [bt_topUp.layer setBorderColor:colorref_topUp];//边框颜色*/

        
        UIButton * bt_invest=[[UIButton alloc] init];
        [bt_invest setTitle:@"投资" forState:UIControlStateNormal];
        bt_invest.translatesAutoresizingMaskIntoConstraints=NO;
        bt_invest.backgroundColor=Color(125, 181, 96);
        [self addSubview:bt_invest];
        [bt_invest addTarget:self action:@selector(goBid) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *metrcs=@{@"imgv_userImage_height":@90,@"lb_userName_height":@30,@"lb_userName_topMargin":[NSNumber numberWithInt:100],@"v_top_height":@1,@"v_top_topMargin":[NSNumber numberWithInt:110+30],@"lb_width":[NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/3],@"bt_width":@100,@"bt_MarginH":[NSNumber numberWithFloat:([UIScreen mainScreen].bounds.size.width-200)/3],@"v_margin_height":@70,@"v_margin_leftH":[NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/3],@"v_margin_rightH":[NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/3],@"left_margin":[NSNumber numberWithFloat:(screenWidth-90)/2]};
        NSDictionary *viewsDic=@{@"imgv_userImage":imgv_userImage,@"lb_userName":lb_userName,@"v_top":v_top,@"lb_available":lb_available,@"lb_freeze":lb_freeze,@"lb_total":lb_total,@"lb_availableNumber":lb_availableNumber,@"lb_freezeNumber":lb_freezeNumber,@"lb_totalNumber":lb_totalNumber,@"v_bottom":v_bottom,@"bt_invest":bt_invest,@"bt_topUp":bt_withdraw,@"v_margin_left":v_margin_left,@"v_margin_right":v_margin_right};
        NSArray *array=@[
                         @"H:|-left_margin-[imgv_userImage(==90)]-left_margin-|",
                         @"V:|-8-[imgv_userImage(==imgv_userImage_height)]",
                         @"H:|-0-[lb_userName]-0-|",
                         @"V:|-lb_userName_topMargin-[lb_userName(==lb_userName_height)]",
                         @"H:|-1-[v_top]-1-|",
                         @"V:|-v_top_topMargin-[v_top(==v_top_height)]",
                         @"V:|-141-[lb_available(==50)]",
                         @"V:|-141-[lb_freeze(==50)]",
                         @"V:|-141-[lb_total(==50)]",
                         @"H:|-0-[lb_available(==lb_width)]-0-[lb_freeze(==lb_width)]-0-[lb_total(==lb_width)]",
                         @"H:|-0-[lb_availableNumber(==lb_width)]-0-[lb_freezeNumber(==lb_width)]-0-[lb_totalNumber(==lb_width)]",
                         @"V:|-180-[lb_availableNumber(==20)]",
                         @"V:|-211-[v_bottom(==1)]",
                         @"H:|-1-[v_bottom]-1-|",
                         @"H:|-bt_MarginH-[bt_topUp(bt_width)]-bt_MarginH-[bt_invest(==bt_width)]",
                         @"V:|-230-[bt_invest]",
                         @"V:|-230-[bt_topUp]",
                         @"H:|-v_margin_leftH-[v_margin_left(==1)]-v_margin_rightH-[v_margin_right(==1)]",
                         @"V:|-141-[v_margin_left(==70)]",
                         @"V:|-141-[v_margin_right(==v_margin_height)]"
                         ];
        
        //添加约束
        addConstraints *addconstraints=[[addConstraints alloc] init];
        [addconstraints addMetrics:metrcs andViews:viewsDic andSuper:self andConstraints:array];
        __weak userCenterHeaderView *weakSelf = self;
        _block_userName=^(NSString * name){
            weakSelf.lb_userName.text=name;
        };
        _setDataBlock=^(NSDictionary * dic){
            if (g_userID==nil) {
                weakSelf.lb_userName.text=@"请登录";
                weakSelf.lb_freezeNumber.text=@"0元";
                weakSelf.lb_totalNumber.text=@"0元";
                weakSelf.lb_availableNumber.text=@"0元";
            }else{
                [weakSelf setImage:[NSString stringWithFormat:@"%@/data/avatar/%@",requestUrl,dic[@"pic"]]];
                if ([NSNull null] != [dic objectForKey:@"account"]) {
                    //[weakSelf setImage:[NSString stringWithFormat:@"%@/data/avatar/%@",requestUrl,dic[@"account"][@"userpic"]]];
                    //weakSelf.lb_freezeNumber.text=dic[@"account"][@"frozen"];
                    weakSelf.lb_freezeNumber.text=dic[@"account"][@"freeze"];
                    weakSelf.lb_totalNumber.text=dic[@"account"][@"total"];
                    //weakSelf.lb_availableNumber.text=dic[@"account"][@"available"];
                    weakSelf.lb_availableNumber.text=dic[@"account"][@"use_money"];
                }else{
                    weakSelf.lb_freezeNumber.text=@"0元";
                    weakSelf.lb_totalNumber.text=@"0元";
                    weakSelf.lb_availableNumber.text=@"0元";
                }
                 weakSelf.lb_userName.text=dic[@"user"][@"username"];
            }
        };

    }
      return  self;
}
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    _gobidBlock();
}
-(void)handleSingleTap2:(UITapGestureRecognizer *)sender{
    if ([_lb_userName.text isEqual:@"请登录"]) {
         _goLoginBlock();
    }
}


-(void) goWithdraw{
    [self.delegate goWithdraw];
}
-(void) setImage:(NSString *) url{
    //创建串行队里列
    dispatch_queue_t queue = dispatch_queue_create("firstQueue", nil);
    
    dispatch_sync(queue, ^(void) {
        [_img_display sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"user.jpg"]];
    });
    dispatch_sync(queue,^(void){
        //_img_display.backgroundColor=[UIColor redColor];
        _img_display.layer.cornerRadius =45;
        _img_display.layer.masksToBounds = YES;
    });
}
-(void) goBid{
    [self.delegate goBid];
}
@end
