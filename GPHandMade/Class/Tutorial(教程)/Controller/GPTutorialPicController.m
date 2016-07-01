//
//  GPTutorialPicController.m
//  GPHandMade
//
//  Created by dandan on 16/6/30.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTutorialPicController.h"
#import "DOPDropDownMenu.h"
#import "GPJianDaoHeader.h"
#import "MJExtension.h"
#import "GPAutoFooter.h"
#import "GPHttpTool.h"
#import "GPTutoriaPicData.h"
#import "SVProgressHUD.h"
#import "GPTutorialPicCell.h"
#import "GPDaRenPicController.h"

@interface GPTutorialPicController ()<DOPDropDownMenuDelegate,DOPDropDownMenuDataSource>
@property (nonatomic, strong) DOPDropDownMenu *menu;
@property (nonatomic, strong) NSArray *evenythingS;
@property (nonatomic, strong) NSArray *twoSizeS;
@property (nonatomic, strong) NSArray *thrreSizeS;
@property (nonatomic, strong) NSArray *fourSizeS;
@property (nonatomic, strong) NSArray *timeS;
@property (nonatomic, strong) NSArray *hotS;
@property (nonatomic, strong) NSArray *evenythingImageS;
@property (nonatomic, strong) NSArray *timeImageS;
@property (nonatomic, strong) NSArray *hotImageS;

@property (nonatomic, copy) NSString *lastId; // 标记
@property (nonatomic, strong) NSMutableArray *DataS; // 请求数据模型数组
@property (nonatomic, copy) NSString *cateId;
@property (nonatomic, copy) NSString *gacate;
@property (nonatomic, copy) NSString *pubtime;
@property (nonatomic, copy) NSString *oreder;

@end

@implementation GPTutorialPicController

static NSString * const reuseIdentifier = @"TpicCell";
#pragma mark - 生命周期
- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = SCREEN_WIDTH * 0.43;
    layout.itemSize = CGSizeMake(W, W * 1.5);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self regisCell];
    [self addMenuData];
    [self addDropMenu];
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.collectionView.contentInset = UIEdgeInsetsMake(GPTitlesViewH, 0, GPTabBarH,0);
}
#pragma mark - 初始化方法
- (void)regisCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPTutorialPicCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.gacate = @"allcate";
    self.oreder = @"hot";
}
- (void)addMenuData
{
    // 标题
    self.evenythingS = @[@"全部分类",@"两个字",@"三个字",@"四个字"];
    self.twoSizeS = @[@"布艺",@"皮艺",@"纸艺",@"编织",@"饰品",@"木艺",@"刺绣",@"模型"];
    self.thrreSizeS = @[@"羊毛毡",@"橡皮章"];
    self.fourSizeS = @[@"黏土陶艺",@"园艺多肉",@"手绘印刷",@"手工护肤",@"美食烘焙",@"旧物改造",@"滴胶热缩",@"电子科技",@"雕塑雕刻",@"金属工艺"];
    self.timeS = @[@"一周",@"一月",@"全部教程"];
    self.hotS = @[@"最热教程",@"最新更新",@"评论最多",@"收藏最多",@"材料包有售",@"成品有售"];
    
    // 图片
    self.evenythingImageS = @[@"sgk_course_cate_all"];
    self.timeImageS = @[@"sgk_course_time_week",@"sgk_course_time_month",@"sgk_course_time_all"];
    self.hotImageS = @[@"sgk_course_sort_new",@"sgk_course_sort_hot",@"sgk_course_sort_comment",@"sgk_course_sort_collect",@"sgk_course_sort_material",@"sgk_course_sort_product"];
    
}
- (void)addDropMenu
{
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:GPTitlesViewH];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    self.menu = menu;
    // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    [menu selectDefalutIndexPath];
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
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Course";
    params[@"a"] = @"newCourseList";
    params[@"gcate"] = self.gacate;
    params[@"order"] = self.oreder;
    params[@"vid"] = @"18";
    params[@"cate_id"] = self.cateId;
    params[@"pub_time"] = self.pubtime;
    __weak typeof(self) weakSelf = self;
    
    [self.DataS removeAllObjects];
    // 2.发起请求
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        
        weakSelf.DataS = [GPTutoriaPicData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        GPTutoriaPicData *picData = [weakSelf.DataS lastObject];
        self.lastId = picData.last_id;
        [self.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"外星人来了"];
        NSLog(@"%@",error);
    }];
    
}
- (void)loadMoreData
{
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Course";
    params[@"a"] = @"newCourseList";
    params[@"gcate"] = self.gacate;
    params[@"order"] = self.oreder;
    params[@"vid"] = @"18";
    params[@"cate_id"] = self.cateId;
    params[@"last_id"] = self.lastId;
    params[@"pub_time"] = self.pubtime;

    __weak typeof(self) weakSelf = self;
    
    // 2.发起请求
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        
        NSArray *moreNewArray = [GPTutoriaPicData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        
        GPTutoriaPicData *picData = [moreNewArray lastObject];
        if (!picData.last_id) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        self.lastId = picData.last_id;
        [weakSelf.DataS addObjectsFromArray:moreNewArray];
        [self.collectionView reloadData];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.DataS.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPTutorialPicCell *Piccell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Piccell.picData = self.DataS[indexPath.row];
    return Piccell;
}
#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GPTutoriaPicData *pData = self.DataS[indexPath.row];
    XWCoolAnimator *animator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeFoldFromRight];
    GPDaRenPicController *picVc = [[GPDaRenPicController alloc]init];
    picVc.tagCpunt = pData.hand_id;
    [self xw_presentViewController:picVc withAnimator:animator];}
