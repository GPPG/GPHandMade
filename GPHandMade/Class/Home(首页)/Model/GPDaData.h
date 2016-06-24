//
//  GPDaData.h
//  GPHandMade
//
//  Created by dandan on 16/6/23.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPDaData : NSObject
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *course_count;
@property (nonatomic,copy) NSString *video_count;
@property (nonatomic,copy) NSString *opus_count;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic,copy) NSString *tb_url;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *course_time;

@end
