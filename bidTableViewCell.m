//
//  myTableViewCell.m
//  Sd
//
//  Created by IOS on 15/7/21.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "bidTableViewCell.h"
#import "myUILabel.h"
#import "progressBar.h"
#import "addConstraints.h"
#import "text-text.h"
#import "bidModel.h"
#import "WMCircleProgressView.h"
@interface bidTableViewCell()
@property(nonatomic,weak) UILabel * lb_name;
@property(nonatomic,weak) progressBar * pgb_pressgress;
@property(nonatomic,weak) text_text * hvtxt_timeLimit;
@property(nonatomic,weak) progressBar * bidprogress; //标的状态条
@property(nonatomic,weak) text_text * hvtxt_borrowMoney;
@property(nonatomic,weak) UILabel * lb_state;
@property(nonatomic,weak) text_text * hvtxt_rate;
@end
@implementation bidTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubViews];
    }
    return self;
}

-(void) setSubViews{
    myUILabel * lb_name=[[myUILabel alloc] init];
    lb_name.translatesAutoresizingMaskIntoConstraints=NO;
    lb_name.text=@"";
    [lb_name setTextColor:[UIColor blackColor]];
    _lb_name=lb_name;
    /**
     *  分割线
     */
    UIView * v_separator =[[UIView alloc] init];
    v_separator.backgroundColor=[UIColor redColor];
    v_separator.translatesAutoresizingMaskIntoConstraints=NO;
    v_separator.alpha=0.3;
    
    text_text * hvtxt_rate=[[text_text alloc] initWithNumber:@"" andName:@" %" andTxt:@"年化"];
    hvtxt_rate.translatesAutoresizingMaskIntoConstraints=NO;
    _hvtxt_rate=hvtxt_rate;
    
    text_text * hvtxt_timeLimit=[[text_text alloc] initWithNumber:@"" andName:@"个月" andTxt:@"期限"];
    _hvtxt_timeLimit=hvtxt_timeLimit;
    hvtxt_timeLimit.translatesAutoresizingMaskIntoConstraints=NO;
    
    text_text * hvtxt_borrowMoney=[[text_text alloc] initWithNumber:@"10" andName:nil andTxt:@"借款"];
    _hvtxt_borrowMoney=hvtxt_borrowMoney;
    hvtxt_borrowMoney.translatesAutoresizingMaskIntoConstraints=NO;
    
    UILabel * lb_state=[[UILabel alloc] init];
    lb_state.translatesAutoresizingMaskIntoConstraints=NO;
    [self.contentView addSubview:lb_state];
    /*_lb_state=lb_state;
    _lb_state.userInteractionEnabled=YES;
    [lb_state setTextAlignment:NSTextAlignmentCenter];
    [lb_state setTextColor:[UIColor redColor]];*/
    
    progressBar * bidprogress=[[progressBar alloc] init];
    _bidprogress=bidprogress;
    bidprogress.flag=@"Y";
    bidprogress.translatesAutoresizingMaskIntoConstraints=NO;
    [self.contentView addSubview:bidprogress];
    
    [self.contentView addSubview:lb_name];
    [self.contentView addSubview:hvtxt_rate];
    [self.contentView addSubview:hvtxt_timeLimit];
    [self.contentView addSubview:hvtxt_borrowMoney];
    //[self.contentView addSubview:v_separator];
    
    NSDictionary *dic_views=@{@"lb_name":lb_name,@"hvtxt_rate":hvtxt_rate,@"hvtxt_timeLimit":hvtxt_timeLimit,@"hvtxt_borrowMoney":hvtxt_borrowMoney,@"v_separator":v_separator,@"lb_state":lb_state,@"bidprogress":bidprogress};
    NSArray * ary_constraints=@[
                                @"H:|-[lb_name]-|",
                                @"V:|-3-[lb_name(==30)]",
                                @"H:|-20-[bidprogress(==60)]-3-[hvtxt_rate(==50)]-3-[hvtxt_timeLimit(==50)]-30-[hvtxt_borrowMoney]-0-|",
                                @"V:|-40-[bidprogress(==60)]"
                                ];
   /* @"H:|-0-[v_separator]-0-|",
    @"V:|-33-[v_separator(==0.3)]"
    */
    
    addConstraints *constraints=[[addConstraints alloc] init];
    [constraints addMetrics:nil andViews:dic_views andSuper:self.contentView andConstraints:ary_constraints];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setBidmodel:(bidModel *)bidmodel{
    _bidmodel=bidmodel;
    _lb_name.text=_bidmodel.name;
    [_hvtxt_rate setNumber:[NSString stringWithFormat:@"%.0f",[_bidmodel.scale floatValue]]];
    /*[UIView animateWithDuration:2.0 animations:^{
        _pgb_pressgress.percent=[_bidmodel.scale floatValue]/100;

    } completion:^(BOOL finished) {}];*/
    [_hvtxt_borrowMoney setNumber:_bidmodel.account];
    [_hvtxt_timeLimit setNumber:bidmodel.time_limit];
    [_bidprogress setType:@"bid"];
    if ([_bidmodel.bidscale floatValue]/100==1) {
        [_bidprogress setState:@"finish"];
    }else{
        [_bidprogress setState:@"Nofinish"];
    }
     _bidprogress.percent=[_bidmodel.bidscale floatValue]/100;
}

@end
