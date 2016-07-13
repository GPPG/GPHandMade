//
//  GPFairSectionHeadView.m
//  GPHandMade
//
//  Created by dandan on 16/7/13.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFairSectionHeadView.h"

@interface GPFairSectionHeadView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation GPFairSectionHeadView
- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}

- (void)setSubtitleStr:(NSString *)subtitleStr
{
    _subtitleStr = subtitleStr;
    self.subtitleLabel.text = subtitleStr;
}
@end
