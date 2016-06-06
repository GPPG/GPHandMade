//
//  GPRecommend Cell.m
//  GPHandMade
//
//  Created by dandan on 16/5/19.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPRecommendCell.h"
#import "UIImageView+WebCache.h"
#import "GPDarenData.h"

@interface GPRecommendCell()
@property (weak, nonatomic) IBOutlet UIImageView *BgImageVIew; // 背景
@property (weak, nonatomic) IBOutlet UIImageView *UserImageView; // 头像
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel; // 昵称
@property (weak, nonatomic) IBOutlet UILabel *AddLabel; // 地址
@property (weak, nonatomic) IBOutlet UILabel *CourseLabel; // 教程
@property (weak, nonatomic) IBOutlet UILabel *FanLabel; // 粉丝
@property (weak, nonatomic) IBOutlet UILabel *HandLabel; // 手工圈
@property (weak, nonatomic) IBOutlet UIButton *AttentionBtn; // 关注我们

@end

@implementation GPRecommendCell
- (void)setDaren:(GPDarenData *)daren
{
    _daren = daren;
    
    NSURL *bgUrl = [NSURL URLWithString:daren.bg_image];
    NSURL *userUrl = [NSURL URLWithString:daren.avatar];
    
    [self.BgImageVIew sd_setImageWithURL:bgUrl placeholderImage:[UIImage imageNamed:@"3"]];
    [self.UserImageView sd_setImageWithURL:userUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.userNameLabel.text = daren.uname;
    self.AddLabel.text = daren.region;
    self.CourseLabel.text = [NSString stringWithFormat:@"教程 %@",daren.coursecount];
    self.FanLabel.text = [NSString stringWithFormat:@"粉丝 %@",daren.fen_num];
    self.HandLabel.text = [NSString stringWithFormat:@"手工圈 %@",daren.circle_count];
    
}


@end
