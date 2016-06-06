//
//  GPContentCell.h
//  GPHandMade
//
//  Created by dandan on 16/5/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPLessonData;
@interface GPContentCell : UITableViewCell
@property (nonatomic, strong) GPLessonData *lessonData;
@property (nonatomic,copy) NSString *ContentStr;

@end
