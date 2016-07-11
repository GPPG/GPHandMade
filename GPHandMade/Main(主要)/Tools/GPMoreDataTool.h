//
//  GPMoreDataTool.h
//  GPHandMade
//
//  Created by dandan on 16/7/8.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPMoreDataTool : NSObject

+(void)saveStr:(NSString *)classStr Name:(NSString *)ClassName remark:(NSInteger)remark;
+(BOOL)deleteStr:(NSInteger)remark;
+(BOOL)upData:(NSInteger)remark isNewStr:(NSString *)newClassStr NewName:(NSString *)newName;
+ (NSArray *)list:(NSString *)selctStr;
@end