#pragma mark - DDDorp 数据源
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu;
{
    return 3;
}
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column;
{
    if (column == 0) {
        return self.evenythingS.count;
    }else if (column == 1){
        return self.timeS.count;
    }else{
        return self.hotS.count;
    }
}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath;
{
    if (indexPath.column == 0) {
        return self.evenythingS[indexPath.row];
    }else if (indexPath.column == 1){
        return self.timeS[indexPath.row];
    }else{
        return self.hotS[indexPath.row];
    }
}
- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath;
{
    if (indexPath.column == 0) {
        return self.evenythingImageS[0];
    }else if (indexPath.column == 1){
        return self.timeImageS[indexPath.row];
    }else{
        return self.hotImageS[indexPath.row];
    }
}
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column;
{
    if (column == 0) {
        if (row == 1) {
            return self.twoSizeS.count;
        }else if (row == 2){
            return self.thrreSizeS.count;
        }else if (row == 3){
            return self.fourSizeS.count;
        }
    }
    return 0;
}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath;
{
    if (indexPath.column == 0) {
        if (indexPath.row == 1) {
            return self.twoSizeS[indexPath.item];
        }else if (indexPath.row == 2){
            return self.thrreSizeS[indexPath.item];
        }else if (indexPath.row == 3){
            return self.fourSizeS[indexPath.item];
        }
    }
    return nil;
}
- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath;
{
    if(indexPath.column == 0){
        if (indexPath.item >= 0) {
            return @"sgk_course_cate_cixiubianzhi";
        }
    }
    return nil;
}
#pragma mark - DDDrop 代理
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        self.gacate = @"cate";
        if (indexPath.row == 1 && indexPath.item >= 0) {
            self.cateId =  [NSString stringWithFormat:@"%ld",indexPath.item + 1];
            [self loadData];
        }else if (indexPath.row == 2 && indexPath.item >= 0){
            self.cateId =  [NSString stringWithFormat:@"%ld",indexPath.item + 1 + self.twoSizeS.count];
            [self loadData];
        }else if (indexPath.row == 3 && indexPath.item >= 0){
            self.cateId =  [NSString stringWithFormat:@"%ld",indexPath.item + 3 + self.twoSizeS.count];
            NSLog(@"%@",self.cateId);
            [self loadData];}
    }else if(indexPath.column == 1){
        if (indexPath.row == 1) {
            self.pubtime = @"month";
            [self loadData];
        }else if (indexPath.row == 2){
            self.pubtime = @"all";
            [self loadData];}
    }else{
        if (indexPath.row >= 0) {
            NSArray *orederS = @[@"hot",@"new",@"comment",@"collect",@"material",@"goods"];
            self.oreder = orederS[indexPath.row];
            [self loadData];
        }
    }
}
@end
