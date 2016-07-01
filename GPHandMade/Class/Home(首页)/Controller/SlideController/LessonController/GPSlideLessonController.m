//
//  GPSlideLessonController.m
//  GPHandMade
//
//  Created by dandan on 16/5/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSlideLessonController.h"
#import "GPslide.h"
#import "GPHttpTool.h"
#import "MJExtension.h"
#import "GPLessonData.h"
#import "SDCycleScrollView.h"
#import "SVProgressHUD.h"
#import "GPSubTitleCell.h"
#import "GPContentCell.h"
#import "GPUserCell.h"
#import "GPAppraiseData.h"
#import "GPOtherClass.h"
#import "GPFooterAppraiseCell.h"
#import "GPFooterClassCell.h"
#import "GPLessonHeadView.h"
#import "SDPhotoBrowser.h"

@interface GPSlideLessonController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,SDPhotoBrowserDelegate>
@property (nonatomic, strong) GPLessonData *lessonData; // 课程模型
@property (nonatomic, strong) NSMutableArray *lessonS; // 课程内容
@property (nonatomic, strong) NSMutableArray *otherCalssS; // 其他课程模型
@property (nonatomic, strong) NSMutableArray *appraiseS; // 评论模型
@property (nonatomic, weak) UICollectionView *footerView;
@property (nonatomic, weak) SDCycleScrollView *cycleScorllView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation GPSlideLessonController
static NSString * const GPSubCell = @"subCell";
static NSString * const GPConCell = @"contentCell";
static NSString * const GPUseCell = @"userCell";
static NSString * const GPOtherClassCell = @"otherClassCell";
static NSString * const GPAppraiseCell = @"AppraiseCell";
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self congigNav];
    [self addFooterView];
    [self regisCell];
    
    // 点击图片的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTimer) name:ClickPhoto object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - 懒加载
