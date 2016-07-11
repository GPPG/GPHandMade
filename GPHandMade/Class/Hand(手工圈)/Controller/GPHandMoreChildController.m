//
//  GPHandMoreChildController.m
//  GPHandMade
//
//  Created by dandan on 16/7/6.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHandMoreChildController.h"
#import "LXReorderableCollectionViewFlowLayout.h"
#import "GPHandMoreCell.h"
#import "GPHandMoreHeadView.h"
#import "GPHandDataTool.h"
#define ZeroRemark @"ZeroName"
#define OneRemark @"OneName"
#define ONEName @"moreName"
#define ONEStr @"moreStr"

@interface GPHandMoreChildController()<LXReorderableCollectionViewDataSource,LXReorderableCollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *moreArrray;
@property (nonatomic, strong) NSMutableArray *zeroArray;
@property (nonatomic, strong) NSMutableArray *classStrArray;
@property (nonatomic, strong) NSMutableArray *ZeroStrArray;

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, assign) CGFloat endPoint_x;
@property (nonatomic, assign) CGFloat endPoint_y;
@property (nonatomic, strong) UILabel *tileLabel;
@end
@implementation GPHandMoreChildController
#define CellSize CGSizeMake((SCREEN_WIDTH - 5 * 10) * 0.25, GPTitlesViewH)
static NSString * const HandMoreId = @"HandMoreCell";
static NSString * const HandMoreHeadId = @"HandMoreHead";
#pragma mark - 生命周期
- (instancetype)init
{
    CGFloat margin = 10;
    // 流水布局
    LXReorderableCollectionViewFlowLayout *layout = [[LXReorderableCollectionViewFlowLayout alloc] init];
    // 设置cell的尺寸
    layout.itemSize = CellSize;
    // 设置每一行的间距
    layout.minimumLineSpacing = margin;
    // 设置每个cell的间距
    layout.minimumInteritemSpacing = margin;
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addMoreData];
    [self regisCell];
    [self setupNav];
    [self addpopBtn];
}
#pragma mark - 初始化方法
- (void)addMoreData
{
    self.moreArrray = [NSMutableArray arrayWithObjects:@"综合圈",@"布艺",@"皮艺",@"木艺",@"编织",@"饰品",@"文艺",@"刺绣",@"模型",@"羊毛毡",@"橡皮章",@"黏土陶艺",@"园艺多肉",@"手绘印刷",@"手工护肤",@"美食烘焙",@"旧物改造",@"滴胶热缩",@"电子科技",@"雕塑雕刻",@"金属工艺",@"文玩设计",@"玉石琥珀",@"游泳池",@"沙龙活动",@"古风首饰",@"服装裁剪",@"以物易物",@"亲子手工",@"护肤美妆",@"人形娃娃",@"拼布",@"滴胶热缩圈",@"首饰",@"串珠",@"手帐",@"金工",@"绕线", nil];
    self.classStrArray = [NSMutableArray arrayWithObjects:@"QHAND",@"WHAND", @"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",@"QHAND",nil];
    
    self.zeroArray = [NSMutableArray arrayWithObjects:@"手工课官方", nil];
    self.ZeroStrArray = [NSMutableArray arrayWithObjects:@"GPHandPulicController", nil];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [GPHandDataTool saveItemArray:self.moreArrray remark:OneRemark type:self.classStrArray];
        [GPHandDataTool saveZeroArray:self.zeroArray remark:ZeroRemark type:self.ZeroStrArray];
    });
}
- (void)setupNav
{
    self.title = @"编辑圈子";
    self.collectionView.backgroundColor = GPCommonBgColor;
}
- (void)regisCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPHandMoreCell class]) bundle:nil] forCellWithReuseIdentifier:HandMoreId];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPHandMoreHeadView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HandMoreHeadId];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger rowCoutn = 1;
    if (section == 1) {
        rowCoutn = [GPHandDataTool list:ONEName].count;
    }else{
        rowCoutn = [GPHandDataTool zeroList:ONEName].count;
    }
    return rowCoutn;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GPHandMoreCell *handMoreCell = [collectionView dequeueReusableCellWithReuseIdentifier:HandMoreId forIndexPath:indexPath];
        if (indexPath.section == 0) {
                handMoreCell.titleStr = [GPHandDataTool zeroList:ONEName][indexPath.row];
            handMoreCell.picSelect.hidden = NO;
    }else{
        handMoreCell.titleStr = [GPHandDataTool list:ONEName][indexPath.row];
        handMoreCell.picSelect.hidden = YES;
    }
    return handMoreCell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSArray *headArray = @[@"  长按拖动排序",@"  点击添加更多圈子 长按拖动排序"];
    GPHandMoreHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HandMoreHeadId forIndexPath:indexPath];
    view.headStr = headArray[indexPath.section];
    return view;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size=CGSizeMake(SCREEN_WIDTH, 45);
    return size;

}

