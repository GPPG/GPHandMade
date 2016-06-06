//
//  GPData.h
//  GPHandMade
//
//  Created by dandan on 16/5/19.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GPActivityData,GPDarenData;
@interface GPData : NSObject
@property (nonatomic, strong) NSArray *slide; // 轮播图数组
@property (nonatomic, strong) NSArray *hotTopic; // 热帖数组
@property (nonatomic,strong) NSArray *navigation; // 直播
@property (nonatomic,strong) NSArray *advance; // 推荐

/*******************************************************************************************以下的属性,由于手工客官方升级,所以以前的接口失效了****************************************************************************************/
@property (nonatomic, strong) GPActivityData *relations; // 活动
@property (nonatomic, strong) GPDarenData *daren; // 达人
@end
