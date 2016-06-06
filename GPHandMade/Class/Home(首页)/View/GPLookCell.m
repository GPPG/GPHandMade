//
//  GPLookCell.m
//  GPHandMade
//
//  Created by dandan on 16/5/19.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPLookCell.h"
#import "GPSalonData.h"
#import "UIImageView+WebCache.h"
#import "GPDynamicData.h"
#import "GPCompetitionData.h"

@interface GPLookCell()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView; // 头像
@property (weak, nonatomic) IBOutlet UILabel *topTitle; // 上标题
@property (weak, nonatomic) IBOutlet UILabel *btotomTitle; // 下标题
@property (weak, nonatomic) IBOutlet UIButton *robBtn; // 抢先占位
@end

@implementation GPLookCell
// 直播
-(void)setSalon:(GPSalonData *)salon
{
    _salon = salon;
    NSURL *picUrl = [NSURL URLWithString:salon.pic];
    [self.photoImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.topTitle.text = salon.subject;
    self.btotomTitle.text = salon.title;
    self.robBtn.hidden = NO;
}

- (void)setDynamic:(GPDynamicData *)dynamic
{
    _dynamic = dynamic;
    NSURL *picUrl = [NSURL URLWithString:dynamic.pic];
    [self.photoImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.topTitle.text =@"好友动态";
    self.btotomTitle.text = dynamic.title;
    self.robBtn.hidden = YES;
    
}
- (void)setCompetition:(GPCompetitionData *)competition
{
    _competition = competition;
    NSURL *picUrl = [NSURL URLWithString:competition.pic];
    [self.photoImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.topTitle.text = @"最新活动";
    self.btotomTitle.text = competition.c_name;
    self.robBtn.hidden = YES;
}



@end
