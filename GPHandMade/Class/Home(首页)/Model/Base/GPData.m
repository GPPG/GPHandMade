


//
//  GPData.m
//  GPHandMade
//
//  Created by dandan on 16/5/19.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPData.h"
#import "MJExtension.h"
#import "GPslide.h"
#import "GPHotData.h"
#import "GPNavigationData.h"
#import "GPAdvanceDtata.h"

@implementation GPData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"slide" : [GPslide class],
             @"hotTopic" : [GPHotData class],
             @"navigation" : [GPNavigationData class],
             @"advance" : [GPAdvanceData class]
             };
}
@end
