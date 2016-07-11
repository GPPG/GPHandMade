//
//  GPHandPulicController.m
//  GPHandMade
//
//  Created by dandan on 16/7/6.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHandPulicController.h"
#import "GPJianDaoHeader.h"
#import "GPAutoFooter.h"
#import "GPHttpTool.h"
#import "GPHandPulicData.h"
#import "GPHandListData.h"
#import "SVProgressHUD.h"
#import "GPTimeLineHeadCell.h"
#import "GPHandPicData.h"
#import "UITableView+SDAutoTableViewCellHeight.h"


@interface GPHandPulicController()
@property (nonatomic, strong) NSMutableArray *DataS; // 请求数据模型数组

@end
@implementation GPHandPulicController
static NSString * const handCell = @"handCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self regisCell];
    [self loadData];
}
#pragma mark - 初始化
- (void)regisCell
{
    [self.tableView registerClass:[GPTimeLineHeadCell class] forCellReuseIdentifier:handCell];
}
#pragma mark - 数据处理
- (void)loadData
{
    // 添加下拉刷新
    GPJianDaoHeader *Header = [self addRefreshHead];
    self.tableView.mj_header = Header;
    // 添加上拉刷新
//    self.tableView.mj_footer = [GPAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
    params[@"c"] = @"HandCircle";
    params[@"a"] = @"list";
    params[@"order"] = @"hot";
    params[@"vid"] = @"18";
    params[@"cate_id"] = @"1";

    __weak typeof(self) weakSelf = self;
    [self.DataS removeAllObjects];
    // 2.发起请求
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"json" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        responseObj = dic;
        GPHandPulicData *pulicData = [GPHandPulicData mj_objectWithKeyValues:responseObj[@"data"]];
        weakSelf.DataS = [NSMutableArray arrayWithArray:pulicData.list];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"外星人来了"];
        NSLog(@"%@",error);
    }];
}
#pragma mark - UITableView 数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *picArray = [NSMutableArray array];
    NSMutableArray *picSizeArray = [NSMutableArray array];
    
    GPTimeLineHeadCell *lineCell = [tableView dequeueReusableCellWithIdentifier:handCell];
    GPHandListData *listData = self.DataS[indexPath.row];
    for (GPHandPicData *picData in listData.pic) {
        [picArray addObject:picData.url];
    }
    if (listData.pic.count == 1) {
        picSizeArray = [NSMutableArray arrayWithObjects:@"200",@"150", nil];
        lineCell.sizeArray = picSizeArray;
    }
    lineCell.listData = listData;
    lineCell.picUrlArray = picArray;
    return lineCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH];
}
@end

