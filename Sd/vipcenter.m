//
//  vipcenterViewController.m
//  Sd
//
//  Created by IOS on 15/7/15.
//  Copyright (c) 2015年 IOS. All rights reserved.
//
/**
 *  会员中心
 */
#import "vipcenter.h"

@interface vipcenter()

@end

@implementation vipcenter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    self.navigationItem.title=@"祥瑞资产";
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goviewBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    CGRect bounds = [[UIScreen mainScreen]applicationFrame];
    UIWebView* webView = [[UIWebView alloc]initWithFrame:bounds];
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    webView.dataDetectorTypes=UIDataDetectorTypeAll; //自动检测电话 邮箱等
    [self.view addSubview:webView];
    NSURL* url = [NSURL URLWithString:_url];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
}
- (void)viewWillAppear:(BOOL)animated{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goviewBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
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
