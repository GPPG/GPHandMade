//
//  GPFeaturedController.m
//  GPHandMade
//
//  Created by dandan on 16/6/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFeaturedController.h"

#import "GPHttpTool.h"
#import "SDCycleScrollView.h"
#import "SVProgressHUD.h"
#import "GPData.h"
#import "MJExtension.h"
#import "GPslide.h"
#import "GPActivityData.h"
#import "GPSalonData.h"
#import "GPDynamicData.h"
#import "GPCompetitionData.h"
#import "GPLookCell.h"
#import "GPHotCell.h"
#import "GPRecommendCell.h"
#import "GPHotData.h"
#import "GPWebViewController.h"
#import "GPSlideViewController.h"
#import "GPSlideLessonController.h"
#import "MJRefresh.h"
#import "GPJianDaoHeader.h"
#import "GPNavigationCell.h"
#import "GPAdvanceCell.h"
#import "GPNavigationData.h"
#import "GPAdvanceDtata.h"
#import "GPSlideHeadView.h"
#import "GPSectionHeadView.h"


@interface GPFeaturedController ()<SDCycleScrollViewDelegate>
@property (strong,nonatomic) NSMutableArray *dataSlideArray; // 轮播图片数组
@property (strong,nonatomic) NSMutableArray *dataSlideS; // 轮播图数组

@property (nonatomic, strong) NSMutableArray *dataHotArray; // 热帖数组
@property (strong,nonatomic) NSMutableArray *dataAdvanceArray; // 推荐数组
@property (strong,nonatomic) NSMutableArray *dataNavigationArray; // 图标数组

@property (nonatomic, strong) SDCycleScrollView *cycleScorllView;

@property (strong,nonatomic) GPData *data;
@end

static NSString * const GPAdvance = @"AdvanceCell";
static NSString * const GPHot = @"HotCell";
static NSString * const GPNavigation = @"NavigationCell";
static NSString * const GPSlideHead = @"SlideHeadView";
static NSString * const GPSectionHead = @"HotSectionCell";


@implementation GPFeaturedController
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self configNav];
    // 加载数据
    [self loadData];
    // 注册 cell
    [self regisCell];

}

#pragma mark - 懒加载
- (NSMutableArray *)dataSlideArray
{
    if (!_dataSlideArray) {
        
        _dataSlideArray = [[NSMutableArray alloc] init];
    }
    return _dataSlideArray;
}
- (NSMutableArray *)dataHotArray
{
    if (!_dataHotArray) {
        
        _dataHotArray = [[NSMutableArray alloc] init];
    }
    return _dataHotArray;
}
- (NSMutableArray *)dataSlideS
{
    if (!_dataSlideS) {
        
        _dataSlideS = [[NSMutableArray alloc] init];
    }
    return _dataSlideS;
}
- (NSMutableArray *)dataAdvanceArray
{
    if (!_dataAdvanceArray) {
        
        _dataAdvanceArray = [[NSMutableArray alloc] init];
    }
    return _dataAdvanceArray;
}
- (NSMutableArray *)dataNavigationArray
{
    if (!_dataNavigationArray) {
        
        _dataNavigationArray = [[NSMutableArray alloc] init];
    }
    return _dataNavigationArray;
}
#pragma mark - 初始化方法
- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    return [self initWithCollectionViewLayout:layout];
}
- (void)configNav
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, GPTabBarH, 0);

}

