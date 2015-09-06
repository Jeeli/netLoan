//
//  Login.m
//  Sd
//
//  Created by IOS on 15/7/14.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "Login.h"
#import "addConstraints.h"
#import "mytextFiled.h"
#import "mybuttonH.h"
#import "home.h"
#import "registers.h"
#import "myUIButton.h"
#import "myUITableView.h"
#import "network.h"
#import "globalVariable.h"
#import "usercenter.h"
#import "vipcenter.h"
#import "userInfoManage.h"
@interface Login()<selectMoreDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UILabel * lb_CreateVerifyCode;
@property(nonatomic,weak) UITableView *tbv_list;
@property(nonatomic,weak) mytextFiled * txt_name;
@property(nonatomic,weak) mytextFiled * txt_password;
@property(nonatomic,copy) networkRequestBlock loginInfoBlock;
@property(nonatomic,strong) UIAlertView * altv_prompt;
@property(nonatomic,weak) UIButton * btn_select;
@property(nonatomic,retain) NSMutableArray * dic_userNameInfo;
@property(nonatomic,retain) NSMutableArray * dic_passwordState;
@end
@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"登录";
    // Do any additional setup after loading the view.
    if (_dic_userNameInfo==nil) {
        _dic_userNameInfo=[[NSMutableArray alloc] init];
        _dic_userNameInfo=[userInfoManage LoadUserName];
        _dic_passwordState=[userInfoManage userPasswordState];
    }
    [self setupSubview];
    self.tbv_list.hidden=YES;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goviewBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];

    
}
-(void) pop{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)goviewBack:(UIButton *)sender
{
    [self performSelector:@selector(pop) withObject:nil afterDelay:0.1];
    
    //[self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

-(void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //隐藏底部tabbar
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)setButtonStyle:(UIButton *) bt{
    [bt.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [bt.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace= CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 2, 3, 1 });
    [bt.layer setBorderColor:colorref];//边框颜色
    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);
}
-(void) setupSubview{
    
    UILabel * lb_CreateVerifyCode=[[UILabel alloc] init];
    self.lb_CreateVerifyCode=lb_CreateVerifyCode;
    myUIButton * bt_Login=[[myUIButton alloc] init];
    [bt_Login setTitle:@"登录" forState:UIControlStateNormal];
    bt_Login.backgroundColor=bgColor;
    [bt_Login addAry_name:@"bt_login"];
    myUIButton * bt_Register=[[myUIButton alloc] init];
    [bt_Register addAry_name:@"bt_Register"];
    bt_Login.translatesAutoresizingMaskIntoConstraints=NO;
    [self setButtonStyle:bt_Login];
    
    [bt_Login addTarget:self action:@selector(gotoHome:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView * bg_image=[[UIImageView alloc] init];
    bg_image.image=[UIImage imageNamed:@"background"];
    //[self.view addSubview:bg_image];
    bg_image.frame=self.view.bounds;
    
    
    mybuttonH * bt_select=[[mybuttonH alloc] init];
    [bt_select addAry_name:@"bt_select"];
    mybuttonH * bt_forgetPassword=[[mybuttonH alloc] init];
    [bt_forgetPassword addAry_name:@"bt_forgetPassword"];
    

    [bt_select setImage:[UIImage imageNamed:@"noSelect"] forState:UIControlStateNormal];
    [bt_select setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    [bt_select setTitle:@"记住密码" forState:UIControlStateNormal];
    _btn_select=bt_select;
    bt_select.translatesAutoresizingMaskIntoConstraints=NO;
    bt_forgetPassword.translatesAutoresizingMaskIntoConstraints=NO;
    
    [bt_forgetPassword setTitle:@"立即注册" forState:UIControlStateNormal];
    [bt_forgetPassword addTarget:self action:@selector(goRegister:) forControlEvents:UIControlEventTouchUpInside];

    
    [bt_select addTarget:self action:@selector(bt_select_click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * v_super=[[UIView alloc] init];
    v_super.backgroundColor=[UIColor whiteColor];
    v_super.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:v_super];
    [v_super addSubview:bt_Login];
    [v_super addSubview:bt_select];
    [v_super addSubview:bt_forgetPassword];
    
    
    myUITableView *tbv_list=[[myUITableView alloc] init];
    self.tbv_list=tbv_list;
    [tbv_list addAry_name:@"tbv_list"];
    tbv_list.delegate=self;
    tbv_list.dataSource=self;
    tbv_list.translatesAutoresizingMaskIntoConstraints=NO;
    tbv_list.bounces=NO;
    tbv_list.layer.cornerRadius=5.0f;
 
    mytextFiled * mytxt_name=[[mytextFiled alloc] initWithImage:@"down1.png" andText:@"账号 " andIsSecureText:NO andPlaceholder:@"请输入用户名" andWidth:50 andImageWidth:30 andDisplayBorder:NO];
    mytxt_name.selectdelegate=self;
    _txt_name=mytxt_name;
    [mytxt_name setcolor];
    mytxt_name.translatesAutoresizingMaskIntoConstraints=NO;
    [v_super addSubview:mytxt_name];
    [v_super addSubview:bt_Register];
    [mytxt_name addAry_name:@"mytxt_name"];
    
    self.setdelegate=(id)mytxt_name;
    mytextFiled * mytxt_password=[[mytextFiled alloc] initWithImage:nil andText:@"密码 " andIsSecureText:YES andPlaceholder:@"请输入密码" andWidth:50  andImageWidth:30 andDisplayBorder:NO];
    [mytxt_password setcolor];
    mytxt_password.translatesAutoresizingMaskIntoConstraints=NO;
    _txt_password=mytxt_password;
    [mytxt_password addAry_name:@"mytxt_password"];
    [v_super addSubview:mytxt_password];
    tbv_list.translatesAutoresizingMaskIntoConstraints=NO;
    tbv_list.backgroundColor=bgColor;
    [v_super addSubview:tbv_list];
    UIView * v=[[UIView alloc] init];
    [v_super addSubview:v];
    v.backgroundColor=[UIColor grayColor];
    v.translatesAutoresizingMaskIntoConstraints=NO;
    
    v_super.backgroundColor=[UIColor clearColor];
    //v_super.backgroundColor=[UIColor greenColor];
    double mytxt_name_height=35;
    double v_super_height=250;
       
    NSDictionary *metrcs=@{@"mytxt_name_height":[NSNumber numberWithDouble:mytxt_name_height],@"v_super_height":[NSNumber numberWithDouble:v_super_height],@"top_margin":@30,@"margin_mytxt_password":[NSNumber numberWithInt:20+mytxt_name_height],@"margin_register":[NSNumber numberWithInt:20+mytxt_name_height+10+mytxt_name_height],@"bt_select_width":@100,@"marginH_select":[NSNumber numberWithInt:(self.view.frame.size.width-20-80*2-100-30-3)/2],@"marginV_select":[NSNumber numberWithInt:20+mytxt_name_height+10+mytxt_name_height],@"marginH_login":[NSNumber numberWithInt:80+10+3+80+3+2],@"marginV_forgetPassword":[NSNumber numberWithInt:20+mytxt_name_height+10+mytxt_name_height+10+30],@"tbv_list_width":[NSNumber numberWithFloat:self.view.frame.size.width-69-3*2-20],@"margin_V":[NSNumber numberWithFloat:10+mytxt_name_height],@"tbv_list_height":[NSNumber numberWithInt:(int)_dic_userNameInfo.count*49]
                           ,@"tbv_list_height2":@147};
    NSDictionary *viewsDic=@{@"mytxt_name":mytxt_name,@"v_super":v_super,@"mytxt_password":mytxt_password,@"bt_register":bt_Register,@"bt_select":bt_select,@"bt_login":bt_Login,@"bt_forgetPassword":bt_forgetPassword,@"tbv_list":tbv_list,@"v":v};
    NSArray *array=@[
                     @"H:|-10-[v_super]-10-|",
                     @"V:|-top_margin-[v_super(==v_super_height)]",
                     @"H:|-3-[mytxt_name]-3-|",
                     @"V:|-10-[mytxt_name(==mytxt_name_height)]",
                     @"H:|-3-[mytxt_password]-3-|",
                     @"V:|-margin_mytxt_password-[mytxt_password(==mytxt_name_height)]",
                     @"H:|-30-[bt_login]-30-|",
                     @"V:|-margin_register-[bt_login(==40)]",
                     @"H:|-30-[bt_select(==90)]-[bt_forgetPassword]-30-|",
                     @"V:|-150-[bt_forgetPassword(==30)]",
                     @"H:|-52-[tbv_list(==tbv_list_width)]",
                     @"H:|-0-[v]-0-|",
                     @"V:|-0-[v(==1)]"
                   ];
    //添加约束
   addConstraints *addconstraints=[[addConstraints alloc] init];
   [addconstraints addMetrics:metrcs andViews:viewsDic andSuper:self.view andConstraints:array];
    if (_dic_userNameInfo.count>0) {
        NSArray *array2=@[
                          @"V:|-margin_V-[tbv_list(==tbv_list_height)]"
                          ];
        addConstraints *addconstraints1=[[addConstraints alloc] init];
        [addconstraints1 addMetrics:metrcs andViews:viewsDic andSuper:v_super andConstraints:array2];

    }else if (_dic_userNameInfo.count>3) {
        NSArray *array1=@[
                           @"V:|-margin_V-[tbv_list(==tbv_list_height2)]"
                          ];
        addConstraints *addconstraints1=[[addConstraints alloc] init];
        [addconstraints1 addMetrics:metrcs andViews:viewsDic andSuper:v_super andConstraints:array1];
    }else {
        NSArray *array3=@[
                          @"V:|-margin_V-[tbv_list(==2)]"
                          ];
        addConstraints *addconstraints1=[[addConstraints alloc] init];
        [addconstraints1 addMetrics:metrcs andViews:viewsDic andSuper:v_super andConstraints:array3];

    }
    [bt_forgetPassword setTitleColor:Color(98, 140, 243) forState:UIControlStateNormal];
    [bt_select setTitleColor:bgColor forState:UIControlStateNormal];

}
- (void)goRegister:(UIButton *)sender{
    //[self presentViewController:[[registers alloc] init] animated:YES completion:nil];
    [self.navigationController pushViewController:[[registers alloc] init] animated:YES];
}
-(void)forgetPassword{
    vipcenter * v=[[vipcenter alloc] init];
    v.url=[NSString stringWithFormat:@"%@/Public/get_password",requestUrl];
    [self.navigationController pushViewController:v animated:NO];
}

-(void) gotoHome:(UIButton *)sender{
    //应用唯一标示
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    CGFloat systemVersion=[[UIDevice currentDevice].systemVersion doubleValue];
    if (_txt_name.textFiledInfo().length==0 || _txt_password.textFiledInfo().length==0) {
        _altv_prompt = [[UIAlertView alloc] initWithTitle:@"提示:" message:[NSString stringWithFormat:@"登录失败!%@",@"账号或密码不能为空!"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        [_altv_prompt show];
    }else{
        network * net_request=[[network alloc] init];
         __weak typeof(self) weakSelf = self;
        _altv_prompt = [[UIAlertView alloc] initWithTitle:@"正在登录..." message:nil delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [weakSelf.altv_prompt show];

         _loginInfoBlock=^(id Data){
            if (![Data[@"status"] isEqual:@1]) {
                [weakSelf.altv_prompt setTitle:[NSString stringWithFormat:@"登录失败!%@",Data[@"info"]]];
                [NSTimer scheduledTimerWithTimeInterval:1.5f target:weakSelf selector:@selector(performDismiss:) userInfo:nil repeats:NO];
            }else{
                [NSTimer scheduledTimerWithTimeInterval:1.5f target:weakSelf selector:@selector(performDismissToUserCenter:) userInfo:nil repeats:NO];
                //登录成功 更新信息
                g_userID=Data[@"user_id"];
                myLog(@"login.g_userID=%@",g_userID);
                
                //保存用户信息
                myLog(@"usname=%@ password=%@",weakSelf.txt_name.textFiledInfo(),weakSelf.txt_password.textFiledInfo());
                [userInfoManage saveUserName:weakSelf.txt_name.textFiledInfo() psaaword: weakSelf.txt_password.textFiledInfo() andstate:weakSelf.btn_select.selected==YES?@"Y":@"N"];
            }
        };
        
         NSString *str=[NSString stringWithFormat:@"username=%@&password=%@&deviceId=%@&systemType=%@",_txt_name.textFiledInfo(),_txt_password.textFiledInfo(),identifierForVendor,[NSNumber numberWithFloat:systemVersion]];
        [net_request postRequestByByUrlPath:[NSString stringWithFormat:@"%@/Mobile/login",requestUrl]  andParams:str  andCallBack:_loginInfoBlock andRequestType:requestType_async];
       
        //[net_request getRequestByUrlPath:@"http://www.bzbzz.wang/Mobile/login" andParams:str andCallBack:_loginInfoBlock];
    }
}
-(void) performDismiss:(NSTimer *)timer
{
    [_altv_prompt dismissWithClickedButtonIndex:0 animated:NO];
}
-(void) performDismissToUserCenter:(NSTimer *)timer
{
    [_altv_prompt dismissWithClickedButtonIndex:0 animated:NO];
    usercenter * userCenter=[[usercenter alloc] init];
    [self.navigationController pushViewController:userCenter animated:NO];
}

-(void)bt_select_click:(UIButton *)sender{
    sender.selected=!sender.selected;
    
}
- (void)selectMore{
    self.tbv_list.hidden=!self.tbv_list.hidden;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dic_userNameInfo.count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text=_dic_userNameInfo[indexPath.row];
    cell.backgroundColor=[UIColor clearColor];
    cell.imageView.image=[UIImage imageNamed:@""];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_txt_name setImage:@"down1"];
    [_txt_name setimageState:@"down"];
    self.tbv_list.hidden=YES;
   [self.setdelegate setContent:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    _btn_select.selected=[_dic_passwordState[indexPath.row] isEqual:@"Y"];
    if ([_dic_passwordState[indexPath.row] isEqual:@"Y"]) {
        [_txt_password setContent:[userInfoManage findPasswordByUserName:[tableView cellForRowAtIndexPath:indexPath].textLabel.text]];
    }else{
        [_txt_password setContent:@""];
    }
}


@end
