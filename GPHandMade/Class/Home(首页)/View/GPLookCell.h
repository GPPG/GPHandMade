//
//  GPLookCell.h
//  GPHandMade
//
//  Created by dandan on 16/5/19.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPSalonData,GPDynamicData,GPCompetitionData;
@interface GPLookCell : UITableViewCell
@property (nonatomic, strong) GPSalonData *salon; // 活动模型
@property (nonatomic, strong) GPDynamicData *dynamic; // 活动模型
@property (nonatomic, strong) GPCompetitionData *competition; // 活动模型

@end
