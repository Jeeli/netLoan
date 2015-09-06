//
//  noticeDetails.m
//  Sd
//
//  Created by IOS on 15/9/1.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "noticeDetails.h"
#import "AFNetworking.h"
@interface noticeDetails()
@property(nonatomic,weak) UIWebView * web;
@end
@implementation noticeDetails
- (void)viewDidLoad{
    [super viewDidLoad];
    UIWebView * web=[[UIWebView alloc] init];
    [self.view addSubview:web];
    web.frame=self.view.bounds;
    _web=web;
    _web.scrollView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goviewBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];

}
-(void) pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goviewBack:(UIButton *)sender
{
    [self performSelector:@selector(pop) withObject:nil afterDelay:0.1];
}

- (void)setID:(NSString *)ID{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/Mobile/article",requestUrl] parameters:@{@"id":ID} success:^(AFHTTPRequestOperation *operation, id Data) {
         [_web loadHTMLString:Data[@"content"] baseURL:nil];
        [self setTitle:Data[@"name"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        myLog(@"Error: %@", error);
    }];

}
@end
