//
//  nework.h
//  json
//
//  Created by IOS on 15/8/5.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface network : NSObject
-(void)getRequestByUrlPath:(NSString *)path andParams:(NSString *)params andCallBack:(networkRequestBlock) networkRequest;
-(void)postRequestByByUrlPath:(NSString *)path andParams:(id)params andCallBack:(networkRequestBlock)networkRequest  andRequestType:(requestType) type;
+ (NSString *)parseParams:(NSDictionary *)params;
@end