- (void)regisCell
{    // 注册 cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPNavigationCell class]) bundle:nil]forCellWithReuseIdentifier:GPNavigation];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPAdvanceCell class]) bundle:nil] forCellWithReuseIdentifier:GPAdvance];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPHotCell class]) bundle:nil] forCellWithReuseIdentifier:GPHot];
    // 注册 headView
    [self.collectionView registerClass:[GPSlideHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GPSlideHead];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPSectionHeadView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GPSectionHead];
}
#pragma mark - 数据处理
- (void)loadData
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
    // 设置header
    self.collectionView.mj_header = header;
    
    
}
-(void)loadNewData
{
    [SVProgressHUD showWithStatus:@"正在加载数据"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"index";
    params[@"a"] = @"indexNewest";
    params[@"vid"] = @"18";
    
    __weak typeof(self) weakSelf = self;
    [self.dataSlideS removeAllObjects];
    [self.dataHotArray removeAllObjects];
    [self.dataSlideArray removeAllObjects];
    [self.dataNavigationArray removeAllObjects];
    [self.dataAdvanceArray removeAllObjects];
    // 2.发起请求
    [GPHttpTool get:@"http://m.shougongke.com/index.php" params:params success:^(id responseObj) {
        [SVProgressHUD dismiss];
        // 字典转模型
        self.data = [GPData mj_objectWithKeyValues:responseObj[@"data"]];
        // 轮播图数组
        for (GPslide *slide in self.data.slide) {
            [weakSelf.dataSlideArray addObject:slide.host_pic];
            [weakSelf.dataSlideS addObject:slide];
        }
        // 添加轮播图
        [self AddSDCycleView];
        // 热帖数组
        for (GPHotData *hotData in self.data.hotTopic) {
            [weakSelf.dataHotArray addObject:hotData];
        }
        // 图标数组
        for (GPNavigationData *navigationData in self.data.navigation) {
            [weakSelf.dataNavigationArray addObject:navigationData];
        }
        [weakSelf.dataNavigationArray addObject:[self addQianDaoData]];
        // 推荐数组
        for (GPAdvanceData *advanceData in self.data.advance) {
            [weakSelf.dataAdvanceArray addObject:advanceData];
        }
        [weakSelf.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [weakSelf.collectionView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"失败了,再来一次"];
    }];
    
}
// 添加签到模型
- (GPNavigationData *)addQianDaoData
{
    GPNavigationData *QianDaoData = [[GPNavigationData alloc]init];
    QianDaoData.pic = @"http://image.shougongke.com/app/index/navigation/appIndexNav12.png";
    QianDaoData.name = @"签到";
    return QianDaoData;
    
}
#pragma mark - 内部方法
- (void)AddSDCycleView
{
    // 创建轮播图
    CGFloat cycleX = 0;
    CGFloat cycleY = 0;
    CGFloat cycleW = SCREEN_WIDTH;
    CGFloat cycleH = SCREEN_HEIGHT * 0.25;
    CGRect rect = CGRectMake(cycleX, cycleY, cycleW, cycleH);
    SDCycleScrollView *cycleScorllView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:[UIImage imageNamed:@"2"]];
    self.cycleScorllView = cycleScorllView;
    self.cycleScorllView.imageURLStringsGroup = self.dataSlideArray;
}
#pragma mark - 轮播图的代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    GPslide *slide = self.dataSlideS[index];
    if ([slide.itemtype isEqualToString: @"class_special"] || [slide.itemtype isEqualToString:@"topic_detail_h5"]) {
        GPWebViewController *webVC = [UIStoryboard storyboardWithName:NSStringFromClass([GPWebViewController class]) bundle:nil].instantiateInitialViewController;
        webVC.slide = slide;
        [self.navigationController pushViewController:webVC animated:YES];
    }else if([slide.itemtype isEqualToString: @"event"]){
        GPSlideViewController *slideVC = [[GPSlideViewController alloc]init];
        slideVC.slide = slide;
        [self.navigationController pushViewController:slideVC animated:YES];
    }else if ([slide.itemtype isEqualToString:@"web_out"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:slide.hand_id]];
    }
    else{
        GPSlideLessonController *lessVc = [[GPSlideLessonController alloc]init];
        lessVc.slideData = slide;
        [self.navigationController pushViewController:lessVc animated:YES];
    }
}
#pragma mark - UIcollectionView 布局
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGFloat W = SCREEN_WIDTH / (self.dataNavigationArray.count + 0.8);
        return CGSizeMake(W, W);
    }else if(indexPath.section == 1)
    {
        return CGSizeMake(SCREEN_WIDTH * 0.48,SCREEN_WIDTH * 0.4);
    }else{
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH * 0.5);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

#pragma mark - UICollectionView 代理
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    GPSlideLessonController *ss = [[GPSlideLessonController alloc]init];
//    GPOtherClass *otherClass = self.otherCalssS[indexPath.row];
//    ss.handID = otherClass.id;
//    [self.navigationController pushViewController:ss animated:YES];
//}
#pragma mark - UIcollectionView 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return NumberSection;;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataNavigationArray.count;
    }else if (section == 1){
        return  self.dataAdvanceArray.count;
    }else{
        return  self.dataHotArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GPNavigationCell *navgationCell = [collectionView dequeueReusableCellWithReuseIdentifier:GPNavigation forIndexPath:indexPath];
        navgationCell.navgationData = self.dataNavigationArray[indexPath.row];
        return navgationCell;
    }else if(indexPath.section == 1){
        GPAdvanceCell *advanceCell = [collectionView dequeueReusableCellWithReuseIdentifier:GPAdvance forIndexPath:indexPath];
        advanceCell.advanceData = self.dataAdvanceArray[indexPath.row];
        return advanceCell;
    }else{
        GPHotCell *hotCell = [collectionView dequeueReusableCellWithReuseIdentifier:GPHot forIndexPath:indexPath];
        hotCell.hotdata = self.dataHotArray[indexPath.row];
        return hotCell;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headView = nil;
    if (indexPath.section == 0) {
        headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:GPSlideHead forIndexPath:indexPath];
        [headView addSubview:self.cycleScorllView];
    }else if (indexPath.section == 2){
        headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:GPSectionHead forIndexPath:indexPath];
    }
      return headView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeZero;
    if (section == 0) {
         size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT *0.25);
    }else if (section == 2){
        size = CGSizeMake(SCREEN_WIDTH, GPTitlesViewH);
    }
    return size;
}
@end
