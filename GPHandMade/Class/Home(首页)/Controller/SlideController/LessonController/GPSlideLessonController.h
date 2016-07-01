//
//  GPSlideLessonController.h
//  GPHandMade
//
//  Created by dandan on 16/5/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPslide;
@interface GPSlideLessonController : UITableViewController
@property (nonatomic, strong) GPslide *slideData;
@property (nonatomic, copy) NSString *handID;
@end
