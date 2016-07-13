//
//  GPTutorVideoCell.m
//  GPHandMade
//
//  Created by dandan on 16/7/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTutorVideoCell.h"
#import "GPTutorVideoData.h"
#import "UIImageView+WebCache.h"

@interface GPTutorVideoCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *subTitle;

@end
@implementation GPTutorVideoCell
- (void)awakeFromNib
{
    self.subTitle.userInteractionEnabled = NO;
}
- (void)setVideoData:(GPTutorVideoData *)videoData
{
    _videoData = videoData;
    NSURL *bgImageUrl = [NSURL URLWithString:videoData.host_pic];
    [self.bgImageView sd_setImageWithURL:bgImageUrl placeholderImage:[UIImage imageNamed:@"03"]];
    [self.subTitle setTitle:videoData.subject forState:UIControlStateNormal];
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += 10;//整体向下 移动10
    frame.size.height -= 10;//间隔为10
    [super setFrame:frame];
}
@end
