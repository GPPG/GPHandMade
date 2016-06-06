//
//  GPHomController.m
//  GPHandMade
//
//  Created by dandan on 16/6/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHomController.h"
#import "GPFeaturedController.h"
#import "GPFocusController.h"
#import "GPDaRenController.h"
#import "GPEventController.h"

@interface GPHomController ()

@end

@implementation GPHomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化样式
    [self setupView];
    // 添加子控制器
    [self addAllChildVc];
}
#pragma mark - 初始化子控件
- (void)setupView
{
    // 设置标题栏样式
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        *titleScrollViewColor = [UIColor whiteColor];
        *norColor = [UIColor darkGrayColor];
        *selColor = [UIColor redColor];
        *titleHeight = GPTitlesViewH;
    }];
    // 设置下标
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        *isShowUnderLine = YES;
        *underLineColor = [UIColor redColor];
    }];
}
- (void)addAllChildVc
{
    GPFeaturedController *featureVc = [[GPFeaturedController alloc]init];
    featureVc.title = @"精选";
    [self addChildViewController:featureVc];
    
     GPFocusController *focusVc = [[GPFocusController alloc]init];
    focusVc.title = @"关注";
    [self addChildViewController:focusVc];
    
    GPDaRenController *daRenVc = [[GPDaRenController alloc]init];
    daRenVc.title = @"达人";
    [self addChildViewController:daRenVc];
    
    GPEventController *eventVc = [[GPEventController alloc]init];
    eventVc.title = @"活动";
    [self addChildViewController:eventVc];
}
@end
