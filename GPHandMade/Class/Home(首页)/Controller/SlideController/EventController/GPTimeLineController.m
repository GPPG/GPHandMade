//
//  GPTimeLineController.m
//  PYQ
//
//  Created by dandan on 16/6/16.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTimeLineController.h"
#import "GPHttpTool.h"
#import "GPTimeLineData.h"
#import "GPTimeLineLaudData.h"
#import "GPTimeLinePicData.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "GPTimeLineCommentData.h"
#import "GPTimeLIneCommentCell.h"
#import "GPTimeLineEventCell.h"
#import "GPTimeLineApperCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "GPTimeLineHeadCell.h"
#import "GPLoginController.h"
#import "HYBEaseInOutTransition.h"

@interface GPTimeLineController ()
@property (nonatomic, strong) GPTimeLineData *timeLineData;
@property (nonatomic, strong) NSMutableArray *picUrlS; // 九宫格图片
@property (nonatomic, strong) NSArray *commentS; // 评论数组
@property (nonatomic, strong) NSMutableArray *laudUrlS; // 点赞图片
@property (nonatomic,strong) NSMutableArray *sizeArray;
@property (nonatomic, strong) HYBEaseInOutTransition *transition;

@property (nonatomic, strong) GPTimeLineCommentData *commentData;
@end
static NSString * const EventCell = @"eventCell";
static NSString * const ApperCell = @"apperCell";
static NSString * const CommentCell = @"CommentCell";
static NSString * const HeadCell = @"headCell";
@implementation GPTimeLineController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self regisCell];
    [self configThame];
    [self loadData];
    self.title = @"我的作品";
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
#pragma mark - 懒加载
- (NSMutableArray *)picUrlS
{
    if (!_picUrlS) {
        
        _picUrlS = [[NSMutableArray alloc] init];
    }
    return _picUrlS;
}
- (NSMutableArray *)laudUrlS
{
    if (!_laudUrlS) {
        
        _laudUrlS = [[NSMutableArray alloc] init];
    }
    return _laudUrlS;
}
- (NSMutableArray *)sizeArray
{
    if (!_sizeArray) {
        
        _sizeArray = [[NSMutableArray alloc] init];
    }
    return _sizeArray;
}
#pragma mark - 初始化
- (void)regisCell
{
    [self.tableView registerClass:[GPTimeLineHeadCell class] forCellReuseIdentifier:HeadCell];
    [self.tableView registerClass:[GPTimeLineEventCell class] forCellReuseIdentifier:EventCell];
    [self.tableView registerClass:[GPTimeLineApperCell class] forCellReuseIdentifier:ApperCell];
    [self.tableView registerClass:[GPTimeLIneCommentCell class] forCellReuseIdentifier:CommentCell];
}
- (void)configThame
{
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - 数据处理
- (void)loadData
{
    // 1.添加请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"HandCircle";
    params[@"a"] = @"info";
    params[@"vid"] = @"18";
    params[@"item_id"] = self.circleID;
    __weak typeof(self) weakSelf = self;
    // 2.请求数据
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        
        weakSelf.timeLineData = [GPTimeLineData mj_objectWithKeyValues:responseObj[@"data"]];
        // 九宫格图片
        for (GPTimeLinePicData *PicData in weakSelf.timeLineData.pic) {
            [weakSelf.picUrlS addObject:PicData.url];
        }
        // 只有一张图片的尺寸
        GPTimeLinePicData *picFistData = weakSelf.timeLineData.pic.firstObject;
        [weakSelf.sizeArray addObjectsFromArray:@[picFistData.width,picFistData.height]];
        
        // 点赞头像
        for (GPTimeLineLaudData *laudData in weakSelf.timeLineData.laud_list) {
            [weakSelf.laudUrlS addObject:laudData.avatar];
        }

        // 评论
        weakSelf.commentS = weakSelf.timeLineData.comment;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"小编出差了"];
    }];
}
#pragma mark - 内部方法

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger sectionRow = 1;
    if (section == 3) {
        sectionRow = self.commentS.count;
    }
    return sectionRow;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GPTimeLineHeadCell *headLineCell = [tableView dequeueReusableCellWithIdentifier:HeadCell];
        headLineCell.sizeArray = self.sizeArray;
        headLineCell.timeLineData = self.timeLineData;
        headLineCell.picUrlArray = self.picUrlS;
        return headLineCell;
    }else if(indexPath.section == 1){
        GPTimeLineEventCell *timeEventCell = [tableView dequeueReusableCellWithIdentifier:EventCell];
            timeEventCell.lineData = self.timeLineData;
        timeEventCell.EventBtnClick = ^{
            [self eventBtnClcik];
        };
        timeEventCell.backgroundColor = [UIColor whiteColor];
            return timeEventCell;
    }else if (indexPath.section == 2){
        GPTimeLineApperCell *timeApperCell = [tableView dequeueReusableCellWithIdentifier:ApperCell];
                timeApperCell.laudnum = self.timeLineData.laud_num;
                timeApperCell.laudArray = self.laudUrlS;
                return timeApperCell;
    }else{
        GPTimeLIneCommentCell *timeCommentCell = [tableView dequeueReusableCellWithIdentifier:CommentCell];
                timeCommentCell.commentData = self.timeLineData.comment[indexPath.row];
                return timeCommentCell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH];
}
#pragma mark - 内部方法
- (void)eventBtnClcik
{
    GPLoginController *loginVc = [UIStoryboard storyboardWithName:@"GPLoginController" bundle:nil].instantiateInitialViewController;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
    self.transition = [[HYBEaseInOutTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
        HYBEaseInOutTransition *modal = (HYBEaseInOutTransition *)transition;
        
        modal.animatedWithSpring = YES;
    } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
        // do nothing
    }];
    
    nav.transitioningDelegate = self.transition;
    [self presentViewController:nav animated:YES completion:NULL];

}

@end
