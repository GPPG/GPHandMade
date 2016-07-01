//
//  GPTutorialPicCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/30.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTutorialPicCell.h"
#import "UIImageView+WebCache.h"
#import "GPTutoriaPicData.h"

@interface GPTutorialPicCell()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *hotLabel;


@end
@implementation GPTutorialPicCell

- (void)awakeFromNib {
    self.layer.cornerRadius = 5;
}
- (void)setPicData:(GPTutoriaPicData *)picData
{
    _picData = picData;
    NSURL *bgUrl = [NSURL URLWithString:picData.host_pic];
    [self.bgImageView sd_setImageWithURL:bgUrl placeholderImage:[UIImage imageNamed:@"002"]];
    self.subtitle.text = picData.subject;
    self.userName.text = [NSString stringWithFormat:@"by %@",picData.user_name];
    self.bgView.backgroundColor = [UIColor colorWithHexString:picData.host_pic_color];
    self.hotLabel.text = [NSString stringWithFormat:@"%@人气/%@收藏",picData.view,picData.collect];
}
@end
