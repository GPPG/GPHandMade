//
//  GPDaRenPicController.m
//  GPHandMade
//
//  Created by dandan on 16/6/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDaRenPicController.h"
#import "GPDaRenStepOneCell.h"
#import "GPDaRenStepTwoCell.h"
#import "GPDaRenStepThreeCell.h"
#import "GPHttpTool.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "GPDaRenPicData.h"
#import "XWCoolAnimator.h"
#import "GPDaRenPicsController.h"

@interface GPDaRenPicController ()
@property (nonatomic, strong) GPDaRenPicData *picData;
@property (nonatomic, strong) NSArray *stepArray;
@property (nonatomic, strong) NSArray *stepToolsArray;
@property (nonatomic, strong) NSArray *stepMaetasArray;
@property (nonatomic, strong) NSArray *stepPicArray;


@end

@implementation GPDaRenPicController

static NSString * const OneIdentifier = @"StepOneCell";
static NSString * const TwoIdentifier = @"StepTwoCell";
static NSString * const TheerIdentifier = @"StepThreenCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self regisCell];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scroolCollection:) name:DaRenStep object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - 初始化
- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =[UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [self initWithCollectionViewLayout:layout];
}
- (void)setupNav
{
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    UIButton *disBtn = [[UIButton alloc]init];
    [disBtn setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    disBtn.frame = CGRectMake(5, 25, 20, 20);
    [disBtn addTarget:self action:@selector(disBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionView addSubview:disBtn];
}
- (void)regisCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenStepOneCell class]) bundle:nil] forCellWithReuseIdentifier:OneIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenStepTwoCell class]) bundle:nil] forCellWithReuseIdentifier:TwoIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenStepThreeCell class]) bundle:nil] forCellWithReuseIdentifier:TheerIdentifier];
}
- (void)loadData
{
        // 1.添加参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"c"] = @"Course";
        params[@"a"] = @"CourseDetial";
        params[@"vid"] = @"18";
        params[@"id"] = self.tagCpunt;
        
        __weak typeof(self) weakSelf = self;
        // 2.发起请求
        [GPHttpTool get:HomeBaseURl params:params success:^(id responder) {
            weakSelf.picData = [GPDaRenPicData mj_objectWithKeyValues:responder[@"data"]];
            
            weakSelf.stepArray = weakSelf.picData.step;
            weakSelf.stepToolsArray = weakSelf.picData.tools;
            weakSelf.stepMaetasArray = weakSelf.picData.material;
            weakSelf.stepPicArray = weakSelf.picData.step;
            
            [weakSelf.collectionView reloadData];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"跪了"];
        }];
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger row = 1;
    if (section == 2) {
       row = self.stepArray.count;
    }
    return row;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *collecTionCell = nil;
    if (indexPath.section == 0) {
        GPDaRenStepOneCell *oneCell = [collectionView dequeueReusableCellWithReuseIdentifier:OneIdentifier forIndexPath:indexPath];
        oneCell.picData = self.picData;
        collecTionCell = oneCell;
    }else if (indexPath.section == 1){
        GPDaRenStepTwoCell *twoCell = [collectionView dequeueReusableCellWithReuseIdentifier:TwoIdentifier forIndexPath:indexPath];
        twoCell.toolsArray = self.stepToolsArray;
        twoCell.materiaArray = self.stepMaetasArray;
        collecTionCell = twoCell;
    }else{
        GPDaRenStepThreeCell *threeCell = [collectionView dequeueReusableCellWithReuseIdentifier:TheerIdentifier forIndexPath:indexPath];
        threeCell.sumNum = self.stepPicArray.count;
        threeCell.currentNum = indexPath.row + 1;
        threeCell.setpData = self.stepPicArray[indexPath.row];
        threeCell.setpBtnClick = ^{
            [self setpPicBtnClick];
        };
        collecTionCell = threeCell;
    }
    return collecTionCell;
}
#pragma mark - 内部方法
- (void)disBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setpPicBtnClick
{
    XWCoolAnimator *animator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypePageFlip];
    GPDaRenPicsController *picsVc = [[GPDaRenPicsController alloc]init];
    picsVc.stepDataArray = self.stepPicArray;
    picsVc.picData = self.picData;
    [self xw_presentViewController:picsVc withAnimator:animator];
}
-(void)scroolCollection:(NSNotification *)ifno
{
    
    NSLog(@"%@",ifno.userInfo[@"pic"]);
    NSIndexPath *indexPath = ifno.userInfo[@"pic"];
    
    CGPoint point = CGPointMake((indexPath.row + 2) * SCREEN_WIDTH, 0);
    [self.collectionView setContentOffset:point];
}
@end
