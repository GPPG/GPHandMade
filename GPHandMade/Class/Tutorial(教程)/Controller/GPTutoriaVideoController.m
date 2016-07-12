//
//  GPTutoriaVideoController.m
//  GPHandMade
//
//  Created by dandan on 16/6/30.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTutoriaVideoController.h"
#import "DOPDropDownMenu.h"
#import "GPJianDaoHeader.h"
#import "MJExtension.h"
#import "GPAutoFooter.h"
#import "GPHttpTool.h"
#import "SVProgressHUD.h"
#import "GPTutorialPicCell.h"
#import "GPTutorVideoCell.h"
#import "GPTutorVideoData.h"
#import "GPSlideLessonController.h"

@interface GPTutoriaVideoController ()<DOPDropDownMenuDelegate,DOPDropDownMenuDataSource,UITableViewDelegate,UITableViewDataSource>

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
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) NSString *page; // 标记
@property (nonatomic, strong) NSMutableArray *DataS; // 请求数据模型数组

@property (nonatomic,copy) NSString *cate;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *sort;


@end

@implementation GPTutoriaVideoController
static NSString * const videoCellID = @"tutorVideoCell";
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addchildView];
    [self addMenuData];
    [self addDropMenu];
    [self loadData];
    
    self.cate = @"0";
    self.price = @"0";
    self.sort = @"1";
    self.page = @"2";
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, GPTabBarH + GPTitlesViewH,0);
}

#pragma mark - 初始化
- (void)addchildView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, GPTitlesViewH, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = SCREEN_HEIGHT * 0.4;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPTutorVideoCell class]) bundle:nil] forCellReuseIdentifier:videoCellID];
}
- (void)addMenuData
{
    // 标题
    self.evenythingS = @[@"全部分类",@"两个字",@"三个字",@"四个字"];
    self.twoSizeS = @[@"布艺",@"皮艺",@"纸艺",@"编织",@"饰品",@"木艺",@"刺绣",@"模型"];
    self.thrreSizeS = @[@"羊毛毡",@"橡皮章"];
    self.fourSizeS = @[@"黏土陶艺",@"园艺多肉",@"手绘印刷",@"手工护肤",@"美食烘焙",@"旧物改造",@"滴胶热缩",@"电子科技",@"雕塑雕刻",@"金属工艺"];
    self.timeS = @[@"全部视频",@"免费",@"付费"];
    self.hotS = @[@"最新更新",@"人气",@"收藏最多",@"材料包有售"];
    
    // 图片
    self.evenythingImageS = @[@"sgk_course_cate_all"];
    self.timeImageS = @[@"sgk_course_time_week",@"sgk_course_time_month",@"sgk_course_time_all"];
    self.hotImageS = @[@"sgk_course_sort_new",@"sgk_course_sort_comment",@"sgk_course_sort_collect",@"sgk_course_sort_material"];
}
- (void)addDropMenu
{
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:GPTitlesViewH];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
//    self.tableView.tableHeaderView = menu;
    self.menu = menu;
    // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    [menu selectDefalutIndexPath];
}
#pragma mark - 数据处理
- (void)loadData
{
    // 添加下拉刷新
    GPJianDaoHeader *Header = [self addRefreshHead];
    self.tableView.mj_header = Header;
    // 添加上拉刷新
    self.tableView.mj_footer = [GPAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
    params[@"c"] = @"Handclass";
    params[@"a"] = @"videoList";
    params[@"cate"] = self.cate;
    params[@"page"] = @"1";
    params[@"vid"] = @"18";
    params[@"sort"] = self.sort;
    params[@"price"] = self.price;
    __weak typeof(self) weakSelf = self;
    
    [self.DataS removeAllObjects];
    // 2.发起请求
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {

        weakSelf.DataS = [GPTutorVideoData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        [self.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"外星人来了"];
        NSLog(@"%@",error);
    }];
    
}
- (void)loadMoreData
{
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Handclass";
    params[@"a"] = @"videoList";
    params[@"cate"] = self.cate;
    params[@"page"] = self.page;
    params[@"vid"] = @"18";
    params[@"sort"] = self.sort;
    params[@"price"] = self.price;
    
    __weak typeof(self) weakSelf = self;
    // 2.发起请求
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        
        NSArray *moreNewArray = [GPTutorVideoData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        self.page = [NSString stringWithFormat:@"%d",[self.page intValue] + 1];
        [weakSelf.DataS addObjectsFromArray:moreNewArray];
        [self.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
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
        if (indexPath.row == 1 && indexPath.item >= 0) {
            self.cate =  [NSString stringWithFormat:@"%ld",indexPath.item + 1];
            [self loadData];}
        else if (indexPath.row == 2 && indexPath.item >= 0){
            self.cate =  [NSString stringWithFormat:@"%ld",indexPath.item + 1 + self.twoSizeS.count];
            [self loadData];}
        else if (indexPath.row == 3 && indexPath.item >= 0){
            self.cate =  [NSString stringWithFormat:@"%ld",indexPath.item + 3 + self.twoSizeS.count];
            [self loadData];}
    }else if(indexPath.column == 1){
        if (indexPath.row >= 0) {
            self.price = [NSString stringWithFormat:@"%ld",indexPath.row];
            [self loadData];}
    }else{
        if (indexPath.row >= 0) {
            NSArray *orederS = @[@"1",@"0",@"2",@"3"];
            self.sort = orederS[indexPath.row];
            [self loadData];}
    }
}
#pragma mark - UItableView 的数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataS.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPTutorVideoCell *videoCell = [tableView dequeueReusableCellWithIdentifier:videoCellID];
    videoCell.videoData = self.DataS[indexPath.row];
    return videoCell;
}
#pragma mark - UItableView 的代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPTutorVideoData *videoData = self.DataS[indexPath.row];
    GPSlideLessonController *lessVc = [[GPSlideLessonController alloc]init];
    lessVc.handID = [NSString stringWithFormat:@"%ld",(long)videoData.id];
    [self.navigationController pushViewController:lessVc animated:YES];
}

@end
