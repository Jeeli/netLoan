//
//  newNotice.m
//  Sd
//
//  Created by IOS on 15/8/1.
//  Copyright (c) 2015年 IOS. All rights reserved.
//
/**
 *  最新公告
 */
#import "newNotice.h"
#import "network.h"
#import "newNoticeHeaderView.h"
#import "noticeModel.h"
#import "noticeTablewViewCellTableViewCell.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "TimeHelp.h"
#import "noticeDetails.h"
@interface newNotice ()
@property(nonatomic,retain) NSMutableArray * ary_NOtice;
@property(nonatomic,weak) newNoticeHeaderView *headerView;
@property(nonatomic,retain) NSDictionary * dic_noticeDetails;
@property(nonatomic,assign) int curentPage;
@property(nonatomic,assign) int totalPage;
@property(nonatomic,strong) UIAlertView * altv_prompt;
@property(nonatomic,assign) CGFloat cell_height;
@end

@implementation newNotice

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    _curentPage=_totalPage=1;
    _cell_height=50;
    self.navigationItem.title=@"最新公告";
    if (_ary_NOtice==nil) {
        _ary_NOtice=[[NSMutableArray alloc] init];
        _dic_noticeDetails=[[NSMutableDictionary alloc] init];
    }
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
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
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
    __weak newNotice *weakSelf=self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/Mobile/article",requestUrl] parameters:@{@"site_id":@22,@"Curpage":@1,@"page_num":@11} success:^(AFHTTPRequestOperation *operation, id Data) {
        _totalPage=[Data[@"pageNum"] intValue];
        [weakSelf.ary_NOtice removeAllObjects];
        for (NSDictionary * dic in Data[@"ArticleInfo"]) {
            [weakSelf.ary_NOtice addObject:dic];
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

- (void)viewWillAppear:(BOOL)animated{}
-(void) performDismiss:(NSTimer *)timer
{
    [_altv_prompt dismissWithClickedButtonIndex:0 animated:YES];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_ary_NOtice.count>0) {
        return _ary_NOtice.count;
    }
    return 0;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static  NSString *  ID=@"id";
    //[self.tbv_Display registerClass:[noticeTablewViewCellTableViewCell class] forCellReuseIdentifier:ID];
    noticeTablewViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[noticeTablewViewCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (_ary_NOtice.count>0) {
        [cell setName:_ary_NOtice[indexPath.row][@"name"]];
    }
    return cell;
}
//注意区别didSelectRowAtIndexPath和didDeselectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    noticeDetails * details=[[noticeDetails alloc] init];
     [self.navigationController pushViewController:details animated:YES];
     details.ID=_ary_NOtice[indexPath.row][@"id"];
}
@end
