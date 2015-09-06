//
//  withdrawTablewViewCell.m
//  Sd
//
//  Created by IOS on 15/8/12.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "withdrawTablewViewCell.h"
#import "addConstraints.h"
#import "withdrawModel.h"
@interface withdrawTablewViewCell()
@property(nonatomic,retain) NSMutableArray * mary_obj;
@end
@implementation withdrawTablewViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubviews];
    }
    return  self;
}

-(void) setSubviews{
    int i=0;
    NSMutableDictionary * mdic_views=[[NSMutableDictionary alloc] init];
    NSMutableArray * mary_constraints=[[NSMutableArray alloc] init];
    if (_mary_obj==nil) {
        _mary_obj=[[NSMutableArray alloc] init];
    }
    for (int i=0; i<6;i++) {
        UILabel * lb_name=[[UILabel alloc] init];
        lb_name.translatesAutoresizingMaskIntoConstraints=NO;
        [self.contentView addSubview:lb_name];
        [_mary_obj addObject:lb_name];
        [mdic_views setObject:_mary_obj[i] forKey:[NSString stringWithFormat:@"obj_%d",i]];
    }
    for (i=0; i<6; i+=2) {
        [mary_constraints addObject:[NSString stringWithFormat:@"V:|-%d-[obj_%d(==20)]",(i/2)*(20+1)+1,i]];
        if (i==0) {
             [mary_constraints addObject:[NSString stringWithFormat:@"H:|-15-[obj_%d(==75)]-[obj_%d]-0-|",i,i+1]];
        }else{
            [mary_constraints addObject:[NSString stringWithFormat:@"H:|-5-[obj_%d(==75)]-[obj_%d]-0-|",i,i+1]];

        }
    }
    addConstraints * constraints=[[addConstraints alloc] init];
    [constraints addMetrics:nil andViews:mdic_views andSuper:self.contentView andConstraints:mary_constraints];
}
-(void) setModel:(withdrawModel *)model{
        //[_mary_obj[0] setText:@"提现时间:"];
        [_mary_obj[1] setText:model.withdrawTime];
        [_mary_obj[2] setText:@"提现金额:"];
        [_mary_obj[3] setText:model.withdrawNumber];
        [_mary_obj[4] setText:@"提现状态:"];
        [_mary_obj[5] setText:model.withdrawStatus];
        for (int i=0; i<_mary_obj.count; i++) {
        if (i%2==0) {
            [_mary_obj[i] setTextColor:Color(121, 120, 121)];
        }else{
            if (i==1) {
                [_mary_obj[i] setTextColor:Color(189, 84, 79)];
            }else{
               [_mary_obj[i] setTextColor:Color(108, 133, 148)];
            }
        }
    }


}
@end
