//
//  GPActivityData.h
//  GPHandMade
//
//  Created by dandan on 16/5/19.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GPSalonData,GPDynamicData,GPCompetitionData;

@interface GPActivityData : NSObject
@property (nonatomic, strong) GPSalonData *salon; // 直播
@property (nonatomic, strong) GPDynamicData *dynamic; // 好友
@property (nonatomic, strong) GPCompetitionData *competition; // 活动
@end
