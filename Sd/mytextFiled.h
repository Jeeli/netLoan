//
//  mytextFiled.h
//  Sd
//
//  Created by IOS on 15/7/16.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol selectMoreDelegate <NSObject>
-(void) selectMore;
@end
@interface mytextFiled : UIView
@property(nonatomic,assign) id<selectMoreDelegate> selectdelegate;
- (instancetype) initWithImage:(NSString *) img_name andText:(NSString *) text_name andIsSecureText:(BOOL) IsSecureText andPlaceholder:(NSString *) textPlaceholder andWidth:(NSInteger) width andImageWidth:(NSInteger) imagewidth andDisplayBorder:(BOOL) isBorder;
@property(nonatomic,copy) NSString * (^textFiledInfo)();
@property(nonatomic,retain) NSMutableArray * ary_name;
@property(nonatomic,copy) void (^setFiledInfo)(NSString *);
@property(nonatomic,copy) NSString * state;
- (instancetype) getName;
- (void)  addAry_name:(NSString *) name;
-(void) setContent:(NSString *) txtContent;
-(void) setImage:(NSString *)name;
-(void) setimageState:(NSString *) state;
-(void) setcolor;
 @end
