//
//  homes.m
//  Sd
//
//  Created by IOS on 15/7/15.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "home.h"
#import "myCollectionViewCell.h"
#import "vipcenter.h"
#import "Login.h"
#import "myCollectionViewCellModel.h"
#import "topUp.h"
#import "bid.h"
#import "moneyDetails.h"
#import "aboutUs.h"
#import "newCharacter.h"
#import "withdrawRecord.h"
#import "topUpRecord.h"
#import "withdraw.h"
#import "newMemberGuide.h"
#import "newNotice.h"
#import "globalVariable.h"
#import "set.h"
#import "usercenter.h"
@interface home ()
@property(nonatomic,retain) NSMutableArray * ary_aimViewController;
@property(nonatomic,retain) NSMutableArray * ar_myCollectionViewCellModel;
@property(nonatomic,strong) UIAlertView * altv_prompt;
@end

@implementation home

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    //去掉导航栏半透明效果
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏的颜色
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    [self loadData];
    [self.collectionView setContentInset:UIEdgeInsetsMake(10, 0, 10, 0)];
     self.navigationItem.title=@"祥瑞资产";
     self.collectionView.backgroundColor=[UIColor whiteColor];
    
     //去掉垂直方向滚动条
     self.collectionView.showsVerticalScrollIndicator=NO;
    
     // Register cell classes
     [self.collectionView registerClass:[myCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    
    if (_ary_aimViewController==nil) {
        _ary_aimViewController=[NSMutableArray array];
        bid * toBid=[[bid alloc] init];
        toBid.hidesBottomBarWhenPushed=YES;
        //vipcenter * toVipCenter=[[vipcenter alloc] init];
        moneyDetails *toMoneyDetails=[[moneyDetails alloc] init];
        //topUp * toTopUp=[[topUp alloc] init];
        withdraw * toWithdraw=[[withdraw alloc] init];
        newMemberGuide * toNewMemberGuide=[[newMemberGuide alloc] init];
        topUpRecord *toTopUpRecord=[[topUpRecord alloc] init];
        withdrawRecord * toWithDrawRecord=[[withdrawRecord alloc] init];
        newNotice *toNewNotice=[[newNotice alloc] init];
        aboutUs *toAboutUs=[[aboutUs alloc] init];
        set * toSet=[[set alloc] init];
        toSet.hidesBottomBarWhenPushed=YES;
        usercenter * toUserCenter=[[usercenter alloc] init];
        toUserCenter.hidesBottomBarWhenPushed=YES;
        Login *toLogin=[[Login alloc] init];
         [_ary_aimViewController addObject:toUserCenter];
         [_ary_aimViewController addObject:toBid];
         [_ary_aimViewController addObject:toMoneyDetails];
         //[_ary_aimViewController addObject:toTopUp];
         [_ary_aimViewController addObject:toWithdraw];
         [_ary_aimViewController addObject:toNewMemberGuide];
         [_ary_aimViewController addObject:toTopUpRecord];
         [_ary_aimViewController addObject:toWithDrawRecord];
         [_ary_aimViewController addObject:toNewNotice];
         [_ary_aimViewController addObject:toAboutUs];
         [_ary_aimViewController addObject:toLogin];
         [_ary_aimViewController addObject:toSet];
     
    }
    
    // Do any additional setup after loading the view.
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
- (void)loadData{
    if (_ar_myCollectionViewCellModel==nil) {
        _ar_myCollectionViewCellModel=[[NSMutableArray alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"collectionView" ofType:@"json"];
        
        NSData *collectionViewData = [[NSData alloc] initWithContentsOfFile:path];
        
        NSArray *collectionViewDic = [NSJSONSerialization JSONObjectWithData:collectionViewData options:0 error:nil];
        for (NSDictionary *dic in collectionViewDic)
        {
            myCollectionViewCellModel *cellModel=[[myCollectionViewCellModel alloc] initWithDic:dic];
            [_ar_myCollectionViewCellModel addObject:cellModel];
        }

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _ar_myCollectionViewCellModel.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((screenWidth-5*2)/3,(screenHeight-self.navigationController.navigationBar.frame.size.height- self.tabBarController.tabBar.frame.size.height-3*5-10*3)/4);
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    myCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    [cell  setValueForMycell:_ar_myCollectionViewCellModel[indexPath.row]];
    return cell;
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==_ary_aimViewController.count) {
        //清空登录信息
        if (g_userID==nil) {
            _altv_prompt = [[UIAlertView alloc] initWithTitle:@"当前未登录!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
            [self.altv_prompt show];
        }else{
            g_userID=nil;
            _altv_prompt = [[UIAlertView alloc] initWithTitle:@"注销成功!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
            [self.altv_prompt show];
        }
    }else{
        [self.navigationController pushViewController:self.ary_aimViewController[indexPath.row] animated:YES];
    }
    return YES;
}
-(void) performDismiss:(NSTimer *)timer
{
    [_altv_prompt dismissWithClickedButtonIndex:0 animated:NO];
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
