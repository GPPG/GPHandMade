//
//  GPTopicListCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/28.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTopicListCell.h"
#import "GPTopListData.h"
#import "UIImageView+WebCache.h"

@interface GPTopicListCell()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *subTitleBtn;

@end
@implementation GPTopicListCell

- (void)setListData:(GPTopListData *)listData
{
    _listData = listData;
    NSURL *picUrl = [NSURL URLWithString:listData.pic];
    [self.bgImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"02"]];
    [self.subTitleBtn setTitle:listData.subject forState:UIControlStateNormal];
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += 10;//整体向下 移动10
    frame.size.height -= 10;//间隔为10
    [super setFrame:frame];
}
@end
