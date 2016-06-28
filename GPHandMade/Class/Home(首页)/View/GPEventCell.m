//
//  GPEventCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/27.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEventCell.h"
#import "GPEventData.h"
#import "UIImageView+WebCache.h"

@interface GPEventCell()
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end
@implementation GPEventCell
- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setEventData:(GPEventData *)eventData
{
    _eventData = eventData;
    NSURL *contUrl = [NSURL URLWithString:eventData.m_logo];
    [self.contentImageView sd_setImageWithURL:contUrl placeholderImage:[UIImage imageNamed:@"2"]];
    self.timeLabel.text = [NSString stringWithFormat:@"征集作品时间:%@",eventData.c_time];
    self.eventLabel.text = eventData.c_name;
    if ([eventData.c_status isEqualToString:@"1"]) {
        self.statusLabel.text = @"进行中";
        self.statusLabel.textColor = [UIColor blackColor];
    }else{
        self.statusLabel.text = @"已结束";
        self.statusLabel.textColor = [UIColor lightGrayColor];
    }
}
@end
