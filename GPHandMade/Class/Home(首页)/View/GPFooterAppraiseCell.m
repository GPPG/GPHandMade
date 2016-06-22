//
//  GPFooterAppraiseCell.m
//  GPHandMade
//
//  Created by dandan on 16/5/30.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFooterAppraiseCell.h"
#import "GPAppraiseData.h"
#import "UIImageView+WebCache.h"
#import "UIView+RoundedCorner.h"

@interface GPFooterAppraiseCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView; // 头像
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel; // 用户名
@property (weak, nonatomic) IBOutlet UILabel *timeLabel; // 时间
@property (weak, nonatomic) IBOutlet UILabel *commentLabel; // 评论
@property (weak, nonatomic) IBOutlet UIView *starView; // 星星

@end
@implementation GPFooterAppraiseCell
-(void)setAppraiseData:(GPAppraiseData *)appraiseData
{
    _appraiseData = appraiseData;
    NSURL *userPicUrl = [NSURL URLWithString:appraiseData.face_pic];
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:userPicUrl options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image) {
            [self.userImageView jm_setCornerRadius:25 withImage:image];
        }
    }];

    self.userNameLabel.text = appraiseData.uname;
    self.timeLabel.text = appraiseData.add_time;
    self.commentLabel.text = appraiseData.content;
    // 点亮星星
    for (UIButton *btn in self.starView.subviews) {
        btn.selected = NO;
    }
    NSInteger starCoutn = [appraiseData.praise integerValue]/20;
    for (int i = 0; i < starCoutn; i ++) {
        UIButton *btn = self.starView.subviews[i];
        btn.selected = YES;
    }
    
}
@end
