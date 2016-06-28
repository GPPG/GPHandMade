//
//  GPEventController.m
//  GPHandMade
//
//  Created by dandan on 16/6/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEventController.h"
#import "GPEventData.h"
#import "GPEventCell.h"
#import "GPJianDaoHeader.h"
#import "GPAutoFooter.h"
#import "GPHttpTool.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "GPSlideEventController.h"
#import "XWCoolAnimator.h"

static NSString * const EventId = @"eventCell";

@interface GPEventController ()
@property (nonatomic,strong) NSMutableArray *eventDataS;
@property (nonatomic, copy) NSString *lastId;
@end

@implementation GPEventController
#pragma mark - 懒加载
- (NSMutableArray *)eventDataS
{
    if (!_eventDataS) {
        
        _eventDataS = [[NSMutableArray alloc] init];
    }
    return _eventDataS;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self regisCell];
    [self loadData];
}
- (void)regisCell
{
    self.tableView.rowHeight = SCREEN_HEIGHT * 0.35;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPEventCell class]) bundle:nil] forCellReuseIdentifier:EventId];
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
    params[@"c"] = @"Course";
    params[@"a"] = @"activityList";
    params[@"vid"] = @"18";
    __weak typeof(self) weakSelf = self;
        // 2.发起请求
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        
        weakSelf.eventDataS = [GPEventData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        GPEventData *eventData = [weakSelf.eventDataS lastObject];
        weakSelf.lastId = eventData.id;
        [self.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"失败了,赶紧跑"];
        NSLog(@"%@",error);
    }];
    
}
- (void)loadMoreData
{
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Course";
    params[@"a"] = @"activityList";
    params[@"vid"] = @"18";
    params[@"id"] = self.lastId;
    __weak typeof(self) weakSelf = self;
    
    // 2.发起请求
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        
        NSArray *moreNewArray = [GPEventData mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
        
        GPEventData *eventData = [moreNewArray lastObject];
        self.lastId = eventData.id;
        
        [weakSelf.eventDataS addObjectsFromArray:moreNewArray];
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
    return self.eventDataS.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPEventCell *eventCell = [tableView dequeueReusableCellWithIdentifier:EventId];
    eventCell.eventData = self.eventDataS[indexPath.row];
    return eventCell;
}
#pragma mark - UItableView 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPEventData *evenDa = self.eventDataS[indexPath.row];
    GPSlideEventController *slideVc = [[GPSlideEventController alloc]init];
    slideVc.handId = evenDa.c_id;
    [self.navigationController pushViewController:slideVc animated:YES];
}


@end
