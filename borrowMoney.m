//
//  borrowMoneyViewController.m
//  Sd
//
//  Created by IOS on 15/7/28.
//  Copyright (c) 2015年 IOS. All rights reserved.
//
/**
 *  借款详情
 *
 */
#import "borrowMoney.h"
#import "borrowMoney.h"
#import "text-text-text-text.h"
#import "progressBar.h"
#import "addConstraints.h"
#import "network.h"
#import "globalVariable.h"
#import "img-text-img.h"
@interface borrowMoney ()<UITextFieldDelegate>
@property(nonatomic,retain) NSMutableArray * ary_obj;
@property(nonatomic,retain) NSMutableArray * ary_objPartition;
@property(nonatomic,weak) UILabel *lb_displayTime;
@property(nonatomic,copy) networkRequestBlock borrowMoneyBlock;
@property(nonatomic,retain) NSDictionary * dic_Data;
@property(nonatomic,weak) progressBar* pgb_progress;
@property(nonatomic,weak) UIView * v;
@property(nonatomic,retain) NSMutableDictionary * dic_views;
@property(nonatomic,weak)  UITextView * txtv_content ;
@property(nonatomic,weak) UIButton * btn_bid;
@property(nonatomic,weak) UIButton * btn_money;
@property(nonatomic,strong)UIAlertView * altv_prompt;
@property(nonatomic,assign) int TOTAL_TIMES;
@property(nonatomic,strong) NSTimer * timer;
@end

