//
//  userInfoManage.m
//  Sd
//
//  Created by IOS on 15/8/17.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "userInfoManage.h"
#import "myKeyChain.h"
@implementation userInfoManage

+(void) saveUserName:(NSString*)userName  psaaword:(NSString*)pwd andstate:(NSString *) state{
    int findFlag=0;
    NSMutableDictionary *readUsernamePassword = (NSMutableDictionary *)[myKeyChain load:KEY_USERNAME_PASSWORD];
    if (readUsernamePassword==nil) {
        NSMutableArray * userNames=[[NSMutableArray alloc] init];
        NSMutableArray  * passwords=[[NSMutableArray alloc] init];
        NSMutableArray  * passwordstates=[[NSMutableArray alloc] init];
        [userNames addObject:userName];
        [passwords addObject:pwd];
        [passwordstates addObject:state];
        NSMutableDictionary *userNamePasswordKVPairs = [NSMutableDictionary dictionary];
        [userNamePasswordKVPairs setObject:userNames forKey:KEY_USERNAME];
        [userNamePasswordKVPairs setObject:passwords forKey:KEY_PASSWORD];
        [userNamePasswordKVPairs setObject:passwordstates forKey:KEY_PASSWORDSTATE];
        [myKeyChain save:KEY_USERNAME_PASSWORD data:userNamePasswordKVPairs];


    }else{
        NSMutableArray *userNames=[readUsernamePassword objectForKey:KEY_USERNAME];
        NSMutableArray *passwords = [readUsernamePassword objectForKey:KEY_PASSWORD];
        NSMutableArray *passwordstates=[readUsernamePassword objectForKey:KEY_PASSWORDSTATE];
        for (int i=0; i<userNames.count; i++) {
            if ([userNames[i] isEqual:userName]) {
                [passwords replaceObjectAtIndex:i withObject:pwd];
                [passwordstates replaceObjectAtIndex:i withObject:state];
                findFlag=1;
                break;
            }
        }
        if (findFlag==0) {
            [userNames addObject:userName];
            [passwords addObject:pwd];
            [passwordstates addObject:state];
        }
        NSMutableDictionary *userNamePasswordKVPairs = [NSMutableDictionary dictionary];
        [userNamePasswordKVPairs setObject:userNames forKey:KEY_USERNAME];
        [userNamePasswordKVPairs setObject:passwords forKey:KEY_PASSWORD];
        [userNamePasswordKVPairs setObject:passwordstates forKey:KEY_PASSWORDSTATE];
        [myKeyChain save:KEY_USERNAME_PASSWORD data:userNamePasswordKVPairs];

    }
}

+(NSString *)findPasswordByUserName:(NSString *)userName{
    NSMutableDictionary *readUsernamePassword = (NSMutableDictionary *)[myKeyChain load:KEY_USERNAME_PASSWORD];
    NSMutableArray *userNames = [readUsernamePassword objectForKey:KEY_USERNAME];
    NSMutableArray *passwords = [readUsernamePassword objectForKey:KEY_PASSWORD];
    for (int i=0; i<userNames.count; i++) {
        if ([userNames[i] isEqual:userName]) {
            return passwords[i];
       }
    }
    return @"find";
}

+(void) deleteUserName:(NSString *)userName{
    //[keyChain delete:KEY_USERNAME_PASSWORD];
    NSMutableDictionary *readUsernamePassword = (NSMutableDictionary *)[myKeyChain load:KEY_USERNAME_PASSWORD];
    NSMutableArray *userNames = [readUsernamePassword objectForKey:KEY_USERNAME];
    NSMutableArray *passwords = [readUsernamePassword objectForKey:KEY_PASSWORD];
    NSMutableArray *passwordstates=[readUsernamePassword objectForKey:KEY_PASSWORDSTATE];

    for (int i=0; i<userNames.count; i++) {
        if ([userNames[i] isEqual:userName]) {
            [userNames removeObjectAtIndex:i];
            [passwords removeObjectAtIndex:i];
            [passwordstates removeObjectAtIndex:i];
        }
    }
    NSMutableDictionary *userNamePasswordKVPairs = [NSMutableDictionary dictionary];
    [userNamePasswordKVPairs setObject:userNames forKey:KEY_USERNAME];
    [userNamePasswordKVPairs setObject:passwords forKey:KEY_PASSWORD];
    [userNamePasswordKVPairs setObject:passwordstates forKey:KEY_PASSWORDSTATE];
    [myKeyChain save:KEY_USERNAME_PASSWORD data:userNamePasswordKVPairs];
}
+ (NSMutableArray *)LoadUserName{
    NSMutableDictionary *readUsernamePassword = (NSMutableDictionary *)[myKeyChain load:KEY_USERNAME_PASSWORD];
    NSMutableArray *userNames = [readUsernamePassword objectForKey:KEY_USERNAME];
    return userNames;

}
+ (NSMutableArray *)userPasswordState{
    NSMutableDictionary *readUsernamePassword = (NSMutableDictionary *)[myKeyChain load:KEY_USERNAME_PASSWORD];
    NSMutableArray *passwordState = [readUsernamePassword objectForKey:KEY_PASSWORDSTATE];
    return passwordState;
}
@end
