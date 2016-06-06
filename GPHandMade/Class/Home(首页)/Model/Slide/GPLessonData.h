//
//  GPLessonData.h
//  GPHandMade
//
//  Created by dandan on 16/5/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPLessonData : NSObject
@property (nonatomic,copy) NSString *subject; // 主标题
@property (nonatomic,copy) NSString *content; // 内容
@property (nonatomic,copy) NSString *price; // 目前价格
@property (nonatomic,copy) NSString *original_price; // 原始价格
@property (nonatomic,copy) NSString *start_time; // 上课时间
@property (nonatomic,copy) NSString *address; // 上课地点
@property (nonatomic, strong) NSArray *pic; // 轮播图片
@property (nonatomic,copy) NSString *people_min; //上课最少人数
@property (nonatomic,copy) NSString *people_max; // 上课最大人数
@property (nonatomic,copy) NSString *deadline; // 截止报名时间
@property (nonatomic,copy) NSString *buyer_num; // 已购买人数
@property (nonatomic,copy) NSString *view; //评分人数
@property (nonatomic, strong) NSArray *material; // 材料
@property (nonatomic, strong) NSArray *tools; // 工具
@property (nonatomic,copy) NSString *uname; //作者单位
@property (nonatomic,copy) NSString *teacher_des; // 作者简介
@property (nonatomic, strong) NSArray *other_class; // 老师其他课程
@property (nonatomic,copy) NSString *face_pic; // 头像
@property (nonatomic,copy) NSString *create_time; // 创建时间
@property (nonatomic,copy) NSString *material_price; //材料价格
@property (nonatomic, strong) NSArray *allInfoNew; // 以上所有信息
@property (nonatomic, strong) NSArray *appraise; // 老师其他课程
@end
