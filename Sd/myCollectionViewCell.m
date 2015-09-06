//
//  myCollectionViewCell.m
//  Sd
//
//  Created by IOS on 15/7/15.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "myCollectionViewCell.h"
#import "addConstraints.h"
#import "myCollectionViewCellModel.h"
@interface myCollectionViewCell()
@property(nonatomic,assign) UIImageView * img_image;
@property(nonatomic,assign) UILabel *lb_text;
@end
@implementation myCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self makeMycollectionViewCell];
    }
    return self;
}

- (void) makeMycollectionViewCell{
    UIImageView * img_image=[[UIImageView alloc] init];
    self.img_image=img_image;
    self.img_image.translatesAutoresizingMaskIntoConstraints=NO;
    [self.contentView addSubview:self.img_image];
    self.img_image.contentMode=UIViewContentModeCenter;

    UILabel * lb_text=[[UILabel alloc] init];
    self.lb_text=lb_text;
    self.lb_text.translatesAutoresizingMaskIntoConstraints=NO;
    [self.contentView addSubview:self.lb_text];
    [self.lb_text setTextColor:[UIColor redColor]];
    [self.lb_text setTextAlignment:NSTextAlignmentCenter];
    [self.lb_text setFont:[UIFont systemFontOfSize:14]];
    [self.lb_text setTextColor:[UIColor darkTextColor]];
    
    CGFloat _img_image_height=self.frame.size.height/3*2;
    //设置垂直方向 控件之间的间隔
    CGFloat v_margin=0.0f;
    
    CGFloat _lb_text_height=self.frame.size.height/3-v_margin;
    NSDictionary *metrcs=@{@"image_height":[NSNumber numberWithFloat:_img_image_height],@"text_height":[NSNumber numberWithFloat:_lb_text_height],@"lb_text_topMargin":[NSNumber numberWithFloat:_img_image_height+v_margin]};
    NSDictionary *viewsDic=@{@"img_image":_img_image,@"lb_text":_lb_text};
    NSArray *array=@[
                     @"H:|-0-[img_image]-0-|",
                     @"H:|-0-[lb_text]-0-|",
                     @"V:|-0-[img_image(==image_height)]",
                     @"V:|-lb_text_topMargin-[lb_text(==text_height)]"];
    //添加约束
    addConstraints *addconstraints=[[addConstraints alloc] init];
    [addconstraints addMetrics:metrcs andViews:viewsDic andSuper:self.contentView andConstraints:array];

}
- (void) setValueForMycell:(myCollectionViewCellModel *) cellModel{
     self.img_image.image=[UIImage imageNamed:cellModel.imageName];
     self.lb_text.text=cellModel.text;
}
@end
