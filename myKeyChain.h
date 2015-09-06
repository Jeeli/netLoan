//
//  myKeyChain.h
//  Sd
//
//  Created by IOS on 15/8/15.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface myKeyChain : NSObject
+ (void) saveUserName:(NSString*)userName userNameService:(NSString*)userNameService
             psaaword:(NSString*)pwd
      psaawordService:(NSString*)pwdService;

+ (void) deleteWithUserNameService:(NSString*)userNameService
                   psaawordService:(NSString*)pwdService;

+ (NSString*) getUserNameWithService:(NSString*)userNameService;

+ (NSString*) getPasswordWithService:(NSString*)pwdService;
// save username and password to keychain
+ (void)save:(NSString *)service data:(id)data;

// take out username and passwore from keychain
+ (id)load:(NSString *)service;

// delete username and password from keychain
+ (void)delete:(NSString *)service;

@end
