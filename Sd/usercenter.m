//
//  usercenter.m
//  Sd
//
//  Created by IOS on 15/7/13.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "usercenter.h"
#import "userCenterHeaderView.h"
#import "addConstraints.h"
#import "globalVariable.h"
#import "network.h"
#import "bid.h"
#import "withdraw.h"
#import "newMemberGuide.h"
#import "aboutUs.h"
#import "UIImageView+WebCache.h"
#import "moneyDetails.h"
#import "home.h"
#import "Login.h"
@interface usercenter()<UITableViewDataSource,UITableViewDelegate,goControllerDelegate>
@property(nonatomic,weak) UITableView * tbv_list;
@property(nonatomic,retain) NSArray * array_image;
@property(nonatomic,retain) NSArray * array_text;
@property(nonatomic,strong) userCenterHeaderView * hdv_header;
@property(nonatomic,copy) networkRequestBlock usercenterNetworkBlock;
@property(nonatomic,retain) NSArray * ary_aimController;
@property(nonatomic,weak) UIButton * btn_left;
@end
@implementation usercenter


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)viewDidLoad{
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    //去掉导航栏半透明效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏的颜色
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    self.navigationItem.title=@"用户中心";
    if (self.array_image==nil) {
        self.array_image=[[NSArray alloc] init];
        self.array_image=@[@"cen_r1_c1.jpg",@"cen_r3_c1.jpg",@"cen_r5_c1.jpg",@"3331.jpg"];
        _ary_aimController=@[
                             [[newMemberGuide alloc] init],
                             [[aboutUs alloc] init],
                             [[moneyDetails alloc] init],
                            ];
    }
    if (self.array_text==nil) {
        self.array_text=[[NSMutableArray alloc] init];
        self.array_text=@[@"新手上路",@"关于我们",@"交易记录",@"退出登录"];
    }
    UITableView * tbv_list=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tbv_list];
    tbv_list.dataSource=self;
    tbv_list.delegate=self;
    tbv_list.showsVerticalScrollIndicator=NO;
    
    userCenterHeaderView * v_header=[[userCenterHeaderView alloc] initWithUserImage:@"user.jpg" andUserName:g_userName andAvailable:@"0元" andFreeze:@"0元" andTotal:@"0元"];
        tbv_list.contentInset=UIEdgeInsetsMake(0, 0, 70, 0);
        v_header.frame=CGRectMake(0, 0, self.view.frame.size.width, 280);
        tbv_list.tableHeaderView=v_header;
        self.tbv_list=tbv_list;
    _hdv_header=v_header;
    v_header.delegate=self;
    //tbv_list.style=UITableViewStylePlain;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goviewBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    _btn_left=leftBtn;

    v_header.gobidBlock=^(){
        if (self.hidesBottomBarWhenPushed==YES) {}else{
             [self.delegate goHome];
        }
    };
    v_header.goLoginBlock=^(){
        [self.navigationController pushViewController:[[Login alloc] init] animated:YES];
    };
}
- (void)goWithdraw{
    [self.navigationController pushViewController:[[withdraw alloc] init] animated:YES];
}
- (void)goBid{
    bid * goBid=[[bid alloc] init];
    goBid.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:goBid animated:YES];
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
    if ([_flag isEqual:@"Y"]) {
        _btn_left.hidden=YES;
    }
    //__weak typeof(self) weakSelf;
    __weak usercenter * weakSelf=self;
    if (g_userID==nil) {
         weakSelf.hdv_header.setDataBlock(nil);
    }else{
        NSString * netRequest=[NSString stringWithFormat:@"user_id=%@&deviceId=%@&systemType=%@",g_userID,IDentifier,[NSNumber numberWithFloat:currentSystemVersion]];
        _usercenterNetworkBlock=^(id Data){
        weakSelf.hdv_header.setDataBlock(Data[@"data"]);
        };
        network * networkRequest=[[network alloc] init];
       [networkRequest postRequestByByUrlPath:[NSString stringWithFormat:@"%@/Mobileuser/Ucenter",requestUrl] andParams:netRequest andCallBack:_usercenterNetworkBlock andRequestType:requestType_async];
    }

}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return _array_text.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"ID";
    [self.tbv_list registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text=self.array_text[indexPath.section];
    cell.imageView.image=[UIImage imageNamed:_array_image[indexPath.section]];
    cell.textLabel.textColor=Color(108, 133, 148);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==_ary_aimController.count) {
            if (g_userID==nil) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"你还未登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定退出吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                 g_userID=nil;
                _hdv_header.setDataBlock(nil);
            }];
            [alert addAction:defaultAction];
            UIAlertAction* default2Action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
               
            }];
            [alert addAction:default2Action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        [self.navigationController pushViewController:_ary_aimController[indexPath.section] animated:YES];
    }
}

@end
