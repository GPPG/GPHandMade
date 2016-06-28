//
//  GPSuperTopicListController.m
//  GPHandMade
//
//  Created by dandan on 16/6/28.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSuperTopicListController.h"
#import "GPJianDaoHeader.h"
#import "GPAutoFooter.h"
#import "GPHttpTool.h"
#import "GPTopListData.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "GPTopicListCell.h"
#import "GPWebViewController.h"

@interface GPSuperTopicListController ()
@property (nonatomic, strong) NSMutableArray *listDataS;
@property (nonatomic,copy) NSString *lastID;
@end

@implementation GPSuperTopicListController

static NSString * const CellID = @"topicListCell";

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self regisCell];
    [self loadData];
}
#pragma mark - 初始化设置
- (void)regisCell
{
    self.tableView.rowHeight = SCREEN_HEIGHT * 0.35;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPTopicListCell class]) bundle:nil] forCellReuseIdentifier:CellID];
}
- (void)setupNav
{
    if (self.navigationController) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
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
    params[@"c"] = @"Shiji";
    params[@"a"] = @"topicListS";
    params[@"vid"] = @"18";
    params[@"page"] = @"material";
    params[@"tag_id"] = self.ifonId;
    __weak typeof(self) weakSelf = self;
    // 2.发起请求
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        
        weakSelf.listDataS = [GPTopListData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        GPTopListData *listData = [weakSelf.listDataS lastObject];
        weakSelf.lastID = listData.last_id;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
        NSLog(@"%@",error);
    }];
    
}
- (void)loadMoreData
{
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Shiji";
    params[@"a"] = @"topicListS";
    params[@"vid"] = @"18";
    params[@"page"] = @"material";
    params[@"tag_id"] = self.ifonId;
    params[@"last_id"] = self.lastID;
    __weak typeof(self) weakSelf = self;
    
    // 2.发起请求
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        
        
        NSArray *moreNewArray = [GPTopListData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        GPTopListData *Data = [moreNewArray lastObject];
        self.lastID = Data.last_id;
        if (!Data.last_id) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        [weakSelf.listDataS addObjectsFromArray:moreNewArray];
        [self.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDataS.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPTopicListCell *listCell = [tableView dequeueReusableCellWithIdentifier:CellID];
    listCell.listData = self.listDataS[indexPath.row];
    return listCell;
}
#pragma mark - UItableview代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPWebViewController *webVc = [UIStoryboard storyboardWithName:NSStringFromClass([GPWebViewController class]) bundle:nil].instantiateInitialViewController;
    webVc.listData = self.listDataS[indexPath.row];
    [self.navigationController pushViewController:webVc animated:YES];
}

@end
