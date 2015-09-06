//
//  text-text-text-text.m
//  Sd
//
//  Created by IOS on 15/8/3.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "text-text-text-text.h"
#import "addConstraints.h"
#import "myUILabel.h"
@interface text_text_text_text()
@property(nonatomic,retain) NSMutableArray * ary_obj;
@end
@implementation text_text_text_text

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setDataWithStr1:(NSString *)str1 andStr2:(NSString *)str2{
    myUILabel * lb=_ary_obj[1];
    lb.text=str1;
    lb=_ary_obj[3];
    lb.text=str2;
}

- (instancetype)initWithAry_name:(NSArray *)ary_name andFlag:(NSString *)flag{
    _ary_obj=[[NSMutableArray alloc] init];
    NSMutableArray * ary_Constraints=[[NSMutableArray alloc] init];
    NSMutableDictionary * dic_views=[[NSMutableDictionary alloc] init];
    if (self=[super init]) {
        for (int i=0; i<4; i++) {
            myUILabel * lb_name =[[myUILabel alloc] init];
            lb_name.backgroundColor=[UIColor grayColor];
            lb_name.translatesAutoresizingMaskIntoConstraints=NO;
            if (i%2==0) {}else{
                [lb_name setTextColor:Color(189, 84, 79)];
            }
            if ([flag isEqual:@"1"]) {
                lb_name.backgroundColor=Color(237, 237, 237);
            }else{
                lb_name.backgroundColor=Color(255, 255, 255);
            }

            [self addSubview:lb_name];
            lb_name.text=ary_name[i];
            [_ary_obj addObject:lb_name];
            [lb_name setFont:[UIFont systemFontOfSize:14]];
            lb_name.textAlignment=NSTextAlignmentCenter;

        }
        CGFloat width=([[UIScreen mainScreen] bounds].size.width-140)/2;
        NSDictionary * dic_metrics=@{@"width":[NSNumber numberWithFloat:width]};
        for (int i=0; i<self.subviews.count; i++) {
            [dic_views setObject:_ary_obj[i] forKey:[NSString stringWithFormat:@"name_%d",i+1]];
        }
        [ary_Constraints addObject:@"H:|-0-[name_1(==70)]-0.5-[name_2(==width)]-0.5-[name_3(==70)]-0.5-[name_4(==width)]"];
        [ary_Constraints addObject:@"V:|-0-[name_1(==30)]"];
        addConstraints * addcontraints=[[addConstraints alloc] init];
        [addcontraints addMetrics:dic_metrics andViews:dic_views andSuper:self andConstraints:ary_Constraints];
    }
    return self;
}
@end
