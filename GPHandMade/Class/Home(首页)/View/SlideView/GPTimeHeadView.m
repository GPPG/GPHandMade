//
//  GPTimeHeadView.m
//  PYQ
//
//  Created by dandan on 16/6/17.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTimeHeadView.h"
#import "UIView+SDAutoLayout.h"
#import "GPPhotoContainerView.h"
#import "UIImageView+WebCache.h"
#import "GPTimeLineData.h"


@interface GPTimeHeadView()
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *contenLabel;
@property (nonatomic, weak) UIButton *moreBtn;
@property (nonatomic, weak) GPPhotoContainerView *photoView;
@end

@implementation GPTimeHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}
- (void)setup
{
    UIImageView *iconImageView = [[UIImageView alloc]init];
    self.iconImageView = iconImageView;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:10];
    timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel = timeLabel;
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = GPNameColor;
    self.nameLabel = nameLabel;
    
    UILabel *contenLabel = [[UILabel alloc]init];
    contenLabel.font = [UIFont systemFontOfSize:14];
    contenLabel.numberOfLines = 0;
    contenLabel.textColor = [UIColor lightGrayColor];
    self.contenLabel = contenLabel;
    
    GPPhotoContainerView *photoView = [[GPPhotoContainerView alloc]init];
    self.photoView = photoView;
    NSArray *childS = @[iconImageView,timeLabel,nameLabel,contenLabel,photoView];
    [self sd_addSubviews:childS];
    // 添加约束
    [self addLayout];
    
}
- (void)addLayout
{
    CGFloat margin = 10;
    self.iconImageView.sd_layout
    .leftSpaceToView(self,margin)
    .topSpaceToView(self,margin)
    .widthIs(40)
    .heightIs(40);
    self.iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    self.nameLabel.sd_layout
    .topEqualToView(_iconImageView)
    .leftSpaceToView(_iconImageView,margin)
    .heightIs(18);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.timeLabel.sd_layout
    .leftSpaceToView(_iconImageView, margin)
    .bottomEqualToView(_iconImageView)
    .heightIs(10);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.contenLabel.sd_layout
    .leftEqualToView(_iconImageView)
    .topSpaceToView(_iconImageView,margin)
    .rightSpaceToView(self,margin)
    .autoHeightRatio(0);
    
    self.photoView.sd_layout
    .leftEqualToView(self.contenLabel)
    .topSpaceToView(_contenLabel,margin);
//    self.backgroundColor = [UIColor greenColor];
}
#pragma mark - 内部方法
- (void)setTimeLineData:(GPTimeLineData *)timeLineData
{
    _timeLineData = timeLineData;
    
    NSURL *picUrl = [NSURL URLWithString:timeLineData.avatar];
    [self.iconImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.timeLabel.text = timeLineData.add_time;
    self.nameLabel.text = timeLineData.uname;
    self.contenLabel.text = timeLineData.subject;
    self.photoView.picPathStringsArray = self.picUrlArray;
    
    UIView  *bottomView  = self.photoView;
    if (!self.picUrlArray.count) {
        bottomView = self.contenLabel;
    }
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:10];
}

@end
