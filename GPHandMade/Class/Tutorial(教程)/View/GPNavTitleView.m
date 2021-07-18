//
//  GPNavTitleView.m
//  GPHandMade
//
//  Created by dandan on 16/6/29.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPNavTitleView.h"
#import "UIView+SDAutoLayout.h"
@interface GPNavTitleView()
@property (nonatomic, strong) UIButton * previousBtn;
@property (nonatomic, strong) UIButton * currentBtn;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic,copy) NavTitleClickBlock navtitleClickBlock;
@end
@implementation GPNavTitleView
#pragma mark - 懒加载
- (NSArray *)titleArray
{
    if (!_titleArray) {
        
        _titleArray = @[@"图文",@"视频",@"专题"];
    }
    return _titleArray;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame block:(NavTitleClickBlock)block
{
    if (self = [super initWithFrame:frame]) {
        [self addChildView];
        [self addlayout];
        self.navtitleClickBlock = block;
    }
    return self;
}
- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}
// 添加子控件
- (void)addChildView
{
    for (int i = 0; i < 3; i ++) {
        UIButton *NavBtn = [[UIButton alloc]init];
        NavBtn.tag = i;
        [NavBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        NavBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [NavBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateNormal];
        [NavBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        NavBtn.userInteractionEnabled = NO;
//        [NavBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:NavBtn];
        [self addSubview:NavBtn];
    }
}
// 添加约束
- (void)addlayout
{
    UIButton *picBtn = self.btnArray[0];
    UIButton *videoBtn = self.btnArray[1];
    UIButton *subBtn = self.btnArray[2];
    
    UIView *leftLineView = [[UIView alloc]init];
    leftLineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    [self addSubview:leftLineView];
    
    UIView *rightLineView = [[UIView alloc]init];
    rightLineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    [self addSubview:rightLineView];
    
    CGFloat W = SCREEN_WIDTH * 0.6 * 0.33;
    
    picBtn.sd_layout
    .leftSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .topSpaceToView(self,0)
    .widthIs(W);
    
    leftLineView.sd_layout
    .leftSpaceToView(picBtn,0)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .widthIs(1);
    
    videoBtn.sd_layout
    .topEqualToView(leftLineView)
    .bottomEqualToView(leftLineView)
    .leftSpaceToView(leftLineView,0)
    .widthIs(W);

    rightLineView.sd_layout
    .topEqualToView(videoBtn)
    .bottomEqualToView(videoBtn)
    .leftSpaceToView(videoBtn,0)
    .widthIs(1);

    subBtn.sd_layout
    .topEqualToView(rightLineView)
    .bottomEqualToView(rightLineView)
    .leftSpaceToView(rightLineView,0)
    .widthIs(W);
}
// 按钮回调
-(void)titleClick:(UIButton *)sender
{
    self.navtitleClickBlock(sender);
}
// 改变按钮状态
-(void)changeSelectBtn:(UIButton *)btn
{
    self.previousBtn = self.currentBtn;
    self.currentBtn = btn;
    self.previousBtn.selected = NO;
    self.currentBtn.selected = YES;
}
// 更新按钮状态
-(void)updateSelecterToolsIndex:(NSInteger )index
{
    UIButton *selectBtn = self.btnArray[index];
    [self changeSelectBtn:selectBtn];
}

@end
