//
//  GPDaRenStepOneCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDaRenStepOneCell.h"
#import "GPDaRenPicData.h"
#import "UIImageView+WebCache.h"

@interface GPDaRenStepOneCell()

@property (weak, nonatomic) IBOutlet UILabel *fanfanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *subtileLabel;
@property (weak, nonatomic) IBOutlet UILabel *insLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *fanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cateImaheView;
@property (weak, nonatomic) IBOutlet UILabel *cateNameLaebl;

@end
@implementation GPDaRenStepOneCell
- (void)awakeFromNib
{
    // 毛玻璃视图
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.alpha = 0.5f;
    effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.bgImageView addSubview:effectView];
}
- (void)setPicData:(GPDaRenPicData *)picData
{
    NSURL *bgUrl = [NSURL URLWithString:picData.host_pic_s];
    [self.bgImageView sd_setImageWithURL:bgUrl placeholderImage:[UIImage imageNamed:@"3"]];
    NSURL *iconUrl = [NSURL URLWithString:picData.face_pic];
    [self.iconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"1"]];
    NSURL *cateUrl = [NSURL URLWithString:picData.cate_pic];
    [self.cateImaheView sd_setImageWithURL:cateUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.cateImaheView.layer.cornerRadius = 10;
    self.cateImaheView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 30;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.cateNameLaebl.text = picData.cate_name;
    self.subtileLabel.text = picData.subject;
    self.insLabel.text = picData.summary;
    self.fanLabel.text = picData.user_name;
    self.fanfanLabel.text = [NSString stringWithFormat:@"%@人气|%@收藏|%@评论|%@赞",picData.view,picData.collect,picData.comment_num,picData.laud];    
}


@end
