//
//  HV:text-text.m
//  Sd
//
//  Created by IOS on 15/7/28.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "text-text.h"
#import "myUILabel.h"
#import "addConstraints.h"
@interface text_text()
@property(nonatomic,weak) myUILabel * lb_name;
@end
@implementation text_text

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithNumber:(NSString *)number andName:(NSString *)name andTxt:(NSString *)txt{
    if (self=[super init]) {
        myUILabel * lb_number=[[myUILabel alloc] init];
        lb_number.text=number;
        [lb_number setTextColor:[UIColor redColor]];
        //lb_number.backgroundColor=[UIColor blueColor];
        lb_number.translatesAutoresizingMaskIntoConstraints=NO;
        [lb_number setTextAlignment:NSTextAlignmentRight];
        
              
        myUILabel *lb_name=[[myUILabel alloc] init];
        lb_name.text=name;
        [lb_name setTextAlignment:NSTextAlignmentLeft];
        //[lb_name setFont:[UIFont systemFontOfSize:10.0]];
        [lb_name setTextColor:[UIColor blackColor]];
        lb_name.translatesAutoresizingMaskIntoConstraints=NO;
        _lb_name=lb_number;
        
        myUILabel *lb_txt=[[myUILabel alloc] init];
        lb_txt.text=txt;
        [lb_txt setTextColor:[UIColor blackColor]];
        [lb_txt setTextAlignment:NSTextAlignmentCenter];
        //[lb_txt setBackgroundColor:[UIColor blueColor]];
        lb_txt.translatesAutoresizingMaskIntoConstraints=NO;
        
        [self addSubview:lb_number];
        [self addSubview:lb_name];
        [self addSubview:lb_txt];
        NSDictionary *dic_views=@{@"lb_name":lb_name,@"lb_number":lb_number,@"lb_txt":lb_txt};
        NSMutableArray * ary_constraints=[[NSMutableArray alloc] init];
        [ary_constraints addObject:@"V:|-3-[lb_name(==30)]"];
        [ary_constraints addObject:@"H:|-[lb_txt(==80)]"];
        [ary_constraints addObject:@"V:|-34-[lb_txt(==30)]"];


         if (name!=nil) {
            [ary_constraints addObject:@"H:|-[lb_number(==40)]-0-[lb_name(==40)]"];
        }
        else{
            [ary_constraints addObject:@"H:|-[lb_number(==80)]-0-[lb_name(==0)]"];
            lb_number.textAlignment=NSTextAlignmentCenter;
        }
        addConstraints *constraints=[[addConstraints alloc] init];
        [constraints addMetrics:nil andViews:dic_views andSuper:self andConstraints:ary_constraints];
    }
    return  self;
}
- (void)setNumber:(NSString *)number{
    _lb_name.text=number;
}
@end
