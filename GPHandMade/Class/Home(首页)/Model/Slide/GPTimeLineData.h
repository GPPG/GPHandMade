//
//  GPTimeLineData.h
//  GPHandMade
//
//  Created by dandan on 16/6/17.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPTimeLineData : NSObject
@property (nonatomic,copy) NSString *subject; // 内容
@property (nonatomic,copy) NSString *add_time; // 时间
@property (nonatomic,copy) NSString *uname; // 昵称
@property (nonatomic,copy) NSString *avatar; // 头像
@property (nonatomic, strong) NSArray *pic; // 九宫格图片数组
@property (nonatomic, strong) NSArray *laud_list; // 点赞数组
@property (nonatomic,copy) NSString *c_name; // 活动名称
@property (nonatomic,copy) NSString *votes; // 投票数
@property (nonatomic,copy) NSString *laud_num; // 点赞数
@property (nonatomic, strong) NSArray *comment; // 平论

@end
