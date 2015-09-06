//
//  withdraw.m
//  Sd
//
//  Created by IOS on 15/8/1.
//  Copyright (c) 2015年 IOS. All rights reserved.
//
/**
 *  提现
 */
#import "withdraw.h"
#import "network.h"
#import "globalVariable.h"
#import "addConstraints.h"
#import "Login.h"
@interface withdraw ()
@property(nonatomic,copy) networkRequestBlock networkWithdrawBlock;
@property(nonatomic,retain) NSDictionary * dic_data;
@property(nonatomic,retain) NSMutableArray * mary_obj;
@property(nonatomic,retain) NSArray * ary_obj_name;
@property(nonatomic,retain) NSArray * ary_networkName;
@property(nonatomic,strong) UIAlertView * altv_prompt;
@property(nonatomic,assign) int offset;
@property(nonatomic,assign) int keyboardheight;
@property(nonatomic,weak) UITextField * textField;
@end
@implementation withdraw
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    self.navigationItem.title=@"提现";
    if (_dic_data==nil) {
        _dic_data=[[NSDictionary alloc] init];
        _mary_obj=[[NSMutableArray alloc] init];
        _ary_obj_name=@[@"银行账户:",@"开户银行:",@"支行:",@"冻结金额:",@"真实姓名:",@"总金额:",@"可使用的金额:",@"提现金额:",@"提现密码:"];
        _ary_networkName=[[NSArray alloc] init];
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setSubviews];
    [self setDataforSubviews:nil];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goviewBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
}
-(void) pop{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void) performDismissToLogin:(NSTimer *)timer
{
    [_altv_prompt dismissWithClickedButtonIndex:0 animated:NO];
    Login * toLogin=[[Login alloc] init];
    [self.navigationController pushViewController:toLogin animated:NO];
}

