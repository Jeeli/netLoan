//
//  moneyDetails.m
//  Sd
//
//  Created by IOS on 15/8/1.
//  Copyright (c) 2015年 IOS. All rights reserved.
//
/**
 *  资金详情
 */
#import "moneyDetails.h"
#import "globalVariable.h"
#import "moneyDetailsTablewViewCellTableViewCell.h"
#import "moneyDetailsModel.h"
#define cellHeight 90.0
#define pageNumber 10
#import "Login.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
@interface moneyDetails ()
@property(nonatomic,retain) NSMutableArray* mary_Data;
@property(nonatomic,assign) int oldPage;
@property(nonatomic,assign) int curentPage;
@property(nonatomic,strong) UIAlertView * altv_prompt;
@property(nonatomic,assign) int totalpage;
@end

@implementation moneyDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    self.navigationItem.title=@"资金详情";
    _curentPage=_totalpage=1;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (_mary_Data==nil) {
        _mary_Data=[[NSMutableArray alloc] init];
    }
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
    if (_curentPage+1>_totalpage) {
        [self loadNewData:_curentPage andFlag:@"down"];
    }else{
        _curentPage++;
        [self loadNewData:_curentPage andFlag:@"down"];
    }
}
- (void)loadNewData:(int) page andFlag:(NSString *) flag;
{
    __weak moneyDetails *weakSelf=self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/Mobileuser/account_log",requestUrl] parameters:@{@"user_id":g_userID,@"deviceId":IDentifier,@"systemType":[NSNumber numberWithFloat:currentSystemVersion],@"Curpage":[NSNumber numberWithInteger:page],@"page_num":@pageNumber}success:^(AFHTTPRequestOperation *operation, id Data) {
        _totalpage=[Data[@"pageNum"] intValue];
        [weakSelf.mary_Data removeAllObjects];
        if ([NSNull null] != [Data objectForKey:@"data"]){
                for (NSDictionary * dic in Data[@"data"]) {
                moneyDetailsModel *model=[[moneyDetailsModel alloc] initWithDic:dic];
                [weakSelf.mary_Data addObject:model];
            }
        }
        [self.tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        if ([flag isEqual:@"up"]) {
            [self.tableView.footer endRefreshing];
        }else{
            [self.tableView.header endRefreshing];
        }
        if (page==1 || page==_totalpage) {
            _altv_prompt = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"已经加载全部!"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5f target:weakSelf selector:@selector(performDismiss:) userInfo:nil repeats:NO];
            [weakSelf.altv_prompt show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        myLog(@"Error: %@", error);
    }];
}

-(void) performDismissToLogin:(NSTimer *)timer
{
    [_altv_prompt dismissWithClickedButtonIndex:0 animated:NO];
    Login * toLogin=[[Login alloc] init];
    [self.navigationController pushViewController:toLogin animated:NO];
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


- (void)viewWillAppear:(BOOL)animated{
    if (g_userID==nil){
        _altv_prompt = [[UIAlertView alloc] initWithTitle:@"请登录!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(performDismissToLogin:) userInfo:nil repeats:NO];
        [self.altv_prompt show];
  }else{
      // 马上进入刷新状态
      [self.tableView.header beginRefreshing];
  }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (_mary_Data.count>0) {
        return _mary_Data.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID=@"id";
    moneyDetailsTablewViewCellTableViewCell * cell=[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (cell==nil) {
        cell=[[moneyDetailsTablewViewCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (_mary_Data.count>0) {
        cell.model=_mary_Data[indexPath.row];
    }else{
        cell.model=[[moneyDetailsModel alloc] init];
    }
    return cell;
}
@end
