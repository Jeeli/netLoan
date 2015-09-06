//
//  newCharacter.m
//  Sd
//
//  Created by IOS on 15/7/16.
//  Copyright (c) 2015年 IOS. All rights reserved.
//
/**
 *  新特性
 *
 */
#import "newCharacter.h"
#import "addConstraints.h"
#import "tbarController.h"
@interface newCharacter ()
@property(nonatomic,retain) NSArray *array_image;
@property(nonatomic,weak) UIPageControl *pgct;
@property(nonatomic,weak) UIScrollView * scv_image;
@end

@implementation newCharacter

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.array_image==nil) {
        self.array_image=[[NSArray alloc] initWithObjects:@"a",@"b",@"c", nil];
    }
    // Do any additional setup after loading the view.
    UIScrollView *scv_newCharacter=[[UIScrollView alloc] init];
    UIPageControl *pgct=[[UIPageControl alloc] init];
    self.pgct=pgct;
    self.scv_image=scv_newCharacter;
    
    [pgct addTarget:self action:@selector(selectPage:) forControlEvents:UIControlEventTouchUpInside];
    //自动滚动到边界
    scv_newCharacter.pagingEnabled = YES;
    
    scv_newCharacter.backgroundColor=[UIColor darkTextColor];
    [self.view addSubview:scv_newCharacter];
    scv_newCharacter.frame=self.view.bounds;
    //隐藏水平方向指示条
    scv_newCharacter.showsHorizontalScrollIndicator=NO;
    
    //去掉弹簧效果
    scv_newCharacter.bounces=NO;
    
    scv_newCharacter.contentSize=CGSizeMake(self.view.frame.size.width*self.array_image.count, 0);
    for (int i=0; i<self.array_image.count; i++) {
        UIImageView *img_image=[[UIImageView alloc] init];
        img_image.frame=CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        img_image.image=[UIImage imageNamed:self.array_image[i]];
        if (i==(self.array_image.count-1)) {
            UIButton *btn_go=[[UIButton alloc] init];
            btn_go.translatesAutoresizingMaskIntoConstraints=NO;
            [img_image addSubview:btn_go];
            btn_go.backgroundColor=[UIColor clearColor];
            NSDictionary *metrcs=@{@"btn_go_height":@40,@"margin":[NSNumber numberWithFloat:self.view.frame.size.height/9]};
            NSDictionary *viewsDic=@{@"btn_go":btn_go};
            NSArray *array=@[
                             @"H:|-80-[btn_go]-80-|",
                             @"V:[btn_go(==btn_go_height)]-margin-|"];
            //添加约束
            addConstraints *addconstraints=[[addConstraints alloc] init];
            [addconstraints addMetrics:metrcs andViews:viewsDic andSuper:img_image  andConstraints:array];
            img_image.userInteractionEnabled=YES;
            [btn_go addTarget:self action:@selector(goHome:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        [scv_newCharacter addSubview:img_image];

    }
    //pgct.backgroundColor=[UIColor redColor];
    [self.view addSubview:pgct];
    pgct.numberOfPages=self.array_image.count;
    pgct.translatesAutoresizingMaskIntoConstraints=NO;
    NSDictionary *metrcs=@{@"pgct_height":@30};
    NSDictionary *viewsDic=@{@"pgct":pgct};
    NSArray *array=@[
                     @"H:|-0-[pgct]-0-|",
                     @"V:[pgct(==pgct_height)]-10-|"];
    //添加约束
    addConstraints *addconstraints=[[addConstraints alloc] init];
    [addconstraints addMetrics:metrcs andViews:viewsDic andSuper:self.view andConstraints:array];
    scv_newCharacter.delegate=(id)self;
}

-(void) selectPage:(id)sender{
    NSInteger page = self.pgct.currentPage;//获取当前pagecontroll的值
    [self.scv_image setContentOffset:CGPointMake(self.view.frame.size.width*page, 0)];
}
-(void) goHome:(UIButton *)sender{
    [self presentViewController:[[tbarController alloc] init] animated:YES completion:nil];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat x = scrollView.contentOffset.x;
    self.pgct.currentPage=(int)roundf(x/self.view.frame.size.width);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏当前页的状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
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
