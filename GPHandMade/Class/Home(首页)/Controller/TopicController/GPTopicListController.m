//
//  GPTopicListController.m
//  GPHandMade
//
//  Created by dandan on 16/6/28.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTopicListController.h"
#import "GPOneController.h"
#import "GPTwoController.h"
#import "GPThreeController.h"
#import "GPFourController.h"
#import "GPFiveController.h"
#import "GPSixController.h"
#import "GPSevenController.h"
#import "GPEightController.h"
#import "GPNineController.h"
#import "GPTenController.h"
#import "GPElevenController.h"
#import "GPTwelveViewController.h"
#import "GPThirteenController.h"

@interface GPTopicListController ()

@end

@implementation GPTopicListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"市集专题";
    // 初始化样式
    [self setupNav];
    // 添加子控制器
    [self setUpAllViewController];

    
}
#pragma mark - 初始化
- (void)setupNav
{
    self.titleScrollViewColor = [UIColor whiteColor];
    
    [self setUpTitleGradient:^(BOOL *isShowTitleGradient, YZTitleColorGradientStyle *titleColorGradientStyle, CGFloat *startR, CGFloat *startG, CGFloat *startB, CGFloat *endR, CGFloat *endG, CGFloat *endB) {
        *isShowTitleGradient = YES;
        *titleColorGradientStyle = YZTitleColorGradientStyleRGB;
        *endR = 1;
    }];
    [self setUpTitleScale:^(BOOL *isShowTitleScale, CGFloat *titleScale) {
        *isShowTitleScale = YES;
        *titleScale = 1.3;
    }];
}
- (void)setUpAllViewController
{
    GPOneController *oneVc = [[GPOneController alloc]init];
    [self addChildVc:oneVc title:@"好店排行榜"];
    
    GPTwoController *twoVc = [[GPTwoController alloc]init];
    [self addChildVc:twoVc title: @"新手必买"];
    
    GPThreeController *thrreVc = [[GPThreeController alloc]init];
    [self addChildVc:thrreVc title: @"折扣专区"];
    
    GPFourController *foureVc = [[GPFourController alloc]init];
    [self addChildVc:foureVc title:@"手工客专享"];

    GPFiveController *fiveVc = [[GPFiveController alloc]init];
    [self addChildVc:fiveVc title:@"木艺"];
    
    GPSixController *sixVc = [[GPSixController alloc]init];
    [self addChildVc:sixVc title: @"皮艺"];
    
    GPSevenController *sevenVc = [[GPSevenController alloc]init];
    [self addChildVc:sevenVc title:@"编织"];
    
    GPEightController *eightVc = [[GPEightController alloc]init];
    [self addChildVc:eightVc title:@"绕线"];
    
    GPNineController *nineVc = [[GPNineController alloc]init];
    [self addChildVc:nineVc title:@"手工护肤"];

    GPTenController *tenVc = [[GPTenController alloc]init];
    [self addChildVc:tenVc title:@"厨艺多肉"];

    GPElevenController *eleventVc = [[GPElevenController alloc]init];
    [self addChildVc:eleventVc title:@"布艺"];

    GPTwelveViewController *twelveVc = [[GPTwelveViewController alloc]init];
    [self addChildVc:twelveVc title:@"滴胶"];

    GPThirteenController *thirteenVc = [[GPThirteenController alloc]init];
    [self addChildVc:thirteenVc title:@"缝纫机"];

}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)titleStr
{
    childVc.title = titleStr;
    [self addChildViewController:childVc];
}
@end
