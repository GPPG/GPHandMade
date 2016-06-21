//
//  GPSlideShopData.h
//  GPHandMade
//
//  Created by dandan on 16/5/23.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSlideShopData : NSObject
@property (nonatomic,copy) NSString *subject; // 标题
@property (nonatomic,copy) NSString *host_pic; // 图片
@property (nonatomic,copy) NSString *avatar; // 头像
@property (nonatomic,copy) NSString *uname; // 用户
@property (nonatomic,copy) NSString *votes; // 投票数
@property (nonatomic,copy) NSString *last_id; // 标记
@property (nonatomic,copy) NSString *circle_item_id; // 跳转参数
@end
