//
//  GPFariMeturController.m
//  GPHandMade
//
//  Created by dandan on 16/7/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFariMeturController.h"
#import "GPJianDaoHeader.h"
#import "GPAutoFooter.h"
#import "GPFairHotCell.h"
#import "GPFairBestCell.h"
#import "GPFariTopicCell.h"
#import "GPFariTopicBestCell.h"
#import "GPFariParmer.h"
#import "GPFariData.h"
#import "GPFariHotData.h"
#import "GPFariBestData.h"
#import "GPFariTopicData.h"
#import "GPFariNetwork.h"
#import <SVProgressHUD.h>
#import "GPFairSectionHeadView.h"
#import "GPWebViewController.h"
#import "GPTabBarController.h"
#import "GPMainWebController.h"
#import "GPTopicListController.h"

#define SectionCouton 4

static NSString * const fariId = @"FariCell";
static NSString * const fariBestId = @"FairBestCell";
static NSString * const fariTopicBestId = @"FariTopicBestCell";
static NSString * const fariTopicId = @"FariTopicCell";
static NSString * const fairHeadID = @"FairHeadView";

@interface GPFariMeturController ()
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *bestArray;
@property (nonatomic, strong) NSMutableArray *topicBestArray;
@property (nonatomic, strong) NSMutableArray *topicArray;
@property (nonatomic, copy) NSString *lastId;
@end

@implementation GPFariMeturController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self regisCell];
    [self loadData];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
}
- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [self initWithCollectionViewLayout:layout];
}
#pragma mark - 初始化方法
- (void)regisCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPFairHotCell class]) bundle:nil] forCellWithReuseIdentifier:fariId];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPFairBestCell class]) bundle:nil] forCellWithReuseIdentifier:fariBestId];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPFariTopicBestCell class]) bundle:nil] forCellWithReuseIdentifier:fariTopicBestId];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPFariTopicCell class]) bundle:nil] forCellWithReuseIdentifier:fariTopicId];
    
     [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPFairSectionHeadView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:fairHeadID];

}
#pragma mark - 数据处理
- (void)loadData
{
    // 添加下拉刷新
    GPJianDaoHeader *Header = [self addRefreshHead];
    self.collectionView.mj_header = Header;
    // 添加上拉刷新
    self.collectionView.mj_footer = [GPAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
- (GPJianDaoHeader *)addRefreshHead
{
    // 添加下拉刷新
    GPJianDaoHeader *header = [GPJianDaoHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"小客正在为你刷新" forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    // 设置颜色
    header.stateLabel.textColor = [UIColor  darkGrayColor];
    // 马上进入刷新状态
    [header beginRefreshing];
    return  header;
}

- (void)loadNewData
{
    GPFariParmer *parmers = [[GPFariParmer alloc]init];
    parmers.c = @"Shiji";
    parmers.vid = @"18";
    parmers.a = self.product;
    __weak typeof(self) weakSelf = self;
    [GPFariNetwork fariDataWithParms:parmers success:^(GPFariData *fariData) {
        weakSelf.hotArray = [NSMutableArray arrayWithArray:fariData.hot];
        weakSelf.bestArray = [NSMutableArray arrayWithArray:fariData.best];
        weakSelf.topicBestArray = [NSMutableArray arrayWithArray:fariData.topicBest];
        weakSelf.topicArray = [NSMutableArray arrayWithArray:fariData.topic];
        GPFariTopicData *topicData = weakSelf.topicArray.lastObject;
        weakSelf.lastId = topicData.last_id;
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    } failuer:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"啦啦啦,失败了"];
    }];
}
- (void)loadMoreData
{
    GPFariParmer *parmers = [[GPFariParmer alloc]init];
    parmers.c = @"Shiji";
    parmers.vid = @"18";
    parmers.last_id = self.lastId;
    parmers.a = @"topicList";
    parmers.page = self.page;
    __weak typeof(self) weakSelf = self;
    [GPFariNetwork fariMoreDataWithParms:parmers success:^(NSArray *topicDataS) {
        [weakSelf.topicArray addObjectsFromArray:topicDataS];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_footer endRefreshing];
    } failuer:^(NSError *error) {
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark - UICollectionView 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return SectionCouton;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger rowCount = 0;
    if (section == 0) {
        rowCount = self.hotArray.count;
    }else if (section == 1){
        rowCount = self.bestArray.count;
    }else if (section == 2){
        rowCount = self.topicBestArray.count;
    }else{
        rowCount = self.topicArray.count;
    }
    return rowCount;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        GPFairHotCell *hotCell = [collectionView dequeueReusableCellWithReuseIdentifier:fariId forIndexPath:indexPath];
        hotCell.hotData = self.hotArray[indexPath.row];
        return hotCell;
    }
    else if (indexPath.section == 1){
        GPFairBestCell *bestCell = [collectionView dequeueReusableCellWithReuseIdentifier:fariBestId forIndexPath:indexPath];
        bestCell.bestData = self.bestArray[indexPath.row];
        return bestCell;
        }
    else if (indexPath.section == 2){
        GPFariTopicBestCell *topicBestCell = [collectionView dequeueReusableCellWithReuseIdentifier:fariTopicBestId forIndexPath:indexPath];
        topicBestCell.picStr = self.topicBestArray[indexPath.row];
        return topicBestCell;
    }else{
        GPFariTopicCell *topicCell = [collectionView dequeueReusableCellWithReuseIdentifier:fariTopicId forIndexPath:indexPath];
        topicCell.topicData = self.topicArray[indexPath.row];
        return topicCell;
    }
    return nil;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    GPFairSectionHeadView *headView = headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:fairHeadID forIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        headView.titleStr = @"每日特价";
        headView.subtitleStr = @"每日10:00更新";
    }else if (indexPath.section == 2){
        headView.titleStr = @"精选专题";
        headView.subtitleStr = @"更多";
    }
    return headView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeZero;
    if (section == 1) {
        size = CGSizeMake(SCREEN_WIDTH, GPTitlesViewH);
    }else if (section == 2){
        size = CGSizeMake(SCREEN_WIDTH, GPTitlesViewH);
    }
    return size;
}

