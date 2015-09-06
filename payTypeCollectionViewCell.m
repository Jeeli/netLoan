//
//  payTypeCollectionViewCell.m
//  Sd
//
//  Created by IOS on 15/8/4.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "payTypeCollectionViewCell.h"
#import "mybuttonH.h"
@interface payTypeCollectionViewCell()
@end
@implementation payTypeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        mybuttonH * btn_pay=[[mybuttonH alloc] init];
        btn_pay.frame=self.contentView.bounds;
        [self.contentView addSubview:btn_pay];
        [btn_pay setImage:[UIImage imageNamed:@"usercenter"] forState:UIControlStateNormal];
        [btn_pay setTitle:@"国付宝" forState:UIControlStateNormal];
        [btn_pay setBackgroundColor:[UIColor greenColor]];
        //[btn_pay addTarget:self action:@selector(goBack:) forControlEvents:
         //UIControlEventTouchUpInside];
        [btn_pay setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn_pay.userInteractionEnabled=NO;
    }
    return  self;
}
@end
