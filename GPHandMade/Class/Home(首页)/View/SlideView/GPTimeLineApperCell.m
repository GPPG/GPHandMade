//
//  GPTimeLineApperCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/20.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTimeLineApperCell.h"
#import "PhotosContainerView.h"
#import "UIView+SDAutoLayout.h"
#import "GPTimeLineLaudData.h"

@interface GPTimeLineApperCell()
@property (nonatomic, weak) PhotosContainerView *photosContainerView;
@property (nonatomic, weak) UIButton *voteBtn;
@end

@implementation GPTimeLineApperCell

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
    PhotosContainerView *photosContainerView = [[PhotosContainerView alloc]initWithMaxItemsCount:MAXFLOAT];
    self.photosContainerView = photosContainerView;
    [self.contentView addSubview:photosContainerView];
    
    UIButton *voteBtn = [[UIButton alloc]init];
    [voteBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [voteBtn setImage:[UIImage imageNamed:@"detailLaudH"] forState:UIControlStateNormal];
    voteBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    voteBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    voteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.voteBtn = voteBtn;
    [self.contentView addSubview:voteBtn];
    [self addLayout];
}
- (void)addLayout
{
    CGFloat magin = 15;
    self.voteBtn.sd_layout
    .leftSpaceToView(self.contentView,5)
    .topSpaceToView(self.contentView,0)
    .widthIs(60)
    .heightIs(30);
    
    self.photosContainerView.sd_layout
    .leftSpaceToView(self.voteBtn,5)
    .rightSpaceToView(self.contentView,magin)
    .topEqualToView(self.voteBtn);
    
}
- (void)setLaudArray:(NSArray *)laudArray
{
    _laudArray = laudArray;
    UIView *bototmView = self.voteBtn;
    if (laudArray.count) {
        bototmView = self.photosContainerView;
    }
    [self setupAutoHeightWithBottomView:bototmView bottomMargin:10];
    
    [self.voteBtn setTitle:self.laudnum forState:UIControlStateNormal];
    
    self.photosContainerView.photoNamesArray = laudArray;
}
@end
