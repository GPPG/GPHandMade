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
#import "GPHandDataTool.h"
#define ONEName @"moreName"

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
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"综合圈",@"布艺",@"皮艺",@"木艺",@"编织",@"饰品",@"文艺",@"刺绣",@"模型",@"羊毛毡",@"橡皮章",@"黏土陶艺",@"园艺多肉",@"手绘印刷",@"手工护肤",@"美食烘焙",@"旧物改造",@"滴胶热缩",@"电子科技",@"雕塑雕刻",@"金属工艺",@"文玩设计",@"玉石琥珀",@"游泳池",@"沙龙活动",@"古风首饰",@"服装裁剪",@"以物易物",@"亲子手工",@"护肤美妆",@"人形娃娃",@"拼布",@"滴胶热缩圈",@"首饰",@"串珠",@"手帐",@"金工",@"绕线", nil];
    for (int i = 0; i < array.count; i ++) {
        GPHandPulicController *pulicVc = [[GPHandPulicController alloc]init];
        pulicVc.title = array[i];
        [self addChildViewController:pulicVc];
    }
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
