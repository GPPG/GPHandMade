//
//  GPLessonData.m
//  GPHandMade
//
//  Created by dandan on 16/5/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPLessonData.h"
#import "GPMaterial.h"
#import "GPTools.h"
#import "GPOtherClass.h"
#import "MJExtension.h"
#import "GPAppraiseData.h"

@implementation GPLessonData

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"material" : [GPMaterial class],
             @"tools" : [GPTools class],
             @"other_class" : [GPOtherClass class],
             @"appraise" : [GPAppraiseData class]
             };
}

/**
 *  服务器返回的时间
 */
- (NSString *)deadline
{    
    NSTimeInterval time=[_deadline doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];

    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    return currentDateStr;
}

@end
