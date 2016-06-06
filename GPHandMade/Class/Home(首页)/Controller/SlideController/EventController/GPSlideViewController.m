//
//  GPSlideViewController.m
//  GPHandMade
//
//  Created by dandan on 16/5/21.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSlideViewController.h"
#import "GPTitleBtn.h"
#import "GPslide.h"
#import "MJExtension.h"
#import "GPHttpTool.h"
#import "GPSlideShopData.h"
#import "GPSlideCollectionViewCell.h"
#import "GPJianDaoHeader.h"
#import "SVProgressHUD.h"
#import "GPAutoFooter.h"

#define ChildCoutn 3
#define TTBAR 104
@interface GPSlideViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) GPTitleBtn *selectedTitleButton; // 被选中的按钮
@property (nonatomic, weak) UIScrollView *nScroll; // 底部 scroll
@property (nonatomic, strong) NSMutableArray *titleBtnArray; // 按钮
@property (nonatomic, weak) UIView *titleIndicatorView; // 指示器
@property (nonatomic, strong) NSArray *titleArray; // 按钮标题
@property (nonatomic, strong) NSURLRequest *eventRequest; // 首页请求
@property (nonatomic, strong) UICollectionView *neColltioView; // 展示newColltionView
@property (nonatomic, strong) UICollectionView *voteColltioView; //展示voteColltionView
@property (nonatomic, copy) NSString *handID; // 记录点击轮播的参数
@property (nonatomic, strong) NSMutableArray *nDataS; // 请求数据模型数组
@property (nonatomic, strong) NSMutableArray *voteDataS; // 请求数据模型数组
@property (nonatomic, copy) NSString *lastNewId; // 标记
@property (nonatomic, copy) NSString *lastVoteId; // 标记

@end

static NSString * const GPShopCell = @"shopCell";