#pragma mark - UICollectionView 代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GPHandMoreCell *cell = (GPHandMoreCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.section == 1) {
        NSMutableArray *nameS = [GPHandDataTool list:ONEName];
        NSString *nameStr = nameS[indexPath.row];
        [nameS removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *strS = [GPHandDataTool list:ONEStr];
        NSString *strStr = strS[indexPath.row];
        [strS removeObjectAtIndex:indexPath.row];
        [GPHandDataTool updateItemArray:nameS strArray:strS remark:OneRemark];
        
        NSMutableArray *zeroNameS = [GPHandDataTool zeroList:ONEName];
        [zeroNameS addObject:nameStr];
        
        NSMutableArray *zeroStrS = [GPHandDataTool zeroList:ONEStr];
        [zeroStrS addObject:strStr];
        [GPHandDataTool updateZeroArray:zeroNameS strArray:zeroStrS remark:ZeroRemark];
        [self addAnimationLabel:indexPath and:cell];
        self.collectionView.userInteractionEnabled = NO;
    }
    
}

#pragma mark - LXReorderableCollectionViewDataSource methods
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath {
    if (fromIndexPath.section == 1 && toIndexPath.section == 1) {
        NSMutableArray *nameS = [GPHandDataTool list:ONEName];
        NSString *str = nameS[fromIndexPath.item];
        [nameS removeObjectAtIndex:fromIndexPath.item];
        [nameS insertObject:str atIndex:toIndexPath.item];
        
        NSMutableArray *strS = [GPHandDataTool list:ONEStr];
        NSString *n = nameS[fromIndexPath.item];
        [strS removeObjectAtIndex:fromIndexPath.item];
        [strS insertObject:n atIndex:toIndexPath.item];
        [GPHandDataTool updateItemArray:nameS strArray:strS remark:OneRemark];
    }else{
        NSMutableArray *zeroNameS = [GPHandDataTool zeroList:ONEName];
        NSString *zerostr = zeroNameS[fromIndexPath.item];
        [zeroNameS removeObjectAtIndex:fromIndexPath.item];
        [zeroNameS insertObject:zerostr atIndex:toIndexPath.item];
        
        NSMutableArray *zeroS = [GPHandDataTool zeroList:ONEStr];
        NSString *zeroSss = zeroS[fromIndexPath.item];
        [zeroS removeObjectAtIndex:fromIndexPath.item];
        [zeroS insertObject:zeroSss atIndex:toIndexPath.item];
        [GPHandDataTool updateZeroArray:zeroNameS strArray:zeroS remark:ZeroRemark];
    }
}
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath {
    if (fromIndexPath.section == 0 && toIndexPath.section == 1) {
        return NO;
    }else if (fromIndexPath.section == 1 && toIndexPath.section == 0){
        return NO;
    }else if(fromIndexPath.section == 0 && toIndexPath.section == 0){
        if (toIndexPath.row == 0) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

#pragma mark - 内部方法
// 返回按钮
- (void)addpopBtn
{
    UIButton *popBtn = [[UIButton alloc]init];
    [popBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    popBtn.frame = CGRectMake(SCREEN_WIDTH - GPTitlesViewH, 0, GPTitlesViewH, GPTitlesViewH);
    [self.collectionView addSubview:popBtn];
    [popBtn addTarget:self action:@selector(popBtn:) forControlEvents:UIControlEventTouchUpInside];
}
// 返回按钮点击
- (void)popBtn:(UIButton *)popBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.BtnClick) {
        self.BtnClick();
    }
}
// 添加动画
- (void)addAnimationLabel:(NSIndexPath *)indexPath and:(GPHandMoreCell *)cell
{
    self.tileLabel = [[UILabel alloc]init];
    NSString *titleStr = self.moreArrray[indexPath.row];
    self.tileLabel.text = titleStr;
    self.tileLabel.frame = cell.frame;
    self.tileLabel.backgroundColor = [UIColor whiteColor];
    self.tileLabel.textAlignment = NSTextAlignmentCenter;
    [self.collectionView addSubview:self.tileLabel];
    [self addSelectAnimationWithRect:cell.frame];
}
#pragma mark - 添加动画方法
-(void) addSelectAnimationWithRect:(CGRect)rect
{
    NSMutableArray *endArray = [GPHandDataTool zeroList:ONEName];
    _endPoint_x = ((endArray.count - 1) % 4) * ((SCREEN_WIDTH - 5 * 10) * 0.25 + 15);
    _endPoint_y = ((endArray.count - 1) / 4) * (GPTitlesViewH + 10);
    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
    
    _path= [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    
    //三点曲线
    [_path addQuadCurveToPoint:CGPointMake(_endPoint_x, _endPoint_y) controlPoint:CGPointMake(startX, _endPoint_y)];
//    [_path addCurveToPoint:CGPointMake(_endPoint_x, _endPoint_y) controlPoint1:CGPointMake(startX, startY + SCREEN_HEIGHT) controlPoint2:CGPointMake(startX, startY)];
    
  
    [self groupAnimation];
}
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.8f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [self.tileLabel.layer addAnimation:groups forKey:nil];
    [self performSelector:@selector(removeFrom) withObject:nil afterDelay:0.8f];
}
- (void)removeFrom
{
    [self.tileLabel removeFromSuperview];
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.collectionView reloadData];
    self.collectionView.userInteractionEnabled = YES;
}

@end
