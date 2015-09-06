//
//  set.m
//  Sd
//
//  Created by IOS on 15/7/13.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "set.h"
#import "vipcenter.h"
#import "aboutUs.h"
@interface set()
@property(nonatomic,retain) NSArray * array_celltext;
@property(nonatomic,weak) UIButton * btn_left;
@end
@implementation set

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)viewWillAppear:(BOOL)animated{
    if ([_flag isEqual:@"Y"]) {
        _btn_left.hidden=YES;
    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goviewBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    _btn_left=leftBtn;
    //去掉导航栏半透明效果
    self.navigationController.navigationBar.translucent = NO;
    
    //设置导航栏的颜色
      [self.navigationController.navigationBar setBarTintColor:bgColor];

   self.navigationItem.title=@"设置";
    if (self.array_celltext==nil) {
        self.array_celltext=[[NSArray alloc] initWithObjects:@"关于我们",@"访问官网",nil];
    }
    UIImageView *img_headimage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    img_headimage.contentMode=UIViewContentModeCenter;
    self.tableView.tableHeaderView=img_headimage;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array_celltext.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"ID";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text=self.array_celltext[indexPath.row];
    [cell.textLabel setTextColor:Color(121, 120, 121)];
    return cell;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [self.navigationController pushViewController:[[aboutUs alloc] init] animated:NO];
    }else if(indexPath.row==2){
        vipcenter * v=[[vipcenter alloc] init];
        v.url=requestUrl;
         [self.navigationController pushViewController:v animated:NO];
    }
}

@end
