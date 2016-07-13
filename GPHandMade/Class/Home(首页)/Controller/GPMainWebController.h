//
//  GPMainWebController.h
//  GPHandMade
//
//  Created by dandan on 16/6/26.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPHotData,GPFariBestData,GPFariTopicData;
@interface GPMainWebController : UIViewController
@property (nonatomic, strong) GPHotData *hotData;
@property (nonatomic, strong) GPFariBestData *bestData;
@property (nonatomic, strong) GPFariTopicData *topicData;
@end
