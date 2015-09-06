//
//  withdrawRecord.m
//  Sd
//
//  Created by IOS on 15/8/1.
//  Copyright (c) 2015年 IOS. All rights reserved.
//
/**
 *  提现记录
 */
#import "withdrawRecord.h"
#import "globalVariable.h"
#import "withdrawTablewViewCell.h"
#import "withdrawModel.h"
#import "Login.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#define cellHeight 70
#define  pageNumber 8
@interface withdrawRecord ()
@property(nonatomic,retain) NSMutableArray *mary_Data;
@property(nonatomic,assign) int curentPage;
@property(nonatomic,assign) int totalPage;
@property(nonatomic,strong) UIAlertView * altv_prompt;
@end

@implementation withdrawRecord

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    self.navigationItem.title=@"提现记录";
    if (_mary_Data==nil) {
        _mary_Data=[[NSMutableArray alloc] init];
    }
    _curentPage=_totalPage=1;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goviewBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downloadData];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self upLoadData];
    }];
}
//上拉刷新
-(void) upLoadData{
    if (_curentPage==0 || _curentPage==1){
        [self loadNewData:_curentPage andFlag:@"up"];
    }else{
        _curentPage--;
        [self loadNewData:_curentPage andFlag:@"up"];
    }
}
//下拉刷新
-(void) downloadData{
    if (_curentPage+1>_totalPage) {
        [self loadNewData:_curentPage andFlag:@"down"];
    }else{
        _curentPage++;
        [self loadNewData:_curentPage andFlag:@"down"];
    }
}
- (void)loadNewData:(int) page andFlag:(NSString *) flag;
{
    __weak withdrawRecord *weakSelf=self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/Mobileuser/Cashlog",requestUrl] parameters:@{@"user_id":g_userID,@"deviceId":IDentifier,@"systemType":[NSNumber numberWithFloat:currentSystemVersion],@"Curpage":[NSNumber numberWithInteger:page],@"page_num":@pageNumber} success:^(AFHTTPRequestOperation *operation, id Data) {
        _totalPage=[Data[@"pageNum"] intValue];
        [weakSelf.mary_Data removeAllObjects];
        for (NSDictionary * dic in Data[@"info"]) {
            withdrawModel * model=[[withdrawModel alloc]  initWithDic:dic];
            [weakSelf.mary_Data addObject:model];
        }
        [self.tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        if ([flag isEqual:@"up"]) {
            [self.tableView.footer endRefreshing];
        }else{
            [self.tableView.header endRefreshing];
        }
        if (page==1 || page==_totalPage) {
            _altv_prompt = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"已经加载全部!"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5f target:weakSelf selector:@selector(performDismiss:) userInfo:nil repeats:NO];
            [weakSelf.altv_prompt show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        myLog(@"Error: %@", error);
    }];
}

-(void) pop{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)goviewBack:(UIButton *)sender
{
    [self performSelector:@selector(pop) withObject:nil afterDelay:0.1];
}
-(void) performDismiss:(NSTimer *)timer
{
    [_altv_prompt dismissWithClickedButtonIndex:0 animated:NO];
}


-(void) performDismissToLogin:(NSTimer *)timer
{
    [_altv_prompt dismissWithClickedButtonIndex:0 animated:NO];
    Login * toLogin=[[Login alloc] init];
    [self.navigationController pushViewController:toLogin animated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    if (g_userID==nil) {
        _altv_prompt = [[UIAlertView alloc] initWithTitle:@"请登录!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(performDismissToLogin:) userInfo:nil repeats:NO];
        [self.altv_prompt show];

    }else{
        // 马上进入刷新状态
        [self.tableView.header beginRefreshing];

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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (_mary_Data.count>0) {
        return _mary_Data.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID=@"id";
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    withdrawTablewViewCell * cell=[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (cell==nil) {
        cell=[[withdrawTablewViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (_mary_Data.count>0) {
       cell.model=_mary_Data[indexPath.row];
    }else{
       cell.model=[[withdrawModel alloc] init];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}
@end
