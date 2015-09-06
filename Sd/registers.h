//
//  register.h
//  Sd
//
//  Created by IOS on 15/7/18.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol setGenderDelegate <NSObject>
-(void) setGender:(NSString *) txtGender;
@end

@interface registers : UIViewController
@property(nonatomic,assign) id<setGenderDelegate> registerdelegate;


@end
