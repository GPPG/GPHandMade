//
//  GPHandDataTool.h
//  GPHandMade
//
//  Created by dandan on 16/7/9.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPHandDataTool : NSObject
+ (void)saveItemArray:(NSArray *)itemArray remark:(NSString *)remark type:(NSMutableArray *)type;
+ (BOOL)updateItemArray:(NSArray *)moreNameArray strArray:(NSArray *)moreStrArray remark:(NSString *)remark;
+ (NSMutableArray *)list:(NSString *)name;

+ (void)saveZeroArray:(NSMutableArray *)itemArray remark:(NSString *)remark type:(NSMutableArray *)strArray;
+ (BOOL)updateZeroArray:(NSArray *)moreNameArray strArray:(NSArray *)moreStrArray remark:(NSString *)remark;
+ (NSMutableArray *)zeroList:(NSString *)name;
@end
