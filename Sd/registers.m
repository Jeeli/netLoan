//
//  register.m
//  Sd
//
//  Created by IOS on 15/7/18.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "registers.h"
#import "addConstraints.h"
#import "mytextFiled.h"
#import "genderModel.h"
#import "myUIButton.h"
#import "myUILabel.h"
#import "myUITableView.h"
#import  "keyBoard.h"
#import "network.h"
#define textFiledHeight 75
@interface registers()<selectMoreDelegate>
@property(nonatomic,assign) UITableView * tb_list;
@property(nonatomic,weak) UIScrollView * v_super;
@property(nonatomic,retain) NSMutableArray * ary_subview;
@property(nonatomic,retain) NSMutableArray * ary_obj;
@property(nonatomic,assign) CGFloat keyboardheight;
@property(nonatomic,copy) networkRequestBlock registeBlock;
@property(nonatomic,strong) UIAlertView * altv_prompt;
@end
@implementation registers

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (BOOL)prefersStatusBarHidden
{
    return NO; // 返回NO表示要显示，返回YES将hiden
}
-(void) viewDidLoad{
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
       [self loadData];
    [self createSubviews];
    self.navigationItem.title=@"注册";
    
    [self.navigationController setNavigationBarHidden:NO];
    
    /*[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHide) name:UIKeyboardWillHideNotification object:nil];*/
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goviewBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];

    
}
- (void)goviewBack:(UIButton *)sender
{
    [self performSelector:@selector(pop) withObject:nil afterDelay:0.1];
    
}
-(void) pop{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) keyboardWasShown:(NSNotification *) aNotification{
    NSDictionary* info = [aNotification userInfo];
    //得到键盘的高度
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.keyboardheight=kbSize.height;
}
- (void) loadData{
    if (_ary_subview==nil) {
        _ary_obj=[[NSMutableArray alloc]  init];
        _ary_subview=[[NSMutableArray alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"register" ofType:@"json"];
        
        NSData *subViewData = [[NSData alloc] initWithContentsOfFile:path];
        
        NSArray *subViewDic = [NSJSONSerialization JSONObjectWithData:subViewData options:0 error:nil];
        for (NSDictionary *dic in subViewDic){
            [_ary_subview addObject:dic];
        }
    }
}

- (void)viewDidLayoutSubviews{
      _v_super.contentSize=CGSizeMake(0,650);
}
-(void) createSubviews{
    UIView * v_super=[[UIView alloc] init];
    UIScrollView * scv_super=[[UIScrollView alloc] init];
    [self.view addSubview:scv_super];
    _v_super=scv_super;
    scv_super.showsVerticalScrollIndicator=NO;
    scv_super.frame=self.view.bounds;
    [scv_super addSubview:v_super];
    v_super.translatesAutoresizingMaskIntoConstraints=NO;
  

    for (int i=0;i<3; i++) {
        mytextFiled * myTxt=[[mytextFiled alloc] initWithImage:_ary_subview[i][@"image"] andText:_ary_subview[i][@"text"] andIsSecureText:[_ary_subview[i][@"IsSecureText"] isEqual:@"YES"]?YES:NO andPlaceholder:_ary_subview[i][@"Placeholder"] andWidth:textFiledHeight andImageWidth:30 andDisplayBorder:YES];
        myTxt.translatesAutoresizingMaskIntoConstraints=NO;
        [v_super addSubview:myTxt];
        [myTxt addAry_name:_ary_subview[i][@"name"]];
        [_ary_obj addObject:myTxt];
    }
    for (int i=3; i<4; i++) {
        myUIButton * bt=[[myUIButton alloc] init];
        [bt setTitle:_ary_subview[i][@"text"] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        bt.translatesAutoresizingMaskIntoConstraints=NO;
        [bt addAry_name:_ary_subview[i][@"name"]];
        [v_super addSubview:bt];
        [_ary_obj addObject:bt];
        bt.backgroundColor=bgColor;
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //设置矩形四个圆角半径
        [bt.layer setCornerRadius:10.0];
        //边框宽度
        [bt.layer setBorderWidth:1.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 0 });
        //边框颜色
        [bt.layer setBorderColor:colorref];
        if ([_ary_subview[i][@"name"] isEqual:@"bt_cancel"]) {
            [bt  addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [bt addTarget:self action:@selector(registers) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //[self.view addSubview:v_super];
    double v_super_height=450;
    
    int lb_register_height=50;
    int v_margin=10;
    int bt_height=40;
    int txt_height=30;
    
    NSMutableArray * ary_Constraints=[[NSMutableArray alloc] init];
    NSMutableDictionary * metrics=[[NSMutableDictionary alloc] init];
    [metrics setObject:[NSNumber numberWithFloat:v_super_height] forKey:@"v_super_height"];
    [metrics setObject:[NSNumber numberWithFloat:lb_register_height] forKey:@"lb_register_height"];
    [metrics setObject:[NSNumber numberWithFloat:txt_height] forKey:@"txt_height"];
    [metrics setObject:[NSNumber numberWithFloat:bt_height] forKey:@"bt_height"];
    CGFloat v_superWidth=[UIScreen mainScreen].bounds.size.width-16;
    [metrics setObject:[NSNumber numberWithFloat:v_superWidth] forKey:@"v_superWidth"];
    
    NSString *top;
    NSString *left;
    NSString *bottom;
    NSString *right;
    NSString *H_constraint;
    NSString *V_constraint;
   for (int i=0; i<v_super.subviews.count; i++) {
            top=[NSString stringWithFormat:@"%@_topMargin",[v_super.subviews[i] getName]];
            left=[NSString stringWithFormat:@"%@_leftMargin",[v_super.subviews[i] getName]];
            bottom=[NSString stringWithFormat:@"%@_bottomMargin",[v_super.subviews[i] getName]];
            right=[NSString stringWithFormat:@"%@_rightMargin",[v_super.subviews[i] getName]];
          if(i==v_super.subviews.count-1){

                [metrics setObject:[NSNumber numberWithFloat:lb_register_height+v_margin*i+(i-2)*txt_height+bt_height] forKey:top];
                [metrics setObject:@30 forKey:left];
                [metrics setObject:@30 forKey:right];
                H_constraint=[NSString stringWithFormat:@"H:|-%@-[%@]-%@-|",left,[v_super.subviews[i] getName],right];
                V_constraint=[NSString stringWithFormat:@"V:|-%@-[%@(==%@)]",top,[v_super.subviews[i]getName],@"bt_height"];
                [ary_Constraints addObject:H_constraint];
                [ary_Constraints addObject:V_constraint];

            }else{
                [metrics setObject:@3 forKey:left];
                [metrics setObject:@3 forKey:right];
                [metrics setObject:[NSNumber numberWithFloat:lb_register_height+(i-1)*txt_height+i*v_margin] forKey:top];
                H_constraint=[NSString stringWithFormat:@"H:|-%@-[%@]-%@-|",left,[v_super.subviews[i] getName],right];
                if ([v_super.subviews[i] isKindOfClass:[UIButton class]]) {
                    V_constraint=[NSString stringWithFormat:@"V:|-%@-[%@(==%@)]",top,[v_super.subviews[i]getName],@"bt_height"];
                    [ary_Constraints addObject:V_constraint];
                }else{
                    V_constraint=[NSString stringWithFormat:@"V:|-%@-[%@(==%@)]",top,[v_super.subviews[i]getName],@"txt_height"];
                    [ary_Constraints addObject:V_constraint];
                }
                [ary_Constraints addObject:H_constraint];

         }
   }
    
    
    NSMutableDictionary * viewsDic=[[NSMutableDictionary alloc] init];
    [viewsDic setObject:v_super forKey:@"v_super"];
    for (int i=0;i<_ary_obj.count; i++) {
        [viewsDic setObject:_ary_obj[i] forKey:_ary_subview[i][@"name"]];
    }
 
    NSArray *ary_super=@[
                     @"H:|-[v_super(==v_superWidth)]-|",
                     @"V:|-0-[v_super(==v_super_height)]"];
    //添加约束
    addConstraints *addconstraints=[[addConstraints alloc] init];
    [addconstraints addMetrics:metrics andViews:viewsDic andSuper:self.v_super andConstraints:ary_super];
    
    addConstraints *addconstraints2=[[addConstraints alloc] init];
    [addconstraints2 addMetrics:metrics andViews:viewsDic andSuper:v_super andConstraints:ary_Constraints];

}

-(void) performDismiss:(NSTimer *)timer
{
    [_altv_prompt dismissWithClickedButtonIndex:0 animated:NO];
}
-(void) registers{
  
    mytextFiled * filed=nil;
    NSString * name;
    NSString * password;
    NSString * rePassword;
    filed=_ary_obj[0];
    name=filed.textFiledInfo();
    filed=_ary_obj[1];
    password=filed.textFiledInfo();
    filed=_ary_obj[2];
    rePassword=filed.textFiledInfo();
    for (int i=0; i<_ary_obj.count-1; i++) {
            filed=_ary_obj[i];
            if ([filed.textFiledInfo() isEqual:@""]) {
                _altv_prompt = [[UIAlertView alloc] initWithTitle:@"请完整信息!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
                [self.altv_prompt show];
                return;
            }
     }

    //判断两次密码输入是否一致
    if (![password isEqual:rePassword]) {
        _altv_prompt = [[UIAlertView alloc] initWithTitle:@"密码输入不一致!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        [self.altv_prompt show];
    }else{
        __weak registers * weakSelf=self;
        _altv_prompt = [[UIAlertView alloc] initWithTitle:@"正在注册!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [weakSelf.altv_prompt show];
        _registeBlock=^(id Data){
            [weakSelf.altv_prompt setTitle:@"注册成功!"];
            [NSTimer scheduledTimerWithTimeInterval:2.0f target:weakSelf selector:@selector(performDismiss:) userInfo:nil repeats:NO];
        };
        NSString * str_request=[NSString stringWithFormat:@"username=%@&password=%@&RePassword=%@",name,password,rePassword];
        network * networkRequest=[[network alloc] init];
        [networkRequest postRequestByByUrlPath:[NSString stringWithFormat:@"%@/Mobile/register_action",requestUrl] andParams:str_request andCallBack:_registeBlock andRequestType:requestType_async];
    }
}

- (void) cancel:(UIButton *) sender{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectMore{
    self.tb_list.hidden=!self.tb_list.hidden;
}
@end
