//
//  GPSlideSuperController.m
//  GPHandMade
//
//  Created by dandan on 16/6/6.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSlideSuperController.h"
#import "GPTitleBtn.h"
#import "GPslide.h"
#import "MJExtension.h"
#import "GPHttpTool.h"
#import "GPSlideShopData.h"
#import "GPSlideCollectionViewCell.h"
#import "GPJianDaoHeader.h"
#import "SVProgressHUD.h"
#import "GPAutoFooter.h"
#import "GPEventNewController.h"

@interface GPSlideSuperController ()
@property (nonatomic, copy) NSString *handID; // 记录点击轮播的参数
@property (nonatomic, copy) NSString *lastId; // 标记
@property (nonatomic, strong) NSMutableArray *DataS; // 请求数据模型数组

@end

static NSString * const GPShopCell = @"shopCell";

@implementation GPSlideSuperController

#pragma mark - 初始化方法
- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = SCREEN_WIDTH * 0.43;
    layout.itemSize = CGSizeMake(W, W * 1.25);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self regisCell];
    [self loadData];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 懒加载
- (NSMutableArray *)DataS
{
    if (!_DataS) {
        
        _DataS = [[NSMutableArray alloc] init];
    }
    return _DataS;
}
// 注册cell
- (void)regisCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"GPSlideCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:GPShopCell];
}
#pragma mark - 数据处理
- (void)setSlide:(GPslide *)slide
{
    _slide = slide;
    self.handID = slide.hand_id;
}
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
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Competition";
    params[@"a"] = @"getOpus";
    params[@"cid"] = self.handID;
    params[@"order"] = self.paramA;
    params[@"vid"] = @"16";
    __weak typeof(self) weakSelf = self;
    
    [self.DataS removeAllObjects];
    // 2.发起请求
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        
        weakSelf.DataS = [GPSlideShopData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        GPSlideShopData *eventData = [weakSelf.DataS lastObject];
        self.lastId = eventData.last_id;
        [self.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)loadMoreData
{
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Competition";
    params[@"a"] = @"getOpus";
    params[@"cid"] = self.handID;
    params[@"order"] = self.paramA;
    params[@"vid"] = @"16";
    params[@"last_opus_id"] = self.lastId;
    __weak typeof(self) weakSelf = self;
    
    // 2.发起请求
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        
        NSArray *moreNewArray = [GPSlideShopData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        
        GPSlideShopData *eventData = [moreNewArray lastObject];
        self.lastId = eventData.last_id;
        
        [weakSelf.DataS addObjectsFromArray:moreNewArray];
        [self.collectionView reloadData];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
    }];
}
#pragma mark - collectionView 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return self.DataS.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GPSlideCollectionViewCell *shopCell = [collectionView dequeueReusableCellWithReuseIdentifier:GPShopCell forIndexPath:indexPath];
    shopCell.shopData = self.DataS[indexPath.row];
    return shopCell;
}

@end
