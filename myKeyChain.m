//
//  myKeyChain.m
//  Sd
//
//  Created by IOS on 15/8/15.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "myKeyChain.h"
#import <Security/Security.h>
@implementation myKeyChain

+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge id)kSecAttrService,
            service, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            nil];
}

+ (void) saveUserName:(NSString*)userName
      userNameService:(NSString*)userNameService
             psaaword:(NSString*)pwd
      psaawordService:(NSString*)pwdService
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:userName] forKey:(__bridge id)kSecValueData];
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
    
    keychainQuery = [self getKeyChainQuery:pwdService];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:pwd] forKey:(__bridge id)kSecValueData];
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+ (void) deleteWithUserNameService:(NSString*)userNameService
                   psaawordService:(NSString*)pwdService
{
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    
    keychainQuery = [self getKeyChainQuery:pwdService];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

+ (NSString*) getUserNameWithService:(NSString*)userNameService
{
    NSString* ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:userNameService];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr)
    {
        @try
        {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        }
        @catch (NSException *e)
        {
            NSLog(@"Unarchive of %@ failed: %@", userNameService, e);
        }
        @finally
        {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (NSString*) getPasswordWithService:(NSString*)pwdService
{
    NSString* ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:pwdService];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr)
    {
        @try
        {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        }
        @catch (NSException *e)
        {
            NSLog(@"Unarchive of %@ failed: %@", pwdService, e);
        }
        @finally
        {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

/**
*该类需要工作在mrc模式下，acr的项目按照如下步骤操作
*选中工程->TARGETS->相应的target然后选中右侧的“Build Phases”，向下就找到“Compile Sources”了。然后在相应的文件后面添加:-fno-objc-arc参数
*
**/



+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge id)kSecAttrService,
            service, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            nil];
}
#pragma mark 写入
+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}
#pragma mark 读取
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}
#pragma mark 删除
+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}
@end

