//
//  myUIButton.h
//  Sd
//
//  Created by IOS on 15/7/23.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myUIButton : UIButton
@property(nonatomic,retain) NSMutableArray * ary_name;
- (instancetype) getName;
- (void)  addAry_name:(NSString *) name;
@end
