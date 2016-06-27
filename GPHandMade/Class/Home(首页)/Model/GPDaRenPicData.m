//
//  GPDaRenPicData.m
//  GPHandMade
//
//  Created by dandan on 16/6/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDaRenPicData.h"
#import "GPDaRenMaterialData.h"
#import "GPDaRenStepData.h"
#import "GPDaRenToolsData.h"
#import "MJExtension.h"

@implementation GPDaRenPicData
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"tools" : [GPDaRenToolsData class],
             @"material" : [GPDaRenMaterialData class],
             @"step" : [GPDaRenStepData class],
             };
}

@end
