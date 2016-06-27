//
//  GPTimeLineEventCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/20.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTimeLineEventCell.h"
#import "UIView+SDAutoLayout.h"
#import "GPTimeLineData.h"
#import "SVProgressHUD.h"

@interface GPTimeLineEventCell()
@property (nonatomic, weak) UIButton *eventBtn;
@property (nonatomic, weak) UIButton *voteBtn;
@property (nonatomic, weak) UIButton *countBtn;
@property (nonatomic, weak) UIImageView *arrowImageView;
@end

@implementation GPTimeLineEventCell
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
    UIButton *eventBtn = [[UIButton alloc]init];
    [eventBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    eventBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [eventBtn addTarget:self action:@selector(eventBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.eventBtn = eventBtn;
    
    UIImageView *arrowImageView = [[UIImageView alloc]init];
    arrowImageView.image = [UIImage imageNamed:@"jiantou_right"];
    self.arrowImageView = arrowImageView;
    
    
    UIButton *countBtn = [[UIButton alloc]init];
    [countBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    countBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    countBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    countBtn.layer.borderWidth = 1;
    self.countBtn = countBtn;

    UIButton *voteBtn = [[UIButton alloc]init];
    [voteBtn setBackgroundColor:[UIColor orangeColor]];
    [voteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [voteBtn setTitle:@"投票" forState:UIControlStateNormal];
    [voteBtn addTarget:self action:@selector(voteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.voteBtn = voteBtn;
    
    NSArray *chilS = @[eventBtn,countBtn,voteBtn,arrowImageView];
    [self.contentView sd_addSubviews:chilS];
    
    [self addLayout];
}
- (void)addLayout
{
    CGFloat magin = 15;
    CGFloat W = SCREEN_WIDTH / 4;
    self.eventBtn.sd_layout
    .leftSpaceToView(self.contentView,magin)
    .topSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,magin)
    .heightIs(30);
    
    self.arrowImageView.sd_layout
    .rightSpaceToView(self.contentView,magin)
    .centerYEqualToView(self.eventBtn)
    .widthIs(15)
    .heightEqualToWidth();
    
    self.countBtn.sd_layout
    .leftSpaceToView(self.contentView,W)
    .topSpaceToView(self.eventBtn,5)
    .widthIs(W)
    .heightIs(W * 0.5);
    self.countBtn.sd_cornerRadius = @5;
    
    self.voteBtn.sd_layout
    .topSpaceToView(self.eventBtn,5)
    .rightSpaceToView(self.contentView,W)
    .widthIs(W)
    .heightIs(W * 0.5);
    self.voteBtn.sd_cornerRadius = @5;
    
    [self setupAutoHeightWithBottomViewsArray:@[self.countBtn,self.voteBtn] bottomMargin:magin];
}
- (void)setLineData:(GPTimeLineData *)lineData
{
    _lineData = lineData;
    NSString *titleStr = [NSString stringWithFormat:@"活动名称:%@",lineData.c_name];
    [self.eventBtn setTitle:titleStr forState:UIControlStateNormal];
    [self.countBtn setTitle:lineData.votes forState:UIControlStateNormal];
}
#pragma mark - 内部方法
- (void)voteBtnClick
{   [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

    [SVProgressHUD showSuccessWithStatus:@"投票成功"];
}
- (void)eventBtnClick
{
    if (self.EventBtnClick) {
        self.EventBtnClick();
    }
    
}
@end
