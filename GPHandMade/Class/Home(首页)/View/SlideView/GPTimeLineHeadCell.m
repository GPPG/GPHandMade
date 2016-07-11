//
//  GPTimeLineHeadCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/21.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTimeLineHeadCell.h"
#import "UIView+SDAutoLayout.h"
#import "GPPhotoContainerView.h"
#import "UIImageView+WebCache.h"
#import "GPTimeLineData.h"
#import "GPHandListData.h"

@interface GPTimeLineHeadCell()
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *contenLabel;
@property (nonatomic, weak) UIButton *moreBtn;
@property (nonatomic, weak) GPPhotoContainerView *photoView;
@end

@implementation GPTimeLineHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    [self.contentView sd_addSubviews:childS];
    // 添加约束
    [self addLayout];
    
}
- (void)addLayout
{
    CGFloat margin = 10;
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(self.contentView,margin)
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
    .leftEqualToView(self.iconImageView)
    .topSpaceToView(self.iconImageView,10)
    .rightSpaceToView(self.contentView,margin)
    .autoHeightRatio(0);
    
    self.photoView.sd_layout
    .leftEqualToView(self.iconImageView)
    .topSpaceToView(self.contenLabel,margin);

    [self setupAutoHeightWithBottomViewsArray:@[self.contenLabel,self.photoView] bottomMargin:margin];
}
#pragma mark - 内部方法
- (void)setTimeLineData:(GPTimeLineData *)timeLineData
{
    _timeLineData = timeLineData;
    
    NSURL *picUrl = [NSURL URLWithString:timeLineData.avatar];
    [self.iconImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.contenLabel.text = timeLineData.subject;
    self.timeLabel.text = timeLineData.add_time;
    self.nameLabel.text = timeLineData.uname;
}
- (void)setListData:(GPHandListData *)listData
{
    _listData = listData;
    NSURL *picUrl = [NSURL URLWithString:listData.avatar];
    [self.iconImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.contenLabel.text = listData.subject;
    self.timeLabel.text = listData.add_time;
    self.nameLabel.text = listData.uname;
}
- (void)setPicUrlArray:(NSMutableArray *)picUrlArray
{
    _picUrlArray = picUrlArray;
    self.photoView.picPathStringsArray = picUrlArray;
}
- (void)setSizeArray:(NSMutableArray *)sizeArray
{
    _sizeArray = sizeArray;
    self.photoView.sizeArray = sizeArray;
}
@end
