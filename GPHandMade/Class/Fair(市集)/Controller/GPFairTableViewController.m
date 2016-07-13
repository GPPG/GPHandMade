//
//  GPFairTableViewController.m
//  GPHandMade
//
//  Created by dandan on 16/5/10.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFairTableViewController.h"
#import "GPSuperTiltleView.h"
#import "GPContainerView.h"
#import "GPMeturController.h"
#import "GPFariGoodsController.h"
#import "GPMeturController.h"

@interface GPFairTableViewController ()
@property (nonatomic, strong) GPSuperTiltleView *titleView;
@property (nonatomic, strong) NSArray *childVcArray;

@end

@implementation GPFairTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleView];
    [self addChildVc];
    [self addConterView];
}
- (void)addTitleView
{
    NSArray *titleS = @[@"材料",@"成品"];
    GPSuperTiltleView *titleView = [[GPSuperTiltleView alloc]initWithChildControllerS: titleS];
    self.titleView = titleView;
    self.navigationItem.titleView = titleView;
}
- (void)addChildVc
{
    GPMeturController *meturVc = [[GPMeturController alloc]init];
    GPFariGoodsController *goodsVc = [[GPFariGoodsController alloc]init];
    self.childVcArray = @[meturVc,goodsVc];
    [self addChildViewController:meturVc];
    [self addChildViewController:goodsVc];
}
- (void)addConterView
{
    __weak typeof(self) weakSelf = self;

    GPContainerView *conterView = [[GPContainerView alloc]initWithChildControllerS:self.childVcArray selectBlock:^(int index) {
        [weakSelf.titleView updateSelecterToolsIndex:index];
    }];
    [self.view addSubview:conterView];
    conterView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

@end
