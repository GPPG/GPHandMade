//
//  GPSlideEventController.m
//  GPHandMade
//
//  Created by dandan on 16/6/6.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSlideEventController.h"
#import "GPEventNewController.h"
#import "GPEventVoteController.h"
#import "GPWebViewController.h"
#import "GPslide.h"

@interface GPSlideEventController ()
@end

@implementation GPSlideEventController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self addAllChildVc];
}
#pragma mark - 数据处理

#pragma mark - 初始化子控件
- (void)setupView
{
    self.title = @"活动作品";
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    GPWebViewController *webVc = [UIStoryboard storyboardWithName:NSStringFromClass([GPWebViewController class]) bundle:nil].instantiateInitialViewController;
    webVc.title = @"活动介绍";
    webVc.slide = self.slide;
    [self addChildViewController:webVc];
    
    GPEventNewController *newVc = [[GPEventNewController alloc]init];
    newVc.title = @"最新作品";
    [self addChildViewController:newVc];
    
    GPEventVoteController *voteVc = [[GPEventVoteController alloc]init];
    voteVc.title = @"投票最多";
    [self addChildViewController:voteVc];
    
}
@end