@implementation borrowMoney

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    if (_dic_Data==nil) {
        _dic_Data=[[NSDictionary alloc] init];
    }
    _TOTAL_TIMES=0;
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"借款详情";
    [self setSubview];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goviewBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    
    //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(getCurrentTime) userInfo:nil repeats:YES];
    
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    //[timer setFireDate:[NSDate distantPast]];//开启
    //[timer setFireDate:[NSDate distantFuture]];//暂停
    
}
- (void)viewWillDisappear:(BOOL)animated{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer=nil;
    }
}
-(void) setData{
    _pgb_progress.percent=[_dic_Data[@"b_info"][@"scale"] floatValue]/100;
    [_ary_obj[0] setDataWithStr1:_dic_Data[@"b_info"][@"account"] andStr2:_dic_Data[@"b_info"][@"lowest_account"]];
    [_ary_obj[1] setDataWithStr1:[NSString stringWithFormat:@"%@%%",_dic_Data[@"b_info"][@"apr"]] andStr2:@"在线交易"];
    [_ary_obj[2] setDataWithStr1:_dic_Data[@"b_info"][@"time_limit"] andStr2:_dic_Data[@"b_info"][@"award"]];
    [_ary_obj[3] setDataWithStr1:_dic_Data[@"b_info"][@"style"] andStr2:_dic_Data[@"b_info"][@"verify_time"]];
    if ([_dic_Data[@"b_info"][@"surplus"]  isKindOfClass:[NSNumber class]]){
        _lb_displayTime.text=[NSString stringWithFormat:@"%@",_dic_Data[@"b_info"][@"surplus"]];
        _TOTAL_TIMES=[_dic_Data[@"b_info"][@"surplus"] intValue];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        _timer=timer;
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [timer setFireDate:[NSDate distantPast]];//开启*/
    }else{
        _lb_displayTime.text=_dic_Data[@"b_info"][@"surplus"];
    }
}
-(void) updateTime{
    if (_TOTAL_TIMES-1>0) {
        _TOTAL_TIMES--;
        int day=_TOTAL_TIMES/60/60/24;
        int hour=_TOTAL_TIMES/60/60%24;
        int Minutes=_TOTAL_TIMES/60%60;
        int second =_TOTAL_TIMES%60;
        if (Minutes==0) {}else{
            if (second==0) {
                Minutes-=1;
            }
        }
        _lb_displayTime.text=[NSString stringWithFormat:@"%d天%d时%d分%d秒",day,hour,Minutes,second];
    }else{
        _lb_displayTime.text=@"已经完成";
    }
}
-(void)viewWillAppear:(BOOL)animated{
    
    __weak borrowMoney * weakSeaf=self;
    _borrowMoneyBlock=^(id Data){
        _dic_Data=Data;
        [weakSeaf setData];
    };
    
    NSString * str_request=[NSString stringWithFormat:@"id=%@",_idBlock()];
    network * net_request=[[network alloc] init];
    [net_request postRequestByByUrlPath:[NSString stringWithFormat:@"%@/Mobile/investInfo",requestUrl]  andParams:str_request andCallBack:_borrowMoneyBlock andRequestType:requestType_async];
    

}
-(void) setSubview{
    _ary_obj=[[NSMutableArray alloc] init];
    _ary_objPartition=[[NSMutableArray alloc] init];
    NSArray * ary_lbtext=@[@[@"借款金额:",@"23",@"投标限额:",@"fsd"],@[@"年利率:",@"23",@"交易类型:",@"fsd"],@[@"借款期限:",@"23",@"投标奖励:",@"fsd"],@[@"还款方式:",@"23",@"审核时间:",@"fsd"]];
    UILabel * lb_title=[[UILabel alloc] init];
    lb_title.text=_nameBlock();
    [lb_title setTextAlignment:NSTextAlignmentCenter];
    lb_title.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:lb_title];
    for (int i=0; i<4; i++) {
        if (i%2==0) {
            text_text_text_text * text=[[text_text_text_text alloc] initWithAry_name:ary_lbtext[i] andFlag:@"1"];
            text.translatesAutoresizingMaskIntoConstraints=NO;
            [_ary_obj addObject:text];
            [self.view addSubview:text];
        }else{
            text_text_text_text * text=[[text_text_text_text alloc] initWithAry_name:ary_lbtext[i] andFlag:@"2"];
            text.translatesAutoresizingMaskIntoConstraints=NO;
            [_ary_obj addObject:text];
            [self.view addSubview:text];

        }
    }
    UIImageView * img_time=[[UIImageView alloc] init];
    img_time.image=[UIImage imageNamed:@"time.png"];
    [self.view addSubview:img_time];
    img_time.translatesAutoresizingMaskIntoConstraints=NO;
    img_time.contentMode=UIViewContentModeCenter;
    
    UILabel *lb_time=[[UILabel alloc] init];
    lb_time.text=@"距离还款时间:";
    [lb_time setFont:[UIFont systemFontOfSize:15]];
    lb_time.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:lb_time];
    
    UILabel * lb_displayTime=[[UILabel alloc] init];
    lb_displayTime.text=@"";
    _lb_displayTime=lb_displayTime;
    [lb_displayTime setTextColor:Color(189, 84, 79)];
    lb_displayTime.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:lb_displayTime];
    
    UILabel * lb_filishProgress=[[UILabel alloc] init];
    lb_filishProgress.text=@"已经完成";
    lb_filishProgress.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:lb_filishProgress];
    [lb_filishProgress setTextColor:Color(189, 84, 79)];
    
    progressBar * pgb_display=[[progressBar alloc] init];
    _pgb_progress=pgb_display;
    pgb_display.percent=0.8;
    pgb_display.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:pgb_display];
    
    UIButton * btn_bid=[[UIButton alloc] init];
    btn_bid.translatesAutoresizingMaskIntoConstraints=NO;
    [btn_bid setTitle:@"我要投标" forState:UIControlStateNormal];
    btn_bid.backgroundColor=bgColor;
    [btn_bid.layer setCornerRadius:3.0];
    UITextView * txtv_content=[[UITextView alloc] init];
    txtv_content.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view  addSubview:txtv_content];
    [txtv_content setFont:[UIFont systemFontOfSize:15]];
    _txtv_content=txtv_content;
    
    txtv_content.text=@"";
    [txtv_content setScrollEnabled:YES];
    txtv_content.userInteractionEnabled = YES;
    txtv_content.showsVerticalScrollIndicator = YES;
    txtv_content.editable=NO;

    
    NSMutableDictionary *dic_views=[[NSMutableDictionary alloc] init];
    for (int i=0; i<4; i++) {
        UIView * v_Partition=[[UIView alloc] init];
        v_Partition.translatesAutoresizingMaskIntoConstraints=NO;
        [self.view addSubview:v_Partition];
        [_ary_objPartition addObject:v_Partition];
        [dic_views setObject:_ary_objPartition[i] forKey:[NSString stringWithFormat:@"partition_%d",i+1]];
        v_Partition.backgroundColor=[UIColor redColor];
        if (i==3) {
            
            //设置矩形四个圆角半径
            [v_Partition.layer setCornerRadius:10.0];
            //边框宽度
            [v_Partition.layer setBorderWidth:1.0];
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
            //边框颜色
            [v_Partition.layer setBorderColor:colorref];
            CGColorRelease(colorref);
            CGColorSpaceRelease(colorSpace);
            v_Partition.backgroundColor=[UIColor clearColor];
        }
    }
    [self.view addSubview:btn_bid];
    [btn_bid addTarget:self action:@selector(gobid) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton * btn_borrowMoneyRecord=[[UIButton alloc] init];
    btn_borrowMoneyRecord.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:btn_borrowMoneyRecord];
    [btn_borrowMoneyRecord setTitle:@"借款详情" forState:UIControlStateNormal];
    [btn_borrowMoneyRecord addTarget:self action:@selector(borrowMoneyRecord) forControlEvents:UIControlEventTouchUpInside];
    _btn_money=btn_borrowMoneyRecord;
    btn_borrowMoneyRecord.backgroundColor=Color(216, 215, 216);
    [btn_borrowMoneyRecord setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置矩形四个圆角半径
    [btn_borrowMoneyRecord.layer setCornerRadius:3.0];

    
    UIButton * btn_bidRecord=[[UIButton alloc] init];
    btn_bidRecord.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:btn_bidRecord];
    btn_bidRecord.backgroundColor=Color(216, 215, 216);
    [btn_bidRecord setTitle:@"投标记录" forState:UIControlStateNormal];
    [btn_bidRecord addTarget:self action:@selector(bidRecord) forControlEvents:UIControlEventTouchUpInside];
    _btn_bid=btn_bidRecord;
     [btn_bidRecord.layer setCornerRadius:3.0];
    [self bidRecord];
    
    
   
    CGFloat left_margin=([[UIScreen mainScreen] bounds].size.width-210)/2;
    CGFloat txtv_contentHeight=[[UIScreen mainScreen] bounds].size.height-380-80;
    NSDictionary * dic_metrics=@{@"left_margin":[NSNumber numberWithFloat:left_margin],@"txtv_contentHeight":[NSNumber numberWithFloat:txtv_contentHeight],@"margin":[NSNumber numberWithInt:(screenWidth-140)/2]};
    _dic_views=dic_views;
    [dic_views setValue:lb_title forKey:@"lb_title"];
    [dic_views setValue:lb_time forKey:@"lb_time"];
    [dic_views setValue:lb_displayTime forKey:@"lb_displayTime"];
    [dic_views setValue:lb_filishProgress forKey:@"lb_filishProgress"];
    [dic_views setValue:pgb_display forKey:@"pgb_display"];
    [dic_views setValue:btn_bid forKey:@"btn_bid"];
    [dic_views setValue:img_time forKey:@"img_time"];
    [dic_views setValue:btn_bidRecord forKey:@"btn_bidRecord"];
    [dic_views setValue:btn_borrowMoneyRecord forKey:@"btn_borrowMoneyRecord"];
    [dic_views setObject:txtv_content forKey:@"txtv_content"];
    
    UIView * v=[[UIView alloc] init];
    
    //设置矩形四个圆角半径
    [v.layer setCornerRadius:10.0];
    //边框宽度
    [v.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 1 });
    //边框颜色
    [v.layer setBorderColor:colorref];

    
    [self.view addSubview:v];
    v.translatesAutoresizingMaskIntoConstraints=NO;
    v.backgroundColor=[UIColor whiteColor];
    [dic_views setObject:v forKey:@"v"];
    _v=v;
    v.backgroundColor=Color(210, 212, 217);
    v.hidden=YES;
    
    for (int i=0; i<2; i++) {
        img_text_img * txt=[[img_text_img alloc] init];
        txt.translatesAutoresizingMaskIntoConstraints=NO;
        [v addSubview:txt];
        txt.returnKeyType=UIReturnKeyDone;
        txt.delegate=self;
        [dic_views setObject:txt forKey:[NSString stringWithFormat:@"v_txt_%d",i]];
        if (i==1) {
            UIImageView * img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password2.jpg"]];
            txt.leftView=img;
            [txt setLeft_padding:35.0];
             txt.placeholder=@"请输入交易密码";
            txt.leftViewMode=UITextFieldViewModeAlways;
            txt.secureTextEntry=YES;
        }else{
            UIImageView * img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userName.jpg"]];
            txt.leftView=img;
            [txt setLeft_padding:35.0];
              txt.placeholder=@"请输入投标金额";
            txt.leftViewMode=UITextFieldViewModeAlways;
        }
        txt.backgroundColor = [UIColor whiteColor];
        txt.delegate=(id)self;
        //txt.borderStyle=UITextBorderStyleBezel;
    }
    for (int i=0; i<2; i++) {
        UIButton * btn=[[UIButton alloc] init];
        btn.translatesAutoresizingMaskIntoConstraints=NO;
        [v addSubview:btn];
        if (i==0) {
            [btn setTitle:@"投标" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(bid) forControlEvents:UIControlEventTouchUpInside];

        }else{
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        }
        btn.backgroundColor=Color(156, 200, 200);
        [dic_views setObject:btn forKey:[NSString stringWithFormat:@"v_btn_%d",i]];

    }
    
    for (int i=0; i<4; i++) {
        [dic_views setObject:_ary_obj[i] forKey:[NSString stringWithFormat:@"lb_name_%d",i+1]];
    }
    
    NSMutableArray * ary_constranit_v=[[NSMutableArray alloc] init];
    for (int i=0; i<3; i++) {
        if (i!=2) {
            [ary_constranit_v addObject:[NSString stringWithFormat:@"H:|-10-[v_txt_%d]-10-|",i]];
            [ary_constranit_v addObject:[NSString stringWithFormat:@"V:|-%d-[v_txt_%d(==30)]",i*(10+30)+10,i]];
        }else{
            [ary_constranit_v addObject:[NSString stringWithFormat:@"H:|-10-[v_btn_%d(==v_btn_%d)]-[v_btn_%d]-10-|",(i-2),(i-1),(i-1)]];
            [ary_constranit_v addObject:[NSString stringWithFormat:@"V:|-%d-[v_btn_%d(==40)]",i*(10+30)+10,i-2]];
        }
   }
    
    NSArray * ary_constranit=@[@"H:|-0-[lb_title]-0-|",
                               @"V:|-0-[lb_title(==30)]",
                               @"H:|-0-[lb_name_1]-0-|",
                               @"V:|-32-[lb_name_1(==30)]",
                               @"H:|-0-[lb_name_2]-0-|",
                               @"V:|-62.6-[lb_name_2(==30)]",
                               @"H:|-0-[lb_name_3]-0-|",
                               @"V:|-93.2-[lb_name_3(==30)]",
                               @"H:|-0-[lb_name_4]-0-|",
                               
                               @"V:|-123.6-[lb_name_4(==30)]",
                               @"H:|-30-[img_time(==40)]-0-[lb_time(==100)]-0-[lb_displayTime]-0-|",
                               @"V:|-160-[lb_time(==30)]",
                               @"H:|-margin-[lb_filishProgress(==80)]-[pgb_display(==60)]",
                               @"V:|-186-[lb_filishProgress(60)]",
                               @"H:|-40-[btn_bid]-40-|",
                               @"V:|-255-[btn_bid(==50)]",
                               @"H:|-0-[partition_1]-0-|",
                               @"V:|-30-[partition_1(==0.5)]",
                               
                               @"H:|-5-[btn_bidRecord(==btn_borrowMoneyRecord)]-5-[btn_borrowMoneyRecord]-5-|",
                               @"V:|-330-[btn_bidRecord(==40)]",
                               @"H:|-0-[txtv_content]-0-|",
                               @"V:|-370-[txtv_content]-10-|",
                               @"H:|-9-[partition_3]-9-|",
                               @"V:|-370-[partition_3(==0.5)]",
                               @"H:|-5-[partition_4]-5-|",
                               @"V:|-160-[partition_4(==160)]",
                               @"H:|-40-[v]-40-|",
                               @"V:|-120-[v(==135)]"
                               ];
    /*@"H:|-0-[partition_2]-0-|",
    @"V:|-155-[partition_2(==0.5)]",*/
    addConstraints * constrainss=[[addConstraints alloc] init];
    [constrainss addMetrics:dic_metrics andViews:dic_views andSuper:self.view andConstraints:ary_constranit];
    [constrainss addMetrics:dic_metrics andViews:dic_views andSuper:_v andConstraints:ary_constranit_v];

    
}

