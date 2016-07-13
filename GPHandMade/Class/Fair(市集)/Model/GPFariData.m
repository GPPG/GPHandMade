//
//  GPFariData.m
//  GPHandMade
//
//  Created by dandan on 16/7/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFariData.h"
#import "MJExtension.h"
#import "GPFariHotData.h"
#import "GPFariBestData.h"
#import "GPFariTopicData.h"

@implementation GPFariData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"hot" : [GPFariHotData class],
             @"best" : [GPFariBestData class],
             @"topic" : [GPFariTopicData class],
             };
}
@end
