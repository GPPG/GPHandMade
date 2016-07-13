
//
//  GPFariTopicCell.m
//  GPHandMade
//
//  Created by dandan on 16/7/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFariTopicCell.h"
#import "GPFariTopicData.h"

@interface GPFariTopicCell()
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;

@end
@implementation GPFariTopicCell

-(void)setTopicData:(GPFariTopicData *)topicData
{
    _topicData = topicData;
    NSURL *picUrl = [NSURL URLWithString:topicData.host_pic];
    [self.contentImage sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"001"]];
    [self.titleBtn setTitle:topicData.topic_name forState:UIControlStateNormal];
    
}

@end
