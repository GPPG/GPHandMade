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
#import "GPEventBar.h"

@interface GPSlideEventController ()
@property (nonatomic, weak) GPEventBar *bar;
@end

@implementation GPSlideEventController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self addAllChildVc];
    [self addEventBar];
    
    // 注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(snowUp) name:SnowUP object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(snowDown) name:SnowDown object:nil];
}
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
    newVc.slide = self.slide;
    [self addChildViewController:newVc];
    
    GPEventVoteController *voteVc = [[GPEventVoteController alloc]init];
    voteVc.title = @"投票最多";
    voteVc.slide = self.slide;
    [self addChildViewController:voteVc];
    
}
- (void)addEventBar
{
     GPEventBar *bar = [GPEventBar sharedInstace];
    [bar showCenter:CGPointMake(self.view.centerX, SCREEN_HEIGHT - 2 * GPTabBarH) cornerRadius:20];
    self.bar  = bar;
}
#pragma mark - 通知回调
- (void)snowUp
{
    NSLog(@"快上");
     [self.bar ShowanimateCenter:CGPointMake(self.view.centerX, SCREEN_HEIGHT + 2 * GPTabBarH) duration:1];
}
- (void)snowDown
{
    NSLog(@"快下");
     [self.bar ShowanimateCenter:CGPointMake(self.view.centerX, SCREEN_HEIGHT - 2 * GPTabBarH) duration:1];
}
#pragma mark - 生命周期
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.bar.window_.hidden = YES;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
