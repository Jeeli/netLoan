//
//  aboutUs.m
//  Sd
//
//  Created by IOS on 15/8/1.
//  Copyright (c) 2015年 IOS. All rights reserved.
//
/**
 *  关于我们
 */
#import "aboutUs.h"
#import "network.h"
#import "AFNetworking.h"
@interface aboutUs ()
@property(nonatomic,copy) networkRequestBlock aboutUsBlock;
@property(nonatomic,weak) UIWebView * txtv_content;
@property(nonatomic,strong) UIAlertController * alert;
@end

@implementation aboutUs

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    self.navigationItem.title=@"关于我们";
    UIWebView * txtv_content=[[UIWebView alloc] init];
    txtv_content.frame=self.view.bounds;
    [self.view addSubview:txtv_content];
    _txtv_content=txtv_content;
    //__weak aboutUs * weakSelf=self;
    _aboutUsBlock=^(id Data){
       //weakSelf.txtv_content.text=Data[@"content"];
    };
    /*network * networkRequest=[[network alloc] init];
    [networkRequest getRequestByUrlPath:[NSString stringWithFormat:@"%@/Mobile/article",requestUrl]	 andParams:nil andCallBack:_aboutUsBlock];*/
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goviewBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    __weak aboutUs * weakSelf=self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/Mobile/article",requestUrl] parameters:@{@"site_id":@2} success:^(AFHTTPRequestOperation *operation, id Data) {
          [txtv_content loadHTMLString:Data[@"content"] baseURL:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        myLog(@"Error: %@", error);
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"网络请求超时!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        _alert=alert;
        [weakSelf presentViewController:weakSelf.alert animated:YES completion:nil];
        [NSTimer scheduledTimerWithTimeInterval:0.6f target:weakSelf selector:@selector(performDismiss:) userInfo:nil repeats:NO];
    }];
    txtv_content.scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    txtv_content.scrollView.bounces=NO;
}
-(void) performDismiss:(NSTimer *)timer
{
    [_alert dismissViewControllerAnimated:YES completion:nil];
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

@end