#pragma mark - UICollectionView 布局
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    CGFloat W = 0;
    if (indexPath.section == 0) {
        W = SCREEN_WIDTH * 0.2;
        size = CGSizeMake(W, W * 1.4);
    }else if (indexPath.section == 1){
        W = SCREEN_WIDTH * 0.27;
        size = CGSizeMake(W, W * 2);
    }else if (indexPath.section == 2){
        W = SCREEN_WIDTH * 0.27;
        size = CGSizeMake(W, W);
    }else{
        W = SCREEN_WIDTH * 0.94;
        size = CGSizeMake(W, W * 0.6);
    }
    return size;
}

#pragma mark - UICollectionView 代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            GPWebViewController *webVC = [UIStoryboard storyboardWithName:NSStringFromClass([GPWebViewController class]) bundle:nil].instantiateInitialViewController;
            webVC.hotData = self.hotArray[indexPath.row];
            [self.navigationController pushViewController:webVC animated:YES];
        }else{
            GPTabBarController *tabVc = [[GPTabBarController alloc]init];
            tabVc.selectedIndex = 1;
            [UIApplication sharedApplication].keyWindow.rootViewController = tabVc;
        }
    }
    else if (indexPath.section == 1){
        XWCoolAnimator *animator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypePortal];
        GPMainWebController *webVc = [UIStoryboard storyboardWithName:NSStringFromClass([GPMainWebController class]) bundle:nil].instantiateInitialViewController;
        webVc.bestData = self.bestArray[indexPath.row];
        [self xw_presentViewController:webVc withAnimator:animator];
    }
    else if (indexPath.section == 2){
        GPTopicListController *topListVc = [[GPTopicListController alloc]init];
        [self.navigationController pushViewController:topListVc animated:YES];
    }
    else {
        XWCoolAnimator *animator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypePortal];
        GPMainWebController *webVc = [UIStoryboard storyboardWithName:NSStringFromClass([GPMainWebController class]) bundle:nil].instantiateInitialViewController;
        webVc.topicData = self.topicArray[indexPath.row];
        [self xw_presentViewController:webVc withAnimator:animator];
    }
}


@end
