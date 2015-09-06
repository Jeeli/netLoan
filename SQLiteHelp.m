//
//  SQLiteHelp.m
//  block
//
//  Created by IOS on 15/7/31.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "SQLiteHelp.h"
#import <sqlite3.h>
@implementation SQLiteHelp

-(void) createDataBaseWithDBname:(NSString *)dataBaseName andCreateTableWithSQstring:(NSString *)SQstring, ...{
   //获取沙盒中的数据库名
   NSString *dataBaseFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:dataBaseName];
   //NSLog(@"%@",dataBaseFile);
    sqlite3 *_db;
    int result = sqlite3_open(dataBaseFile.UTF8String, &_db);
    if (result == SQLITE_OK) {
        char * ERROR;
        NSString * str_sqlCreateTable;
        //指向变参的指针
        va_list list;
        //使用第一个参数来初使化list指针
        va_start(list, SQstring);
        if (sqlite3_exec(_db, [SQstring UTF8String], NULL, NULL, &ERROR)!=SQLITE_OK){
            sqlite3_close(_db);
            NSAssert(0, @"ceate table faild!");
            NSLog(@"表创建失败");
        }
        //返回可变参数，va_arg第二个参数为可变参数类型，如果有多个可变参数，依次调用可获取各个参数
        while ((str_sqlCreateTable=va_arg(list, NSString*))) {
           if (sqlite3_exec(_db, [SQstring UTF8String], NULL, NULL, &ERROR)!=SQLITE_OK){
                sqlite3_close(_db);
                NSAssert(0, @"ceate table faild!");
                NSLog(@"表创建失败");
            }
        //结束可变参数的获取
            va_end(list);
        }
    }else{
               NSLog(@"打开数据库失败");
        }
      sqlite3_close(_db);
}

-(NSDictionary *)QueryDataWithSQstring:(NSString *)SQstring{
    
    NSDictionary * dataDic=[[NSDictionary alloc] init];
    return dataDic;
}
    
/*-(void) QueryData:(NSString *)dataBaseName{
    
    //获取沙盒中的数据库名
    
    NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString * documents=[paths objectAtIndex:0];
    NSString * dataBaseFile=[documents stringByAppendingPathComponent:dataBaseName];
    sqlite3 *_db;
    int result = sqlite3_open(dataBaseFile.UTF8String, &_db);
    if (result == SQLITE_OK) {
        //创建表
        //NSString *ceateSQLtable = @"CREATE TABLE IF NOT EXISTS tb_addressbook( name TEXT, mobilephone TEXT, qq TEXT, flag TEXT)";
        
        char * ERROR;
        
        if (sqlite3_exec(_db, [ceateSQLtable UTF8String], NULL, NULL, &ERROR)!=SQLITE_OK){
            sqlite3_close(_db);
            NSAssert(0, @"ceate tb_addressbook faild!");
            NSLog(@"tb_addressbook表创建失败");
        }
        
        //查询
        NSString *sql = @"SELECT * from tb_addressbook";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_db, [sql UTF8String], -1, &statement,NULL)== SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                
                NSString *name=[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *mobilephone=[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *qq=[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement,2)];
                NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:name,@"name",mobilephone,@"mobilephone",qq,@"qq", nil];
                info *fo=[[info alloc] initWithDic:dic];
                [self.dataArray addObject:fo];
            }
            
            
        }
        
        
        sqlite3_finalize(statement);
    }
    else{
        NSLog(@"打开数据库失败");
    }
    sqlite3_close(_db);*/
@end