- (void)goviewBack:(UIButton *)sender
{
    [self performSelector:@selector(pop) withObject:nil afterDelay:0.1];
}
- (void)viewWillAppear:(BOOL)animated{
    __weak withdraw * weakSelf=self;
    if (g_userID==nil) {
        _altv_prompt = [[UIAlertView alloc] initWithTitle:@"请登录!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(performDismissToLogin:) userInfo:nil repeats:NO];
        [self.altv_prompt show];
    }else{
        _networkWithdrawBlock=^(id Data){
            _dic_data=Data;
            [weakSelf setDataforSubviews:Data];
        };
        NSString * str_requset=[NSString stringWithFormat:@"user_id=%@&deviceId=%@&systemType=%@",g_userID,IDentifier,[NSNumber numberWithFloat:currentSystemVersion]];
        network * networkRequest=[[network alloc] init];
        [networkRequest postRequestByByUrlPath:[NSString stringWithFormat:@"%@/Mobileuser/Cash",requestUrl] andParams:str_requset andCallBack:_networkWithdrawBlock andRequestType:requestType_async];
        
    }
}
-(void) setSubviews{
    //把UI控件装入对象数组(按类型装入)
    for (int i=0; i<9; i++) {
        UILabel * lb_name=[[UILabel alloc] init];
        [_mary_obj addObject:lb_name];
        lb_name.translatesAutoresizingMaskIntoConstraints=NO;
        [self.view addSubview:lb_name];
        [lb_name setTextColor:Color(121, 120, 121)];
    }
    
      for (int i=0; i<2; i++) {
        UITextField * text_name=[[UITextField alloc] init];
        [_mary_obj addObject:text_name];
        text_name.translatesAutoresizingMaskIntoConstraints=NO;
        [self.view addSubview:text_name];
        text_name.borderStyle=UITextBorderStyleBezel;
         if (i==1) {
              text_name.secureTextEntry=YES;
          }
          text_name.returnKeyType=UIReturnKeyDone;
      }
    
    UIButton * btn_name=[[UIButton alloc] init];
    [_mary_obj addObject:btn_name];
    btn_name.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:btn_name];
    [btn_name setTitle:  @"提现" forState:UIControlStateNormal];
    [btn_name setBackgroundColor:bgColor];
    [btn_name addTarget:self action:@selector(goWithdraw:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_name.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [btn_name.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace= CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 2, 3, 1 });
    [btn_name.layer setBorderColor:colorref];//边框颜色

  

    NSMutableDictionary * dic_views=[[NSMutableDictionary alloc] init];
    NSString * str_obj;
    for (int i=0; i<_mary_obj.count; i++) {
        str_obj=[NSString stringWithFormat:@"obj_%d",i];
        [dic_views setObject:_mary_obj[i] forKey:str_obj];
    }
    
    addConstraints * constraints=[[addConstraints alloc] init];
    NSMutableArray * mary_constrains=[[NSMutableArray alloc] init];
    for (int i=0; i<_mary_obj.count; i++) {
        if ([_mary_obj[i] class]==[UILabel class]) {
            if (i==7 || i==8) {
                [mary_constrains addObject:[NSString stringWithFormat:@"H:|-3-[obj_%d]-3-|",i]];
                [mary_constrains addObject:[NSString stringWithFormat:@"V:|-%d-[obj_%d(==50)]",i*(10+20)+(i-7)*30,i]];
            }else{
                [mary_constrains addObject:[NSString stringWithFormat:@"H:|-3-[obj_%d]-3-|",i]];
                [mary_constrains addObject:[NSString stringWithFormat:@"V:|-%d-[obj_%d(==20)]",i*(10+20),i]];

            }
          }else if ([_mary_obj[i] class]==[UITextField class]) {
           
            [mary_constrains addObject:[NSString stringWithFormat:@"H:|-80-[obj_%d]-10-|",i]];
            [mary_constrains addObject:[NSString stringWithFormat:@"V:|-%d-[obj_%d(==40)]",7*30+(i-9)*(50+10),i]];
        }else{
            [mary_constrains addObject:[NSString stringWithFormat:@"H:|-20-[obj_%d]-20-|",i]];
            [mary_constrains addObject:[NSString stringWithFormat:@"V:|-%d-[obj_%d(==40)]",(i-2)*(10+20)+60,i]];
        }
    }
    [constraints addMetrics:nil andViews:dic_views andSuper:self.view andConstraints:mary_constrains];
    
}
-(void)goWithdraw:(UIButton *) sender{
    //__weak  withdraw * weakSelf=self;
    UITextField * number=_mary_obj[9];
    UITextField * password=_mary_obj[10];
    __weak withdraw * weakSelf=self;
    if (![number.text isEqual:@""] && ![password isEqual:@""]) {
        _networkWithdrawBlock=^(id Data){
            _altv_prompt = [[UIAlertView alloc] initWithTitle:Data[@"info"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5f target:weakSelf selector:@selector(performDismiss:) userInfo:nil repeats:NO];
            [weakSelf.altv_prompt show];

        };
        NSString * str_requset=[NSString stringWithFormat:@"user_id=%@&deviceId=%@&systemType=%@&money=%@&paypassword=%@",g_userID,IDentifier,[NSNumber numberWithFloat:currentSystemVersion],[_mary_obj[9] text],[_mary_obj[10] text]];
       
        network * networkRequest=[[network alloc] init];
        [networkRequest postRequestByByUrlPath:[NSString stringWithFormat:@"%@/Mobileuser/addCash",requestUrl] andParams:str_requset andCallBack:_networkWithdrawBlock andRequestType:requestType_async];

    }else{
        _altv_prompt = [[UIAlertView alloc] initWithTitle:@"提现金额或密码不能为空!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        [self.altv_prompt show];

    }
}
-(void) performDismiss:(NSTimer *)timer
{
   [_altv_prompt dismissWithClickedButtonIndex:0 animated:YES];
}

-(void) setDataforSubviews:(NSDictionary *) dic{
    if(dic.count>0){
        NSString * account=@"无";
        NSString * bankname=@"无";
        NSString * branch=@"无";
        NSString * no_use_money=@"无";
        NSString * total=@"无";
        NSString * use_money=@"无";
        if ([NSNull null]!=[dic objectForKey:@"account"]){
            account=dic[@"account"];
        }
        if ([NSNull null]!=[dic objectForKey:@"bankname"]){
            bankname=dic[@"bankname"];
        }

        if ([NSNull null]!=[dic objectForKey:@"branch"]){
            branch=dic[@"branch"];
        }

        if ([NSNull null]!=[dic objectForKey:@"no_use_money"]){
            no_use_money=dic[@"no_use_money"];
        }

        if ([NSNull null]!=[dic objectForKey:@"total"]){
            total=dic[@"total"];
        }
        if ([NSNull null]!=[dic objectForKey:@"use_money"]){
            use_money=dic[@"use_money"];
        }

    _ary_networkName=@[account,bankname,branch,no_use_money,dic[@"realname"],total,use_money];
        for (int i=0; i<7; i++) {
            [_mary_obj[i] setText:[NSString stringWithFormat:@"%@ %@",_ary_obj_name[i],_ary_networkName[i]]];
        }
         [_mary_obj[7] setText:[NSString stringWithFormat:@"%@",_ary_obj_name[7]]];
         [_mary_obj[8] setText:[NSString stringWithFormat:@"%@",_ary_obj_name[8]]];
    }else{
            for (int i=0; i<9; i++) {
                [_mary_obj[i] setText:[NSString stringWithFormat:@"%@",_ary_obj_name[i]]];
            }

        }
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //隐藏底部tabbar
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
@end
