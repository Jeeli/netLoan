//
//  topUpRecordTableCell.m
//  Sd
//
//  Created by IOS on 15/8/11.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "topUpRecordTableViewCell.h"
#import "addConstraints.h"
#import "topUpRecordModel.h"
@interface topUpRecordTableViewCell()
@property(nonatomic,retain) NSMutableArray * mary_obj;
@end
@implementation topUpRecordTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (_mary_obj==nil) {
            _mary_obj=[[NSMutableArray alloc] init];
        }
        [self setSubviews];
    }
    return  self;
}

-(void) setSubviews{
    NSMutableDictionary * dic_views=[[NSMutableDictionary alloc] init];
    NSMutableArray * mary_constraints=[[NSMutableArray alloc] init];
    int i=0;
    for (i=0; i<8;i++) {
        UILabel * lb_name=[[UILabel alloc] init];
        lb_name.translatesAutoresizingMaskIntoConstraints=NO;
        [self.contentView addSubview:lb_name];
        [_mary_obj addObject:lb_name];
    }
    
    for (i=0; i<_mary_obj.count; i++) {
        [dic_views setObject:_mary_obj[i] forKey:[NSString stringWithFormat:@"obj_%d",i]];
    }
    
    for (i=0; i<8; i+=2) {
        [mary_constraints addObject:[NSString stringWithFormat:@"V:|-%d-[obj_%d(==20)]",(i/2)*(20+1)+1,i]];
        if (i==0) {
            [mary_constraints addObject:[NSString stringWithFormat:@"H:|-15-[obj_%d(==75)]-[obj_%d]-0-|",i,i+1]];
        }else{
             [mary_constraints addObject:[NSString stringWithFormat:@"H:|-5-[obj_%d(==73)]-[obj_%d]-0-|",i,i+1]];
        }
    }
    addConstraints * constraints=[[addConstraints alloc] init];
    [constraints addMetrics:nil andViews:dic_views andSuper:self.contentView andConstraints:mary_constraints];
}
-(void) setModel:(topUpRecordModel *)model{
    //[_mary_obj[0] setText:@"充值时间:"];
    [_mary_obj[1] setText:model.topUpTime];
    [_mary_obj[2] setText:@"充值方式:"];
    [_mary_obj[3] setText:model.topUpType];
    [_mary_obj[4] setText:@"充值状态:"];
    [_mary_obj[5] setText:model.topUpStatus];
    [_mary_obj[6] setText:@"充值金额:"];
    [_mary_obj[7] setText:model.topUpNumber];
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
