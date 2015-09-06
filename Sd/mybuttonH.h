//
//  mybuttonH.h
//  Sd
//
//  Created by IOS on 15/7/17.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mybuttonH : UIButton
@property(nonatomic,retain) NSMutableArray * ary_name;
- (instancetype) getName;
- (void)  addAry_name:(NSString *) name;
@end