- (NSMutableArray *)otherCalssS
{
    if (!_otherCalssS) {
        
        _otherCalssS = [[NSMutableArray alloc] init];
    }
    return _otherCalssS;
}
- (NSMutableArray *)appraiseS
{
    if (!_appraiseS) {
        
        _appraiseS = [[NSMutableArray alloc] init];
    }
    return _appraiseS;
}
#pragma mark - 初始化设置
-(void)congigNav
{
    self.navigationItem.title = @"买买买 ";
}
-(void)regisCell
{
    self.footerView.directionalLockEnabled = NO;
    self.tableView.estimatedRowHeight = 100;  //  随便设个不那么离谱的值
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPSubTitleCell class]) bundle:nil] forCellReuseIdentifier:GPSubCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPContentCell class]) bundle:nil] forCellReuseIdentifier:GPConCell];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPUserCell class]) bundle:nil] forCellReuseIdentifier:GPUseCell];
    
    [self.footerView registerNib:[UINib nibWithNibName:NSStringFromClass([GPFooterAppraiseCell class]) bundle:nil] forCellWithReuseIdentifier:GPAppraiseCell];
    [self.footerView registerNib:[UINib nibWithNibName:NSStringFromClass(    [GPFooterClassCell class]) bundle:nil] forCellWithReuseIdentifier:GPOtherClassCell];

    [self.footerView registerNib:[UINib nibWithNibName:NSStringFromClass([GPLessonHeadView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];

}
// 启动定时器
-(void)loadTimer
{
    [self.cycleScorllView setupTimer];
}
#pragma mark - 数据处理
- (void)setSlideData:(GPslide *)slideData
{
    _slideData = slideData;
    self.handID = slideData.hand_id;
   }
- (void)loadData
{
    [SVProgressHUD showWithStatus:@"玩命加载中"];
    // 1.添加请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Handclass";
    params[@"a"] = @"Course_details";
    params[@"vid"] = @"16";
    params[@"id"] = self.handID;
    __weak typeof(self) weakSelf = self;
    // 2.请求数据
    [GPHttpTool get:HomeBaseURl params:params success:^(id responseObj) {
        // 获得课程模型,并添加轮播图
        weakSelf.lessonData = [GPLessonData mj_objectWithKeyValues:responseObj[@"data"]];
        [weakSelf lessonTechData];
        [weakSelf.tableView reloadData];
        [weakSelf AddSDCycleView];
        
        // 获得其他课程模型,评论模型,添加footer
        for (GPOtherClass *otherClass in weakSelf.lessonData.other_class) {
            [weakSelf.otherCalssS addObject:otherClass];
        }
        for (GPAppraiseData *appraise in weakSelf.lessonData.appraise) {
            [weakSelf.appraiseS addObject:appraise];
        }
        [weakSelf.footerView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}
- (void)lessonTechData
{
    NSString *teachIn = self.lessonData.content;
    NSString *time = [NSString stringWithFormat:@"上课时间:  %@",self.lessonData.start_time];
    NSString *address = [NSString stringWithFormat:@"上课地点:  %@",self.lessonData.address];
    NSString *peopleCoutn = [NSString stringWithFormat:@"上课人数:  %@-%@",self.lessonData.people_min,self.lessonData.people_max];
    NSString *metarials = [NSString stringWithFormat:@"材料包:  包括材料和工具等"];
    NSString *deadLine = [NSString stringWithFormat:@"报名截止:  %@",self.lessonData.deadline];
    self.lessonS = [NSMutableArray arrayWithObjects:teachIn,time,address,peopleCoutn,metarials,deadLine, nil];
}
#pragma mark - 初始化子控件
- (void)AddSDCycleView
{
    // 创建轮播图
    CGFloat cycleX = 0;
    CGFloat cycleY = GPNavBarBottom;
    CGFloat cycleW = SCREEN_WIDTH;
    CGFloat cycleH = SCREEN_HEIGHT * 0.25;
    CGRect rect = CGRectMake(cycleX, cycleY, cycleW, cycleH);
    SDCycleScrollView *cycleScorllView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:[UIImage imageNamed:@"2"]];
    cycleScorllView.imageURLStringsGroup = self.lessonData.pic;
    self.cycleScorllView = cycleScorllView;
    self.tableView.tableHeaderView = cycleScorllView;
}
- (void)addFooterView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    UICollectionView *footerView = [[UICollectionView alloc]initWithFrame: CGSCREEN collectionViewLayout:flowLayout];
    footerView.backgroundColor = [UIColor whiteColor];
    footerView.delegate = self;
    footerView.dataSource = self;
    self.footerView = footerView;
    self.tableView.tableFooterView = footerView;
}
#pragma mark - SDcyleView 代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [cycleScrollView invalidateTimer];
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc]init];
    browser.currentImageIndex = index;
    browser.imageCount = self.lessonData.pic.count;
    browser.delegate = self;
    [browser show];
}
#pragma mark - SDPhotoBrowserDelegate
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.lessonData.pic[index];
    NSURL *url = [NSURL URLWithString:imageName];
    return url;
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    for (UIView *view in self.cycleScorllView.mainView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)view;
            self.imageView = imageView;
        }
    }
    return self.imageView.image;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0) {
        GPSubTitleCell *subTitleCell = [tableView dequeueReusableCellWithIdentifier:GPSubCell];
        subTitleCell.lessonData = self.lessonData;
        return subTitleCell;
    }else if (indexPath.row == 7){
        GPUserCell *userCell = [tableView dequeueReusableCellWithIdentifier:GPUseCell];
        userCell.lessonData = self.lessonData;
        return userCell;
    }else{
        GPContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:GPConCell];
        if (self.lessonS.count != 0) {
            contentCell.ContentStr = self.lessonS[indexPath.row - 1];
        }
        return contentCell;
    }
}
#pragma mark - UIcollectionView 布局
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGFloat W = self.view.width * 0.43;
        return CGSizeMake(W, W * 1.2);
    }else{
        return CGSizeMake(SCREEN_WIDTH, 100);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
#pragma mark - UICollectionView 代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GPSlideLessonController *ss = [[GPSlideLessonController alloc]init];
        GPOtherClass *otherClass = self.otherCalssS[indexPath.row];
        ss.handID = otherClass.id;
        [self.navigationController pushViewController:ss animated:YES];
    }
}
#pragma mark - UIcollectionView 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.otherCalssS.count;
    }else{
        return self.appraiseS.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GPFooterClassCell *classCell = [collectionView dequeueReusableCellWithReuseIdentifier:GPOtherClassCell forIndexPath:indexPath];
        classCell.otherClass = self.otherCalssS[indexPath.row];
        return classCell;
    }else{
        GPFooterAppraiseCell *appraiseCell = [collectionView dequeueReusableCellWithReuseIdentifier:GPAppraiseCell forIndexPath:indexPath];
        
        UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        selectView.backgroundColor = [UIColor lightGrayColor];
        appraiseCell.selectedBackgroundView = selectView;
        
        appraiseCell.appraiseData = self.appraiseS[indexPath.row];
        return appraiseCell;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headView" forIndexPath:indexPath];
        return view;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CGSize size=CGSizeMake(SCREEN_WIDTH, 45);
        return size;
    }else{
        return CGSizeZero;
    }
}

@end
