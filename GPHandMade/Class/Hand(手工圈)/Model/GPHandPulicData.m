//
//  GPHandPulicData.m
//  GPHandMade
//
//  Created by dandan on 16/7/11.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHandPulicData.h"
#import "GPHandListData.h"

@implementation GPHandPulicData
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list" : [GPHandListData class],
             };
}
@end