@implementation GPSlideViewController
#pragma mark - 懒加载
- (NSMutableArray *)titleBtnArray
{
    if (!_titleBtnArray) {
        
        _titleBtnArray = [[NSMutableArray alloc] init];
    }
    return _titleBtnArray;
}
- (NSArray *)titleArray
{
    if (!_titleArray) {
        
        _titleArray = [NSArray arrayWithObjects:@"活动介绍",@"最新作品",@"投票最多", nil];
    }
    return _titleArray;
}
#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化导航栏
    [self setupNav];
    // 添加UIScrollview
    [self setupScrollView];
    // 添加标题栏
    [self setupTitleView];
    // 添加View
    [self addChildView];
    // 加载数据
    [self loadData];
    // 注册 collectionCell
    [self regisCell];
}
// 初始化导航栏
- (void)setupNav
{
    self.navigationItem.title = @"活动作品";
    
}
- (void)setSlide:(GPslide *)slide
{
    _slide = slide;
    
    NSString *eventStr = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?c=Competition&cid=%@",slide.hand_id];
    self.eventRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:eventStr]];
    
    self.handID = slide.hand_id;
}
// 添加UIScrollview
- (void)setupScrollView
{
    
    UIScrollView *nScroll = [[UIScrollView alloc]init];
    nScroll.tag = 8888;
    nScroll.contentSize = CGSizeMake(ChildCoutn * SCREEN_WIDTH, 0);
    nScroll.showsHorizontalScrollIndicator = NO;
    nScroll.showsVerticalScrollIndicator = NO;
    nScroll.frame = self.view.bounds;
    nScroll.backgroundColor = [UIColor redColor];
    nScroll.pagingEnabled = YES;
    nScroll.bounces = NO;
    nScroll.delegate = self;
    nScroll.contentInset = UIEdgeInsetsMake(TTBAR, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.nScroll = nScroll;
    [self.view addSubview:nScroll];
}
// 添加标题栏
- (void)setupTitleView
{
    // 添加标题
    
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, GPNavBarBottom, self.view.width, GPTitlesViewH);
    titleView.backgroundColor = GPCommonBgColor;
    [self.view addSubview:titleView];
    
    // 添加标题按钮
    NSInteger Btncount = ChildCoutn;
    CGFloat BtnW = self.view.bounds.size.width / Btncount;
    CGFloat BtnH = titleView.height;
    for (int i = 0; i < Btncount; i ++) {
        GPTitleBtn *titleBtn = [[GPTitleBtn alloc] init];
        titleBtn.tag = i;
        [self.titleBtnArray addObject:titleBtn];
        [titleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [titleBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        titleBtn.frame = CGRectMake(i *BtnW, 0, BtnW, BtnH);
        [titleView addSubview:titleBtn];
    }
    
    GPTitleBtn *firstBtn = titleView.subviews.firstObject;
    // 添加指示器
    UIView *titleIndicatorView = [[UIView alloc] init];
    titleIndicatorView.backgroundColor = [UIColor orangeColor];
    titleIndicatorView.height = 2;
    titleIndicatorView.bottom = titleView.height;
    self.titleIndicatorView = titleIndicatorView;
    
    
    titleIndicatorView.width = SCREEN_WIDTH / ChildCoutn;
    titleIndicatorView.centerX = firstBtn.centerX;
    [titleView addSubview:titleIndicatorView];
    // 默认选选中按钮
    firstBtn.selected = YES;
    self.selectedTitleButton = firstBtn;
    
}
// 注册cell
- (void)regisCell
{
    [self.neColltioView registerNib:[UINib nibWithNibName:@"GPSlideCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:GPShopCell];
    [self.voteColltioView registerNib:[UINib nibWithNibName:@"GPSlideCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:GPShopCell];

}
#pragma mark - 数据处理
- (void)loadData
{
    // 添加下拉刷新
    GPJianDaoHeader *neHeader = [self addRefreshHead];
    GPJianDaoHeader *voteHeader = [self addRefreshHead];
    self.voteColltioView.mj_header = neHeader;
    self.neColltioView.mj_header = voteHeader;
    // 添加上拉刷新
    self.voteColltioView.mj_footer = [GPAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.neColltioView.mj_footer = [GPAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
    [SVProgressHUD showWithStatus:@"正在加载数据"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    for (int i = 0; i < 2; i ++) {
        NSString *order;
        if (i == 0) {
            order = @"new";
        }
        else{
            order = @"votes";
        }
        // 1.添加参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"c"] = @"Competition";
        params[@"a"] = @"getOpus";
        params[@"cid"] = self.handID;
        params[@"order"] = order;
        params[@"vid"] = @"16";
        __weak typeof(self) weakSelf = self;
       
        // 2.发起请求
        [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
            if (i == 0) {
                [SVProgressHUD dismiss];
                weakSelf.nDataS = [GPSlideShopData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
                GPSlideShopData *eventData = [weakSelf.nDataS lastObject];
                self.lastNewId = eventData.last_id;
                [self.neColltioView reloadData];
                [weakSelf.neColltioView.mj_header endRefreshing];

            }else{
                weakSelf.voteDataS = [GPSlideShopData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
                GPSlideShopData *eventData = [weakSelf.voteDataS lastObject];
                self.lastVoteId = eventData.last_id;
                [self.voteColltioView reloadData];
                [weakSelf.voteColltioView.mj_header endRefreshing];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
        }];
    }
}
- (void)loadMoreData
{
     for (int i = 0; i < 2; i ++) {
        NSString *order;
         NSString *lastId;
        if (i == 0) {
            order = @"new";
            lastId = self.lastNewId;
        }
        else{
            order = @"votes";
            lastId = self.lastVoteId;
        }
        // 1.添加参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"c"] = @"Competition";
        params[@"a"] = @"getOpus";
        params[@"cid"] = self.handID;
        params[@"order"] = order;
        params[@"vid"] = @"16";
        params[@"last_opus_id"] = lastId;
        __weak typeof(self) weakSelf = self;
        
        // 2.发起请求
        [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
            if (i == 0) {
                NSArray *moreNewArray = [GPSlideShopData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
                
                GPSlideShopData *eventData = [moreNewArray lastObject];
                self.lastNewId = eventData.last_id;
                NSLog(@"%@-----%lu",self.lastNewId,(unsigned long)moreNewArray.count);

                [weakSelf.nDataS addObjectsFromArray:moreNewArray];
                [self.neColltioView reloadData];
                [weakSelf.neColltioView.mj_footer endRefreshing];
            }else{
                 NSArray *moreVoteArray = [GPSlideShopData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
                GPSlideShopData *eventData = [moreVoteArray lastObject];
                self.lastVoteId = eventData.last_id;
                [weakSelf.voteDataS addObjectsFromArray:moreVoteArray];
                [self.voteColltioView reloadData];
                [weakSelf.voteColltioView.mj_footer endRefreshing];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
        }];
    }

    
}
#pragma mark - 添加主view
- (void)titleBtnClick:(GPTitleBtn *)titleBtn
{
    
    // 切换按钮的状态
    self.selectedTitleButton.selected = NO;
    titleBtn.selected = YES;
    self.selectedTitleButton = titleBtn;
    // 移动指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.titleIndicatorView.width = titleBtn.width;
        self.titleIndicatorView.centerX = titleBtn.centerX;
    }];
    // 切换控制器的View
    CGPoint offset = self.nScroll.contentOffset;
    offset.x = titleBtn.tag * self.nScroll.width;
    // 判断刷新那个数据
     int newVote = offset.x / self.nScroll.width;
    if (newVote == 1) {
        [self.neColltioView reloadData];
    }else{
        [self.voteColltioView reloadData];
    }
    [self.nScroll setContentOffset:offset animated:YES];
}
- (void)addChildView
{
    UIScrollView *scrollView = self.nScroll;
    for (int i = 0; i < ChildCoutn; i ++) {
        UIView *childView = [[UIView alloc]initWithFrame:CGRectMake(i *scrollView.width, 0, scrollView.width, scrollView.height)];
        if (i == 0) {
            UIWebView *webView = [[UIWebView alloc]initWithFrame:CGSCREEN];
            [webView loadRequest:self.eventRequest];
            [childView addSubview:webView];
        }else{
          UICollectionView *slideCollectionView = [self addCollectionViewtype:i];
        // 创建布局
        [childView addSubview:slideCollectionView];
        }
        [scrollView addSubview:childView];
    }
}
- (UICollectionView *)addCollectionViewtype:(int)type
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = self.view.width * 0.43;
    layout.itemSize = CGSizeMake(W, W * 1.25);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    if (type == 1) {
        UICollectionView *newView = [[UICollectionView alloc]initWithFrame:CGSCREEN collectionViewLayout:layout];
        newView.backgroundColor = [UIColor whiteColor];
        newView.delegate = self;
        newView.dataSource = self;
        self.neColltioView = newView;
        return newView;
    }else{
        UICollectionView *votView = [[UICollectionView alloc]initWithFrame:CGSCREEN collectionViewLayout:layout];
        votView.backgroundColor = [UIColor whiteColor];
        votView.delegate = self;
        votView.dataSource = self;
        self.voteColltioView = votView;
        return votView;
    }
}
#pragma mark - collectionView 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:self.nDataS]) {
        return self.nDataS.count;
    }else{
        return self.voteDataS.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GPSlideCollectionViewCell *shopCell = [collectionView dequeueReusableCellWithReuseIdentifier:GPShopCell forIndexPath:indexPath];
    [shopCell removeFromSuperview];
    if ([collectionView isEqual:self.neColltioView]) {
        shopCell.shopData = self.nDataS[indexPath.row];
    }
    else{
        shopCell.shopData = self.voteDataS[indexPath.row];
    }
    return shopCell;
}
#pragma mark - UIScrollview的代理方法
// 停止拖拽的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.nScroll.contentOffset.x / self.nScroll.width;
    GPTitleBtn *titleBtn = self.titleBtnArray[index];
    [self titleBtnClick:titleBtn];
}
@end
