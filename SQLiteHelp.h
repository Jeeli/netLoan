//
//  SQLiteHelp.h
//  block
//
//  Created by IOS on 15/7/31.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLiteHelp : NSObject
-(void) createDataBaseWithDBname:(NSString *)dataBaseName andCreateTableWithSQstring:(NSString *) SQstring,...;
-(NSArray *) QueryDataWithSQstring:(NSString *) SQstring;
@end
