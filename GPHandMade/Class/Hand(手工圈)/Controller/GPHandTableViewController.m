//
//  GPHandTableViewController.m
//  GPHandMade
//
//  Created by dandan on 16/5/10.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHandTableViewController.h"
#import "GPHandPulicController.h"
#import "XWCircleSpreadAnimator.h"
#import "GPHandMoreChildController.h"
#import "GPEventBtn.h"

@interface GPHandTableViewController ()

@end

@implementation GPHandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self addAllChildVc];
    [self addMoreImage];
}
#pragma mark - 初始化子控件
- (void)setupView
{
    self.titleWidth = SCREEN_WIDTH - GPTitlesViewH;
    self.titleScrollViewColor = GPCommonBgColor;
    self.view.backgroundColor = GPCommonBgColor;
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
    GPHandPulicController *pulicVc = [[GPHandPulicController alloc]init];
    pulicVc.title = @"手工课官方";
    [self addChildViewController:pulicVc];
    GPHandPulicController *pulicV = [[GPHandPulicController alloc]init];
    pulicV.title = @"手工课官方";
    [self addChildViewController:pulicV];
    GPHandPulicController *pulic = [[GPHandPulicController alloc]init];
    pulic.title = @"手工课官方";
    [self addChildViewController:pulic];

}
- (void)addMoreImage
{
    UIImageView *moreImageView = [[UIImageView alloc]init];
    moreImageView.userInteractionEnabled = YES;
    moreImageView.image = [UIImage imageNamed:@"jia"];
    moreImageView.frame = CGRectMake(SCREEN_WIDTH - GPTitlesViewH, 0, GPTitlesViewH, GPTitlesViewH);
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addMoreVc)];
    [moreImageView addGestureRecognizer:tapGes];
    [self.contentView addSubview:moreImageView];
}
#pragma mark - 内部方法
- (void)addMoreVc
{
    XWCircleSpreadAnimator *animator = [XWCircleSpreadAnimator xw_animatorWithStartCenter:CGPointMake(SCREEN_WIDTH - 20, GPNavBarBottom + 20) radius:20];
    GPHandMoreChildController *moreVc = [[GPHandMoreChildController alloc]init];
    UINavigationController *navVc = [[UINavigationController alloc]initWithRootViewController:moreVc];
    [self xw_presentViewController:navVc withAnimator:animator];
}
@end
