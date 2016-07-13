//
//  GPSuperTiltleView.m
//  GPHandMade
//
//  Created by dandan on 16/7/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSuperTiltleView.h"

@interface GPSuperTiltleView()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIButton * previousBtn;
@property (nonatomic, strong) UIButton * currentBtn;
@property (nonatomic, strong) NSMutableArray *btnArray;
@end

@implementation GPSuperTiltleView
#pragma mark - 懒加载
- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}
- (instancetype)initWithChildControllerS:(NSArray *)titleArray
{
    if (self = [super init]) {
        self.titleArray = titleArray;
        [self layout];
    }
    return self;
    
}
- (void)layout
{
    UIButton *lastBtn = nil;
    for (int i = 0; i < self.titleArray.count; i ++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.userInteractionEnabled = NO;
        [self.btnArray addObject:btn];
        
        [self addSubview:btn];
        if (lastBtn) {
            btn.sd_layout
            .leftSpaceToView(lastBtn,40)
            .topSpaceToView(lastBtn,0)
            .bottomSpaceToView(lastBtn,0)
            .widthIs(40);
        }else{
            btn.sd_layout
            .leftSpaceToView(self,0)
            .topSpaceToView(self,0)
            .bottomSpaceToView(self,0)
            .widthIs(40);
        }
        lastBtn = btn;
    }
    [self setupAutoWidthWithRightView:lastBtn rightMargin:0];
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
