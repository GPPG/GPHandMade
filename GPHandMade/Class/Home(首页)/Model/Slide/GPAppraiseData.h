//
//  GPAppraiseData.h
//  GPHandMade
//
//  Created by dandan on 16/5/30.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPAppraiseData : NSObject
@property (nonatomic,copy) NSString *content; // 评论
@property (nonatomic,copy) NSString *praise; // 星星
@property (nonatomic,copy) NSString *add_time; // 时间
@property (nonatomic,copy) NSString *uname; // 用户名
@property (nonatomic,copy) NSString *face_pic; // 头像
@end
