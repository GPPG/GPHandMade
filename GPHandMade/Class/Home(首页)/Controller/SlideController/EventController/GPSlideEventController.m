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
#import "GPLoginController.h"
#import "HYBBubbleTransition.h"
#import "GPEventBtn.h"

@interface GPSlideEventController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) HYBBubbleTransition *bubbleTransition;
@property (nonatomic, weak) GPEventBtn *eventBtn;

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginVc) name:EventBarClick object:nil];
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
    webVc.handId = self.handId;
    [self addChildViewController:webVc];
    
    GPEventNewController *newVc = [[GPEventNewController alloc]init];
    newVc.title = @"最新作品";
    newVc.slide = self.slide;
    newVc.handID = self.handId;
    [self addChildViewController:newVc];
    
    GPEventVoteController *voteVc = [[GPEventVoteController alloc]init];
    voteVc.title = @"投票最多";
    voteVc.slide = self.slide;
    voteVc.handID = self.handId;
    [self addChildViewController:voteVc];
    
}
- (void)addEventBar
{

    GPEventBtn *eventBtn = [[GPEventBtn alloc]init];
    [eventBtn setImage:[UIImage imageNamed:@"activity"] forState:UIControlStateNormal];
    [eventBtn sizeToFit];
    eventBtn.transform = CGAffineTransformMakeScale(2, 2);
    [eventBtn showEventButCenter:CGPointMake(SCREEN_WIDTH * 0.5 , SCREEN_HEIGHT - GPEventScale * eventBtn.width)];
    [eventBtn addTarget:self action:@selector(loginVc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eventBtn];
    [self.view bringSubviewToFront:eventBtn];
    self.eventBtn = eventBtn;

}
#pragma mark - 通知回调
- (void)snowUp
{
    [self.eventBtn shoeAnamEventBtnCenter:CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT + GPEventScale * self.eventBtn.width)];
    
}
- (void)snowDown
{
    [self.eventBtn shoeAnamEventBtnCenter:CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT - GPEventScale * self.eventBtn.width)];
}
- (void)loginVc
{
    GPLoginController *loginVc = [UIStoryboard storyboardWithName:NSStringFromClass([GPLoginController class]) bundle:nil].instantiateInitialViewController;
    
    loginVc.modalPresentationStyle = UIModalPresentationCustom;
    
    self.bubbleTransition = [[HYBBubbleTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
        
        HYBBubbleTransition *bubble = (HYBBubbleTransition *)transition;
        
        bubble.bubbleColor = presented.view.backgroundColor;
        
        // 由于一个控制器有导航，一个没有，导致会有64的误差，所以要记得处理这种情况
        CGPoint center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT - GPEventScale * self.eventBtn.height);
        bubble.bubbleStartPoint = center;
    } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
        transition.transitionMode = kHYBTransitionDismiss;
    }];
    loginVc.transitioningDelegate = self.bubbleTransition;
    [self presentViewController:loginVc animated:YES completion:nil];
}
#pragma mark - 生命周期
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
