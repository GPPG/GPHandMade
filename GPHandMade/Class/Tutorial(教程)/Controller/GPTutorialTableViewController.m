//
//  GPTutorialTableViewController.m
//  GPHandMade
//
//  Created by dandan on 16/5/10.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTutorialTableViewController.h"
#import "GPNavTitleView.h"
#import "GPContainerView.h"
#import "GPTutoriSubController.h"
#import "GPTutoriaVideoController.h"
#import "GPTutorialPicController.h"
#import "GPTopicListController.h"
@interface GPTutorialTableViewController ()
@property (nonatomic, strong) GPTutorialPicController *picVc;
@property (nonatomic, strong) GPTutoriaVideoController *videoVc;
@property (nonatomic, strong) GPTutoriSubController *subVc;
@property (nonatomic, weak) GPNavTitleView *titleView;
@property (nonatomic, strong) NSArray *chidVcArray;
@end

@implementation GPTutorialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavTitleView];
    [self addChildVc];
    [self addConterView];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setGes) name:@"dawang" object:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - 初始化
- (void)addNavTitleView
{
    __weak typeof(self) weakSelf = self;
    GPNavTitleView *titleView = [[GPNavTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.6, 44) block:^(UIButton *button) {
        [weakSelf.containView updateVCViewFromIndex:button.tag];
    }];
    self.titleView = titleView;
    self.navigationItem.titleView = titleView;
}
// 添加子控制器
- (void)addChildVc
{
    self.picVc = [[GPTutorialPicController alloc]init];
    self.videoVc = [[GPTutoriaVideoController alloc]init];
    self.subVc = [[GPTutoriSubController alloc]init];
    self.chidVcArray = @[self.picVc,self.videoVc,self.subVc];
    [self addChildViewController:self.picVc];
    [self addChildViewController:self.videoVc];
    [self addChildViewController:self.subVc];
}
// 添加容器
- (void)addConterView
{
    __weak typeof(self) weakSelf = self;
  self.containView = [[GPContainerView alloc]initWithChildControllerS:self.chidVcArray selectBlock:^(int index) {
      [weakSelf.titleView updateSelecterToolsIndex:index];
    }];
    [self.view addSubview:self.containView];
    self.containView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

//// 手势冲突
//- (void)setGes
//{
//    [self.containView updateVCViewFromIndex:1];
//}

@end
