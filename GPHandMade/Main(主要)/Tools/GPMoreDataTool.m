
//
//  GPMoreDataTool.m
//  GPHandMade
//
//  Created by dandan on 16/7/8.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPMoreDataTool.h"
#import "FMDatabase.h"

@implementation GPMoreDataTool
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
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_more_one (id integer PRIMARY KEY AUTOINCREMENT, ClassStr text NOT NULL, ClassName text NOT NULL,Remark integer NOT NULL)"];
        if (result) {
            NSLog(@"成功创表");
        } else {
            NSLog(@"创表失败");
        }
    }
}

+(void)saveStr:(NSString *)classStr Name:(NSString *)ClassName remark:(NSInteger)remark
{
    [_db executeUpdateWithFormat:@"INSERT INTO t_more_one (ClassStr, ClassName,Remark) VALUES (%@, %@,%ld)",classStr,ClassName,remark];
}
+(BOOL)deleteStr:(NSInteger)remark
{
   BOOL isSuccess = [_db executeUpdateWithFormat:@"DELETE FROM t_more_one WHERE Remark = %ld",remark];
    if (isSuccess) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败%@",_db.lastErrorMessage);
    }
    return isSuccess;
}
+(BOOL)upData:(NSInteger)remark isNewStr:(NSString *)newClassStr NewName:(NSString *)newName
{
    BOOL isSuccess = [_db executeUpdateWithFormat:@"UPDATE t_more_one SET ClassStr = %@, ClassName = %@ WHERE Remark = %ld", newClassStr,newName,remark];
    if (isSuccess) {
        NSLog(@"更新成功");
    }else{
        NSLog(@"更新失败%@",_db.lastErrorMessage);
    }
    return isSuccess;
}
+ (NSArray *)list:(NSString *)selctStr
{
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_more_one"];
    NSMutableArray *list = [NSMutableArray array];
    while (set.next) {
        NSString *str = [set stringForColumn:selctStr];
        [list addObject:str];
}
    return list;
}
@end
