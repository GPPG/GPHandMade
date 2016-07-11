//
//  GPHandDataTool.m
//  GPHandMade
//
//  Created by dandan on 16/7/9.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHandDataTool.h"
#import "FMDatabase.h"

@implementation GPHandDataTool
/** 数据库实例 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"handMore.sqlite"];
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    NSLog(@"%@",filename);
    // 3.打开数据库
    if ([_db open]) {
        // 4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_more (id integer PRIMARY KEY AUTOINCREMENT, moreName blob NOT NULL,moreStr blob NOT NULL,Remark text NOT NULL)"];
       BOOL zero = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_zero (id integer PRIMARY KEY AUTOINCREMENT, moreName blob NOT NULL,moreStr blob NOT NULL,Remark text NOT NULL)"];
        if (result && zero) {
            NSLog(@"成功创表");
        } else {
            NSLog(@"创表失败");
        }
    }
}
+ (void)saveItemArray:(NSMutableArray *)itemArray remark:(NSString *)remark type:(NSMutableArray *)strArray
{
    NSData *nameData = [NSKeyedArchiver archivedDataWithRootObject:itemArray];
    NSData *strData = [NSKeyedArchiver archivedDataWithRootObject:strArray];
    
    [_db executeUpdateWithFormat:@"INSERT INTO t_more (moreName,moreStr,Remark) VALUES (%@, %@,%@)",nameData,strData,remark];
}
+ (void)saveZeroArray:(NSMutableArray *)itemArray remark:(NSString *)remark type:(NSMutableArray *)strArray
{
    NSData *nameData = [NSKeyedArchiver archivedDataWithRootObject:itemArray];
    NSData *strData = [NSKeyedArchiver archivedDataWithRootObject:strArray];
    
    [_db executeUpdateWithFormat:@"INSERT INTO t_zero (moreName,moreStr,Remark) VALUES (%@, %@,%@)",nameData,strData,remark];
}

+ (BOOL)updateItemArray:(NSArray *)moreNameArray strArray:(NSArray *)moreStrArray remark:(NSString *)remark
{
    NSData *nameData = [NSKeyedArchiver archivedDataWithRootObject:moreNameArray];
    NSData *strData = [NSKeyedArchiver archivedDataWithRootObject:moreStrArray];

    BOOL isSuccess = [_db executeUpdateWithFormat:@"UPDATE t_more SET moreName = %@,moreStr = %@ WHERE Remark = %@", nameData,strData,remark];
    
    if (isSuccess) {
        NSLog(@"更新成功");
    }else{
        NSLog(@"更新失败%@",_db.lastErrorMessage);
    }
    return isSuccess;
}
+ (BOOL)updateZeroArray:(NSArray *)moreNameArray strArray:(NSArray *)moreStrArray remark:(NSString *)remark
{
    NSData *nameData = [NSKeyedArchiver archivedDataWithRootObject:moreNameArray];
    NSData *strData = [NSKeyedArchiver archivedDataWithRootObject:moreStrArray];
    
    BOOL isSuccess = [_db executeUpdateWithFormat:@"UPDATE t_zero SET moreName = %@,moreStr = %@ WHERE Remark = %@", nameData,strData,remark];
    
    if (isSuccess) {
        NSLog(@"更新成功");
    }else{
        NSLog(@"更新失败%@",_db.lastErrorMessage);
    }
    return isSuccess;
}
+ (NSMutableArray *)list:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_more"];
    
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *list = [NSMutableArray array];
    while (set.next) {
        NSData *item = [set objectForColumnName:name];
        list = [NSKeyedUnarchiver unarchiveObjectWithData:item];
    }
    return list;
}
+ (NSMutableArray *)zeroList:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_zero"];
    
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *list = [NSMutableArray array];
    while (set.next) {
        NSData *item = [set objectForColumnName:name];
        list = [NSKeyedUnarchiver unarchiveObjectWithData:item];
    }
    return list;
}
@end
