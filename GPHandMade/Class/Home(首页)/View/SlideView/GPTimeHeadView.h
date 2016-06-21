//
//  GPTimeHeadView.h
//  PYQ
//
//  Created by dandan on 16/6/17.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPTimeLineData;

@interface GPTimeHeadView : UIView

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) GPTimeLineData *timeLineData;
@property (nonatomic, strong) NSMutableArray *picUrlArray;
@end
