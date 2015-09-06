//
//  userInfoManage.h
//  Sd
//
//  Created by IOS on 15/8/17.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userInfoManage : NSObject
+(void) saveUserName:(NSString*)userName  psaaword:(NSString*)pwd andstate:(NSString *)state;
+(NSString *)findPasswordByUserName:(NSString *)userName;
+(void) deleteUserName:(NSString *)userName;
+(NSMutableArray *) LoadUserName;
+(NSMutableArray *) userPasswordState;
@end
