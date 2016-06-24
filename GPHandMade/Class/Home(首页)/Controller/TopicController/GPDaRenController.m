//
//  GPDaRenController.m
//  GPHandMade
//
//  Created by dandan on 16/6/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDaRenController.h"
#import "GPJianDaoHeader.h"
#import "GPAutoFooter.h"
#import "GPHttpTool.h"
#import "SVProgressHUD.h"
#import "GPDaData.h"
#import "MJExtension.h"
#import "GPDarenCell.h"

static NSString * const GPDaCellID = @"GPDaRenCell";

@interface GPDaRenController ()
@property (nonatomic, strong) NSMutableArray *daRenArray;
@property (nonatomic, copy) NSString *lastTimeId;
@end

@implementation GPDaRenController
#pragma mark - 懒加载
- (NSMutableArray *)daRenArray
{
    if (!_daRenArray) {
        
        _daRenArray = [[NSMutableArray alloc] init];
    }
    return _daRenArray;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    [self regisCell];
    [self loadData];
}
- (void)regisCell
{
    self.tableView.rowHeight = 200;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDarenCell class]) bundle:nil] forCellReuseIdentifier:GPDaCellID];
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
    params[@"act"] = @"up";
    params[@"vid"] = @"18";
    [self.daRenArray removeAllObjects];
    
    __weak typeof(self) weakSelf = self;
    // 2.发起请求
    [GPHttpTool post:@"http://m.shougongke.com/index.php?&c=Index&a=daren" params:params success:^(id responder) {
        weakSelf.daRenArray = [GPDaData mj_objectArrayWithKeyValuesArray:responder[@"data"]];
        GPDaData *dadata = weakSelf.daRenArray.lastObject;
        weakSelf.lastTimeId = dadata.course_time;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
           } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"跪了"];
    }];
}
- (void)loadMoreData
{
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"act"] = @"down";
    params[@"vid"] = @"18";
    params[@"last_id"] = self.lastTimeId;
    __weak typeof(self) weakSelf = self;
    
    // 2.发起请求
    [GPHttpTool post:@"http://m.shougongke.com/index.php?&c=Index&a=daren" params:params success:^(id responseObj) {
        NSArray *moreNewArray = [GPDaData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        GPDaData *dadata = moreNewArray.lastObject;
        weakSelf.lastTimeId = dadata.course_time;
        [weakSelf.daRenArray addObjectsFromArray:moreNewArray];
        [self.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
    }];
}
#pragma mark - UItableView 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.daRenArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPDarenCell *daRenCell = [tableView dequeueReusableCellWithIdentifier:GPDaCellID];
    
    daRenCell.daData = self.daRenArray[indexPath.row];
    return daRenCell;
}
#pragma mark - UItableView 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
