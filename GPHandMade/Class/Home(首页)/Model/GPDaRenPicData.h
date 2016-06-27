//
//  GPDaRenPicData.h
//  GPHandMade
//
//  Created by dandan on 16/6/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPDaRenPicData : NSObject
@property (nonatomic,copy) NSString *subject; // 主标题
@property (nonatomic,copy) NSString *summary; // 概述
@property (nonatomic,copy) NSString *cate_name; // 分类名字
@property (nonatomic,copy) NSString *cate_pic; // 分类图片
@property (nonatomic,copy) NSString *user_name; // 昵称
@property (nonatomic,copy) NSString *face_pic; // 头像
@property (nonatomic,copy) NSString *view; // 人气
@property (nonatomic,copy) NSString *collect; // 收藏
@property (nonatomic,copy) NSString *laud; //赞
@property (nonatomic,copy) NSString *comment_num; // 评论
@property (nonatomic, strong) NSArray *tools; // 工具
@property (nonatomic, strong) NSArray *material; // 材料
@property (nonatomic, strong) NSArray *step; // 步骤
@property (nonatomic,copy) NSString *tips; // 小贴士
@property (nonatomic,copy) NSString *host_pic_s; // 背景
@property (nonatomic,copy) NSString *host_pic_ss;

@end
