//
//  bid.m
//  Sd
//
//  Created by IOS on 15/7/27.
//  Copyright (c) 2015年 IOS. All rights reserved.
//
/**
 *  投标
 */
#import "bid.h"
#import "bidTableViewCell.h"
#import "borrowMoney.h"
#import "network.h"
#import "bidModel.h"
#import "globalVariable.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#define cellHeight 110.0
#define pageNumber 8
#import "Login.h"
@interface bid ()
@property(nonatomic,copy) networkRequestBlock bidList_block;
@property(nonatomic,copy) networkRequestBlock bidId_block;
@property(nonatomic,retain) NSMutableArray * mary_bidModel;
@property(nonatomic,strong) borrowMoney * borrowmoney;
@property(nonatomic,assign) int oldPage;
@property(nonatomic,assign) int curentPage;
@property(nonatomic,weak) UIButton * btn_left;
@property(nonatomic,assign) NSInteger totalPage;
@property(nonatomic,strong) UIAlertView * altv_prompt;
@property(nonatomic,copy) NSString * str_refreshTime;
@property(nonatomic,retain) NSMutableArray * mary_state;
@property(nonatomic,strong) UIAlertController * alert;
@end

@implementation bid

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    if (_mary_bidModel==nil) {
        _mary_bidModel=[[NSMutableArray alloc] init];
        _mary_state=[[NSMutableArray alloc] init];
    }
    //去掉导航栏半透明效果
    self.navigationController.navigationBar.translucent = NO;
    
    //设置导航栏的颜色
    [self.navigationController.navigationBar setBarTintColor:bgColor];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _oldPage=_curentPage=_totalPage=1;
    //设置分割线的颜色
    [self.tableView setSeparatorColor:Color(121, 120, 121)];
    
    self.navigationItem.title=@"我要投标";

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goviewBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    _btn_left=leftBtn;
    
    self.tableView.showsVerticalScrollIndicator=NO;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    
    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downloadData];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
         [self upLoadData];
    }];
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
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
    __weak bid *weakSelf=self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/Mobile/investList",requestUrl] parameters:@{@"Curpage":[NSNumber numberWithInt:page],@"page_num":@pageNumber} success:^(AFHTTPRequestOperation *operation, id Data) {
        weakSelf.totalPage=[Data[@"pageNum"] integerValue];
        [weakSelf.mary_bidModel removeAllObjects];
        for (NSDictionary * dic in Data[@"info"]) {
            bidModel * model=[[bidModel alloc]  initWithDic:dic];
            [weakSelf.mary_bidModel addObject:model];
        }
        [self.tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        if ([flag isEqual:@"up"]) {
             [weakSelf.tableView.footer endRefreshing];
        }else{
             [weakSelf.tableView.header endRefreshing];
        }
        if (page==1 || page==weakSelf.totalPage) {
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"已经加载全部!" message:nil preferredStyle:UIAlertControllerStyleAlert];
            _alert=alert;
            [weakSelf presentViewController:weakSelf.alert animated:YES completion:nil];
            [NSTimer scheduledTimerWithTimeInterval:0.6f target:weakSelf selector:@selector(performDismiss:) userInfo:nil repeats:NO];
      }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        myLog(@"Error: %@", error);
        if ([flag isEqual:@"up"]) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
        }
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"网络请求超时!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        _alert=alert;
        [weakSelf presentViewController:weakSelf.alert animated:YES completion:nil];
        [NSTimer scheduledTimerWithTimeInterval:0.6f target:weakSelf selector:@selector(performDismiss:) userInfo:nil repeats:NO];
    }];
}

-(NSString *) getCurrentTime{
    
    /*NSString* date;
     NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     date = [formatter stringFromDate:[NSDate date]];*/
    NSDate* now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
     unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    NSDateComponents *dd = [cal components:unitFlags fromDate:now];
    /*NSInteger y = [dd year];
    NSInteger m = [dd month];
    NSInteger d = [dd day];*/
    NSInteger hour = [dd hour];
    NSInteger min = [dd minute];
    NSInteger sec = [dd second];
    return [NSString stringWithFormat:@"%ld:%ld:%ld",(long)hour,(long)min,(long)sec];
}


-(void) performDismiss:(NSTimer *)timer
{
    //[_altv_prompt dismissWithClickedButtonIndex:0 animated:NO];
    [_alert dismissViewControllerAnimated:YES completion:nil];
    
}
-(void) performDismissToLogin:(NSTimer *)timer
{
    [_altv_prompt dismissWithClickedButtonIndex:0 animated:NO];
    Login * toLogin=[[Login alloc] init];
    [self.navigationController pushViewController:toLogin animated:NO];
}

- (void)viewWillAppear:(BOOL)animated{
    if ([_flag isEqual:@"Y"]) {
        _btn_left.hidden=YES;
    }
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            //隐藏底部tabbar
            //self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
-(void) pop{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)goviewBack:(UIButton *)sender
{
    [self performSelector:@selector(pop) withObject:nil afterDelay:0.1];
}

#pragma mark - 设置分割线从最左端开始
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
         return cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (_mary_bidModel.count>0) {
        return _mary_bidModel.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID=@"ID";
    bidTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[bidTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (_mary_bidModel.count>0) {
        cell.bidmodel=_mary_bidModel[indexPath.row];
    }else{
        cell.bidmodel=[[bidModel alloc] init];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    borrowMoney * borrow=[[borrowMoney alloc] init];
    borrow.idBlock=^(){
        return [_mary_bidModel[indexPath.row] ID]; //返回id 
    };
    borrow.nameBlock=^(){
        return [_mary_bidModel[indexPath.row] name];
    };
    _borrowmoney=borrow;
    [self performSelector:@selector(push) withObject:nil afterDelay:0.1];
}
-(void) push{
    [self.navigationController pushViewController:_borrowmoney animated:YES];
}
@end
