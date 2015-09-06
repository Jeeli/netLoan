//
//  text-buttonH-buttonH.h
//  Sd
//
//  Created by IOS on 15/7/25.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface text_buttonH_buttonH : UIView

-(instancetype) initWithText:(NSString *) text andFirstBtText:(NSString *) firstText andFirstBtImage:(NSString *) firstImage andSecondBtText:(NSString *) secondText andSecondImage:(NSString *) secondImage;
-(void) updateText:(NSString *) text;
@property(nonatomic,copy) void (^goMorePage)();
@end