-(void)borrowMoneyRecord{
    [_btn_bid setBackgroundColor:Color(216, 215, 216)];
    [_btn_money setBackgroundColor:bgColor];
    _txtv_content.text=[self flattenHTML:_dic_Data[@"b_info"][@"content"]];
    [_btn_bid setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn_money setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

//去掉html标签
-(NSString *)flattenHTML:(NSString *)html {
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html=[html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    return html;
}
-(void) pop{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goviewBack:(UIButton *)sender
{
    [self performSelector:@selector(pop) withObject:nil afterDelay:0.1];
    
    //[self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [textField resignFirstResponder];
    return YES;
}

-(void) bidRecord{
    
    [_btn_bid setBackgroundColor:bgColor];
    [_btn_money setBackgroundColor:Color(216, 215, 216)];
    [_btn_money setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn_bid setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if ([_dic_Data[@"tendercount"] integerValue]==0) {
          _txtv_content.text=@"";
    }else{
        NSInteger count=[_dic_Data[@"tendercount"] integerValue];
        NSMutableString * str=[[NSMutableString alloc] init];
        for (int i=0; i<count; i++) {
            [str appendFormat:[NSString stringWithFormat:@"¥投标金额:%@  投标时间:%@\n",_dic_Data[@"tenderInfo"][i][@"money"],_dic_Data[@"tenderInfo"][i][@"addtime"]],nil];
        }
        _txtv_content.text=str;
    }
}
-(void) gobid{
    _v.hidden=!_v.hidden;
    if (_v.hidden==NO) {
        if (g_userID==nil) {
            _altv_prompt = [[UIAlertView alloc] initWithTitle:@"请登录" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
            _v.hidden=YES;
            [_altv_prompt show];
        }
    }
}
-(void) cancel{
    [self gobid];
}
-(void) performDismiss:(NSTimer *)timer
{
    [_altv_prompt dismissWithClickedButtonIndex:0 animated:NO];
}

-(void) bid{
    UITextField * txt=[_dic_views objectForKey:@"v_txt_0"];
    NSString * number=txt.text;
    if (!(txt.text.length>0)) {
        _altv_prompt = [[UIAlertView alloc] initWithTitle:@"请输入交易金额" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        [_altv_prompt show];
        return;
    }
    txt=[_dic_views objectForKey:@"v_txt_1"];
    NSString * password=txt.text;
    if (!(txt.text.length>0)) {
        _altv_prompt = [[UIAlertView alloc] initWithTitle:@"请输入交易密码" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        [_altv_prompt show];
        return;
    }
    __weak borrowMoney * weakSeaf=self;
    if (number.length>0 && password.length>0) {
        _borrowMoneyBlock=^(id Data){
            _altv_prompt = [[UIAlertView alloc] initWithTitle:Data[@"info"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5f target:weakSeaf selector:@selector(performDismiss:) userInfo:nil repeats:NO];
            [weakSeaf.altv_prompt show];

        };
        NSDictionary * dic_request=@{@"id":_idBlock(),@"user_id":g_userID,@"deviceId":IDentifier,@"systemType":[NSNumber numberWithFloat:currentSystemVersion],@"money":number,@"paypassword":password};
        network * net_request=[[network alloc] init];
        [net_request postRequestByByUrlPath:[NSString stringWithFormat:@"%@/Mobileuser/Tender",requestUrl]  andParams:dic_request andCallBack:_borrowMoneyBlock andRequestType:requestType_async];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
