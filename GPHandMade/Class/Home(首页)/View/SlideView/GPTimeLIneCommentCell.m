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
    toNameBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.toNameBtn = toNameBtn;
    
    UILabel *ploadLabel = [[UILabel alloc]init];
    ploadLabel.textColor = [UIColor darkGrayColor];
    ploadLabel.font = [UIFont systemFontOfSize:10];
    ploadLabel.text = @"回复: ";
    self.ploadLabel = ploadLabel;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.textColor = [UIColor darkGrayColor];
    contentLabel.font = [UIFont systemFontOfSize:10];
    self.contentLabel = contentLabel;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:10];
    self.timeLabel = timeLabel;
    
    NSArray *childS = @[iconImageView,nameBtn,toNameBtn,ploadLabel,contentLabel,timeLabel];
    [self.contentView sd_addSubviews:childS];
    [self addLayout];
}
- (void)addLayout
{
    CGFloat magin = 5;
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView,magin)
    .topSpaceToView(self.contentView,magin)
    .widthIs(30)
    .heightEqualToWidth();
    self.iconImageView.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    self.nameBtn.sd_layout
    .leftSpaceToView(self.iconImageView,0)
    .topEqualToView(self.iconImageView);
    self.nameBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.nameBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:15];
    
    self.timeLabel.sd_layout
    .rightSpaceToView(self.contentView,magin)
    .centerYEqualToView(self.nameBtn)
    .heightIs(20);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:180];

    self.ploadLabel.sd_layout
    .leftSpaceToView(self.iconImageView,10)
    .topSpaceToView(self.nameBtn,magin);
    [self.ploadLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.toNameBtn.sd_layout
    .centerYEqualToView(self.ploadLabel)
    .leftSpaceToView(self.ploadLabel,0);

    self.contentLabel.sd_layout
    .rightSpaceToView(self.contentView,magin)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:15];
}
- (void)setCommentData:(GPTimeLineCommentData *)commentData
{
    _commentData = commentData;
    
    NSURL *iconUrl = [NSURL URLWithString:commentData.avatar];
    [self.iconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.timeLabel.text = commentData.add_time;
    [self.nameBtn setTitle:commentData.uname forState:UIControlStateNormal];
    self.contentLabel.text = commentData.content;
    if (commentData.to_uname) {
        [self.toNameBtn setTitle:commentData.to_uname forState:UIControlStateNormal];
        [self.toNameBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:25];
        self.contentLabel.sd_layout
        .leftSpaceToView(self.toNameBtn,5)
        .topSpaceToView(self.nameBtn,11);
        self.toNameBtn.hidden = NO;
    }else{
        self.contentLabel.sd_layout
        .leftSpaceToView(self.ploadLabel,0)
        .topSpaceToView(self.nameBtn,11);
        self.toNameBtn.hidden = YES;
    }
}
@end
