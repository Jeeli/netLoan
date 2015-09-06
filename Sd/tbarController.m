//
//  tbarController.m
//  Sd
//
//  Created by IOS on 15/7/13.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "tbarController.h"
#import "home.h"
#import "usercenter.h"
#import "finance.h"
#import "set.h"
#import "mytabbar.h"
#import "addConstraints.h"
#import "bid.h"
#import "mybuttonV.h"
@interface tbarController ()<selectindexDelegate,userCenterDelegate>
@property(nonatomic,weak) UIButton * btn_oldSelect;
@property(nonatomic,weak) mytabbar * mybar;
@end

@implementation tbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};

    //[self.tabBar removeFromSuperview];
    // Do any additional setup after loading the view.
    [self setnavicontro];

}
/**
*  第一次使用这个类的时候会调用(1个类只会调用1次)
*/
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];

}

+ (void)setupNavBarTheme
{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置背景
    
    //[navBar setBackgroundImage:[UIImage imageNamed:@"1.png"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundColor:[UIColor  brownColor]];
}

-(void) setnavicontro{
    
    //homes *vc_home=[[homes alloc] init];
    //UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 100),collectionViewLayout:flowLayout];
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    //[flowLayout setItemSize:CGSizeMake(300,50)]; //设置每个cell显示数据的宽和高 
    //[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //垂直滑动
    
    
    home *clv_home=[[home alloc] initWithCollectionViewLayout:flowLayout];
    set  *vc_set=[[set alloc] init];
    //finance *vc_finance=[[finance alloc] init];
    bid * vc_bid=[[bid alloc] init];
    vc_bid.hidesBottomBarWhenPushed=NO;
    usercenter *vc_usercenter=[[usercenter alloc] init];
    vc_usercenter.delegate=self;
    [vc_usercenter setFlag:@"Y"];
    [vc_set setFlag:@"Y"];
    [vc_bid setFlag:@"Y"];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:clv_home]];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:vc_bid]];

    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:vc_usercenter]];

    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:vc_set]];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)goHome{
    self.btn_oldSelect.selected=NO;
    self.selectedIndex=0;
    mybutton * btn=_mybar.subviews[0];
    btn.selected=YES;
    self.btn_oldSelect=btn;
}
- (void) viewWillAppear:(BOOL)animated{
   }
- (void)viewDidAppear:(BOOL)animated{
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
            myLog(@"subviews.class=%@",[child class]);
        if ([child isKindOfClass:[UIControl class]]) {
            //[child removeFromSuperview];
        }
    }
    [self creatMytabBar];
}

- (void) creatMytabBar{
    mytabbar *my_tabbar=[[mytabbar alloc] initWithbutton:(int)self.childViewControllers.count  andSuper:self.view];
    _mybar=my_tabbar;
    my_tabbar.frame=self.tabBar.bounds;
    //[self.view addSubview:my_tabbar];
    [self.tabBar addSubview:my_tabbar];
    my_tabbar.mytabardelegate=self;
    /*my_tabbar.translatesAutoresizingMaskIntoConstraints=NO;
    NSDictionary * dic_views=@{@"my_tabbar":my_tabbar};
    addConstraints * constraints=[[addConstraints alloc] init];
    [constraints addMetrics:nil andViews:dic_views andSuper:self.view andConstraints:@[
                                                                                       
                                       @"H:|-0-[my_tabbar]-0-|",
                                       @"V:[my_tabbar(==49)]-0-|"]];
    _my_tabbar=my_tabbar;*/
  }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)selecttindex:(UIButton *)button{
    self.btn_oldSelect.selected=NO;
    self.selectedIndex=button.tag;
    button.selected=YES;
    self.btn_oldSelect=button;
}
@end
