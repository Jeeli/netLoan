//
//  finance.m
//  Sd
//
//  Created by IOS on 15/7/13.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "finance.h"
#import "addConstraints.h"
#import "bid.h"
#import "withdraw.h"
@implementation finance

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    //去掉导航栏半透明效果
    self.navigationController.navigationBar.translucent = NO;
    
    //设置导航栏的颜色
    [self.navigationController.navigationBar setBarTintColor:Color(189, 84, 79)];
   [self.view setBackgroundColor:[UIColor whiteColor]];

   self.navigationItem.title=@"理财";
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];

    
}

-(void) goBid{
    bid * gobid=[[bid alloc] init];
    [self.navigationController pushViewController:gobid animated:NO];
}
-(void)goWithdraw{
    withdraw * gowithdraw=[[withdraw alloc] init];
    [self.navigationController pushViewController:gowithdraw animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ID";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==0) {
          cell.textLabel.text=@"投标";
    }else{
        cell.textLabel.text=@"提现";
    }
    [cell.textLabel setTextColor:Color(121, 120, 121)];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [self goBid];
    }else{
        [self goWithdraw];
    }


}

@end
