//
//  topUp.m
//  Sd
//
//  Created by IOS on 15/7/25.
//  Copyright (c) 2015年 IOS. All rights reserved.
//
/**
 *  充值
 *
 */
#import "topUp.h"
#import  "text-buttonH-buttonH.h"
#import "addConstraints.h"
#import "myUILabel.h"
#import "mytextFiled.h"
#import "myUIButton.h"
#import "payTypeCollectionViewCell.h"
#import "mybuttonH.h"
#import "globalVariable.h"
@interface topUp()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak) text_buttonH_buttonH * ttb_topUpType;
@property(nonatomic,weak) UIView * v_super;
@property(nonatomic,weak) UIButton * btn_pleaseLogin;
@end
@implementation topUp

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return  self;
}

-(void)viewWillAppear:(BOOL)animated{
    if (g_userID==nil) {
        _v_super.hidden=YES;
        _btn_pleaseLogin.hidden=NO;
    }else{
        _btn_pleaseLogin.hidden=YES;
        _v_super.hidden=NO;
    }
}
- (void)viewDidLoad{
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.title=@"充值";
    self.view.backgroundColor=[UIColor whiteColor];
    text_buttonH_buttonH * tbb_topUpWay=[[text_buttonH_buttonH alloc] initWithText:@" 充值方式:" andFirstBtText:@"网上充值" andFirstBtImage:@"1.png" andSecondBtText:@"线下充值" andSecondImage:@"1.png"];
    myUILabel * lb_prompt=[[myUILabel alloc] init];
    [lb_prompt addAry_name:@"lb_prompt"];
    lb_prompt.backgroundColor=[UIColor greenColor];
    
    mytextFiled * txt_topUpNumber=[[mytextFiled alloc] initWithImage:nil andText:@" 充值金额:" andIsSecureText:NO andPlaceholder:@"充值金额" andWidth:90 andImageWidth:30 andDisplayBorder:YES];
    txt_topUpNumber.translatesAutoresizingMaskIntoConstraints=NO;
    
    text_buttonH_buttonH *ttb_topUpType=[[text_buttonH_buttonH alloc] initWithText:@" 充值类型:" andFirstBtText:@"宝付" andFirstBtImage:@"1.png" andSecondBtText:@"更多" andSecondImage:@"2.png"];
    _ttb_topUpType=ttb_topUpType;
    
    //验证码
    mytextFiled *txt_verifyCode=[[mytextFiled alloc] initWithImage:nil andText:@" 验证码:" andIsSecureText:NO andPlaceholder:@"验证码" andWidth:90  andImageWidth:145 andDisplayBorder:YES];
    txt_verifyCode.translatesAutoresizingMaskIntoConstraints=NO;
    [lb_prompt setText:@"温馨提示:严禁使用信用卡非法套现"];
    [lb_prompt setTextAlignment:NSTextAlignmentCenter];
    
    
    myUIButton * bt_affirm=[[myUIButton alloc] init];
    bt_affirm.translatesAutoresizingMaskIntoConstraints=NO;
    [bt_affirm setTitle:@"确认充值" forState:UIControlStateNormal];
    [bt_affirm setBackgroundColor:[UIColor blueColor]];
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    UICollectionView * clcv_morePage=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, 30, 30) collectionViewLayout:flowLayout];
    clcv_morePage.translatesAutoresizingMaskIntoConstraints=NO;
    clcv_morePage.backgroundColor=Color(205, 205,205);
    clcv_morePage.hidden=YES;
    ttb_topUpType.goMorePage=^(){
        clcv_morePage.hidden=!clcv_morePage.hidden;
    };
    [clcv_morePage registerClass:[payTypeCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    clcv_morePage.dataSource=self;
    clcv_morePage.delegate=self;
    clcv_morePage.showsVerticalScrollIndicator=NO;
    
    UIButton * btn_pleaseLogin=[[UIButton alloc] init];
    [btn_pleaseLogin setTitle:@"请登录" forState:UIControlStateNormal];
    [btn_pleaseLogin setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn_pleaseLogin.backgroundColor=[UIColor blueColor];
    [self.view addSubview:btn_pleaseLogin];
    _btn_pleaseLogin=btn_pleaseLogin;
    btn_pleaseLogin.frame=CGRectMake(0, 0, self.view.frame.size.width, 40);

    
    UIView * v_super=[[UIView alloc] init];
    [self.view addSubview:v_super];
    v_super.frame=self.view.bounds;
    _v_super=v_super;
    [v_super addSubview:lb_prompt];
    [v_super addSubview:tbb_topUpWay];
    [v_super addSubview:txt_topUpNumber];
    [v_super addSubview:ttb_topUpType];
    [v_super addSubview:txt_verifyCode];
    [v_super addSubview:bt_affirm];
    [v_super addSubview:clcv_morePage];
    
    tbb_topUpWay.translatesAutoresizingMaskIntoConstraints=NO;
    lb_prompt.translatesAutoresizingMaskIntoConstraints=NO;
    ttb_topUpType.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSDictionary * dic_constraintsMetrics=@{@"tbb_topUpType_topMargin":@0,@"tbb_topUpType_leftMargin":@0,@"tbb_topUpType_rightMargin":@0};
    NSDictionary *dic_constraintsViews=@{@"tbb_topUpType":tbb_topUpWay,@"lb_prompt":lb_prompt,@"txt_topUpNumber":txt_topUpNumber,@"ttb_topUpType":ttb_topUpType,@"txt_verifyCode":txt_verifyCode,@"bt_affirm":bt_affirm,@"scv_morePage":clcv_morePage};
    
    NSArray * ary_constraints=@[
                                @"H:|-0-[lb_prompt]-0-|",
                                @"V:|-0-[lb_prompt(==30)]",
                                @"H:|-tbb_topUpType_leftMargin-[tbb_topUpType]-tbb_topUpType_rightMargin-|",
                                @"V:|-40-[tbb_topUpType(==30)]",
                                @"H:|-0-[txt_topUpNumber]-0-|",
                                @"V:|-80-[txt_topUpNumber]",
                                @"H:|-0-[ttb_topUpType]-0-|",
                                @"V:|-120-[ttb_topUpType(==30)]",
                                @"H:|-0-[txt_verifyCode]-8-|",
                                @"V:|-160-[txt_verifyCode(==30)]",
                                @"H:|-50-[bt_affirm]-50-|",
                                @"V:|-210-[bt_affirm(==45)]",
                                @"H:|-5-[scv_morePage]-5-|",
                                @"V:|-152-[scv_morePage]-5-|"
                                ];
    
    addConstraints * constraint=[[addConstraints alloc] init];
    [constraint addMetrics:dic_constraintsMetrics andViews:dic_constraintsViews andSuper:v_super andConstraints:ary_constraints];
}
- (void)goBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 21;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150,50);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    payTypeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   mybuttonH * btn=[collectionView cellForItemAtIndexPath:indexPath].contentView.subviews[0];
   [_ttb_topUpType updateText:btn.titleLabel.text];
    return YES;
}
@end
