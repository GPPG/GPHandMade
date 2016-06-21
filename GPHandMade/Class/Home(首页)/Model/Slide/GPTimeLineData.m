//
//  GPTimeLineData.m
//  GPHandMade
//
//  Created by dandan on 16/6/17.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTimeLineData.h"
#import "MJExtension.h"
#import "GPTimeLinePicData.h"
#import "GPTimeLineLaudData.h"
#import "GPTimeLineCommentData.h"

@implementation GPTimeLineData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic" : [GPTimeLinePicData class],
             @"laud_list" : [GPTimeLineLaudData class],
             @"comment" : [GPTimeLineCommentData class]
             };
}
@end
