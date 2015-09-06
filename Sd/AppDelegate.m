//
//  AppDelegate.m
//  Sd
//
//  Created by IOS on 15/7/13.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "AppDelegate.h"
#import "tbarController.h"
#import "newCharacter.h"
#import "Reachability.h"
@interface AppDelegate (){
  Reachability *reachability;
}
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc] init];
    self.window.frame=[[UIScreen mainScreen] bounds];
    [self.window makeKeyAndVisible];
    
    NSString *key = (NSString *)kCFBundleVersionKey;
     application.statusBarHidden = YES;
    //1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    // 2.从沙盒中取出上次存储的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([version isEqualToString:saveVersion]) { // 不是第一次使用这个版本
     // 显示状态栏
          self.window.rootViewController=[[tbarController alloc] init];
     } else { // 版本号不一样：第一次使用新版本
     // 将新版本号写入沙盒
     [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
     [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 显示版本新特性界面
    self.window.rootViewController = [[newCharacter alloc] init];
    }
    
    //[self startNotificationNetwork];
    return YES;
}

/*- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if(status ==NotReachable) {
        UIAlertView*alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                          message:@"网络连接失败,请检查网络"
                                                         delegate:nil
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil];
        [alertView show];
    }else{
        NSLog(@"connect with the internet successfully");
    }
    
}


// 连接改变
- (void) reachabilityChanged: (NSNotification* )note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}


-(void)startNotificationNetwork{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    reachability=[Reachability reachabilityWithHostName:@"www.baidu.com"];
    [reachability startNotifier];
}*/
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
