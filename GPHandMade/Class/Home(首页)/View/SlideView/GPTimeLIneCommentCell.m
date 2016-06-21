//
//  GPTimeLIneCommentCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/20.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTimeLIneCommentCell.h"
#import "UIView+SDAutoLayout.h"
#import "GPTimeLineCommentData.h"
#import "UIImageView+WebCache.h"

@interface GPTimeLIneCommentCell()
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UIButton *nameBtn;
@property (nonatomic, weak) UIButton *toNameBtn;
@property (nonatomic, weak) UILabel *ploadLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@end
@implementation GPTimeLIneCommentCell

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
    
    UIButton *nameBtn = [[UIButton alloc]init];
    [nameBtn setTitleColor:GPNameColor forState:UIControlStateNormal];
    self.nameBtn = nameBtn;
    
    UIButton *toNameBtn = [[UIButton alloc]init];
    [toNameBtn setTitleColor:GPNameColor forState:UIControlStateNormal];
    self.toNameBtn = toNameBtn;
    
    UILabel *ploadLabel = [[UILabel alloc]init];
    ploadLabel.text = @"回复";
    ploadLabel.textColor = [UIColor darkGrayColor];
    self.ploadLabel = ploadLabel;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.textColor = [UIColor darkGrayColor];
    self.contentLabel = contentLabel;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:10];
    NSArray *childS = @[iconImageView,nameBtn,toNameBtn,ploadLabel,contentLabel,timeLabel];
    [self sd_addSubviews:childS];
    
    [self addLayout];
}
- (void)addLayout
{
    CGFloat magin = 15;
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView,magin)
    .topSpaceToView(self.contentView,magin)
    .widthIs(40)
    .heightEqualToWidth();
    self.iconImageView.sd_cornerRadiusFromWidthRatio = (@0.5);
    
    self.nameBtn.sd_layout
    .leftSpaceToView(self.iconImageView,magin)
    .topEqualToView(self.iconImageView);
    [self.nameBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:25];
    
    self.timeLabel.sd_layout
    .rightSpaceToView(self.contentView,magin)
    .topEqualToView(self.nameBtn)
    .widthIs(20)
    .autoHeightRatio(0);
    
    self.ploadLabel.sd_layout
    .leftEqualToView(self.nameBtn)
    .topSpaceToView(self.nameBtn,magin)
    .rightSpaceToView(self.toNameBtn,0);
    
    self.toNameBtn.sd_layout
    .topEqualToView(self.ploadLabel)
    .bottomEqualToView(self.ploadLabel)
    .leftSpaceToView(self.ploadLabel,0);

    self.contentLabel.sd_layout
    .leftSpaceToView(self.contentLabel,0)
    .topEqualToView(self.toNameBtn)
    .bottomEqualToView(self.toNameBtn)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:magin];
}
- (void)setCommentData:(GPTimeLineCommentData *)commentData
{
    _commentData = commentData;
    
    NSURL *iconUrl = [NSURL URLWithString:commentData.avatar];
    [self.iconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.timeLabel.text = commentData.add_time;
    [self.nameBtn setTitle:commentData.uname forState:UIControlStateNormal];
    self.contentLabel.text = commentData.content;

    if (commentData.to_uname.length) {
        [self.toNameBtn setTitle:commentData.to_uname forState:UIControlStateNormal];
        [self.toNameBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:25];
        self.ploadLabel.sd_layout
        .autoHeightRatio(0);
    }else{
        self.toNameBtn.sd_layout
        .widthIs(0);
        self.ploadLabel.sd_layout
        .widthIs(0);
    }
    
}
@end
