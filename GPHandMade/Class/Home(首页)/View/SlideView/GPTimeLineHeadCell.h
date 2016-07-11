//
//  GPTimeLineHeadCell.h
//  GPHandMade
//
//  Created by dandan on 16/6/21.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPTimeLineData,GPHandListData;
@interface GPTimeLineHeadCell : UITableViewCell
@property (nonatomic, strong) GPTimeLineData *timeLineData;
@property (nonatomic, strong) NSMutableArray *picUrlArray;
@property (nonatomic, strong) NSMutableArray *sizeArray;

@property (nonatomic, strong) GPHandListData *listData;
@end
