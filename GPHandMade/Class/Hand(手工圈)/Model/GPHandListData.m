//
//  GPHandListData.m
//  GPHandMade
//
//  Created by dandan on 16/7/11.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHandListData.h"
#import "GPHandPicData.h"
#import "GPHandCommentData.h"
#import "GPHandlaudData.h"

@implementation GPHandListData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"pic" : [GPHandPicData class],
             @"comment" : [GPHandCommentData class],
             @"laud_list" : [GPHandlaudData class],
             };
}@end


