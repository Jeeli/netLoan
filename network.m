//
//  nework.m
//  json
//
//  Created by IOS on 15/8/5.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "network.h"
@implementation network
//ios自带的get请求方式
-(void)getRequestByUrlPath:(NSString *)path andParams:(NSString *)params andCallBack:(networkRequestBlock) networkRequest{
    NSString * newPath;
    newPath=[NSString stringWithFormat:@"%@?%@",path,params];
    //保证URL字符串有效中文转码。
    NSString*  pathStr = [newPath  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:pathStr];
    //加载一个NSURL对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求超时为5秒
    [request setTimeoutInterval:5.0];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //IOS5自带解析类NSJSONSerialization从response中解析出数据
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
            networkRequest(jsonData);
    });
        
    }];
    //开始请求
    [task resume];
}

//把NSDictionary解析成post格式的NSString字符串
+ (NSString *)parseParams:(NSDictionary *)params{
    NSString *keyValueFormat;
    NSMutableString *result = [[NSMutableString alloc] init];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while(key=[keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
    }
    NSString * str_result=[result substringToIndex:result.length-1];
    return str_result;
}


//ios自带的post请求方式
-(void)postRequestByByUrlPath:(NSString *)path andParams:(id)params andCallBack:(networkRequestBlock)networkRequest andRequestType:(requestType) type{
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方法,默认是GET
    [request setHTTPMethod:@"POST"];
    //设置请求超时为5秒
    [request setTimeoutInterval:5.0];
    //检测Foundation对象能否合法转换为JSON对象（字典，数组）
    //NSError * error;
    if ([NSJSONSerialization isValidJSONObject:params]) {
       
        myLog(@"isValidJSONObject");
        //将字典或者数组转化为JSON串
      //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
      //NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
      //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
       NSString *jsonString=[network parseParams:params];
       NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
       myLog(@"network.jsonData=%@",jsonData);
       myLog(@"network.jsonString=%@",jsonString);
       //设置请求体
       [request setHTTPBody:jsonData];
    
    }
    else{
        NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        myLog(@"network.jsonString=%@",params);
    }
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (type==requestType_async) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
                    networkRequest(jsonData);
               });
              
            }
            if (type==requestType_sync) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
                    networkRequest(jsonData);
                });
            }
            
        }];
        //开始请求
        [task resume];
}
@end
