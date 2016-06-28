
//
//  GPFocusController.m
//  GPHandMade
//
//  Created by dandan on 16/6/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFocusController.h"
#import "GPFocusCell.h"
#import "GPLayout.h"
static NSString * const fouceCell = @"focusCell";
@interface GPFocusController ()
@property (nonatomic,strong) NSArray *iconArray;
@property (nonatomic,strong) NSArray *contenImageArray;
@property (nonatomic,strong) NSArray *nameArray;
@property (nonatomic,strong) NSArray *contenArray;
@end

@implementation GPFocusController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self regisCell];
    [self loadData];
    self.collectionView.backgroundColor = GPCommonBgColor;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, GPTabBarH, 0);
}
- (instancetype)init
{
    // 弹簧布局
    GPLayout *layout = [[GPLayout alloc] init];
    CGFloat W = SCREEN_WIDTH - 20;
    CGFloat H = SCREEN_HEIGHT * 0.3;
    layout.itemSize = CGSizeMake(W, H);
    return [self initWithCollectionViewLayout:layout];
}
#pragma mark - 初始化
- (void)regisCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPFocusCell class]) bundle:nil] forCellWithReuseIdentifier:fouceCell];
}
#pragma mark - 数据处理
- (void)loadData
{
    NSArray * iconArray = @[@"001",@"002",@"003",@"004",@"005"];
    self.iconArray = iconArray;
    NSArray *contenImageArray = @[@"01",@"02",@"03",@"04",@"05"];
    self.contenImageArray = contenImageArray;
    NSArray *nameArray = @[@"我是小菜蛋对你点赞了",@"我是小菜蛋关注了你",@"我是小菜蛋求你赏个赞呗",@"我是小菜蛋求你给个关注呗",@"我是小菜蛋祝你发大财"];
    self.nameArray = nameArray;
    NSArray *contenArray = @[@"哈哈哈哈,下拉&点击有惊喜呀,要不要试一试呢",@"暗恋的女孩告诉我，如果我喜欢她就别说出来，因为愿望说出来就不灵了。这道理我懂!",@"你现在不喜欢我，我告诉你，过了这个村，我在下一个村等你!!",@"我姓黄，又在秋天出生，所以我叫黄天出",@"哈哈哈,上拉&点击也有惊喜"];
    self.contenArray = contenArray;
    [self.collectionView reloadData];
}
#pragma mark -  UIcollectionView数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GPFocusCell *fCell = [collectionView dequeueReusableCellWithReuseIdentifier:fouceCell forIndexPath:indexPath];
    fCell.iconStr  = self.iconArray[indexPath.section];
    fCell.imageStr = self.contenImageArray[indexPath.section];
    fCell.nameStr = self.nameArray[indexPath.section];
    fCell.contenStr = self.contenArray[indexPath.section];
    return fCell;
}
#pragma mark - UIcollectionView 代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 3) {
        [self openUrl:Blog];
    }else{
        [self openUrl:Github];
    }
}
#pragma mark - 内部方法
- (void)openUrl:(NSString *)urlStr
{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}
@end
