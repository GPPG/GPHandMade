
//
//  GPDaRenPicsController.m
//  GPHandMade
//
//  Created by dandan on 16/6/26.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDaRenPicsController.h"
#import "GPDaRenStepData.h"
#import "GPDaRenPicsCell.h"
#import "GPDaRenPicController.h"

@interface GPDaRenPicsController ()

@end

@implementation GPDaRenPicsController

static NSString * const reuseIdentifier = @"PicsCell";
#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPDaRenPicsCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
}
- (instancetype)init
{
    CGFloat margin = 10;
    // 流水布局
    CGFloat W = (SCREEN_WIDTH - 4 * margin) / 3;
    CGFloat H = W * 1.5;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =CGSizeMake(W, H);
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return [self initWithCollectionViewLayout:layout];
}
#pragma mark - 数据处理
- (void)setStepDataArray:(NSArray *)stepDataArray
{
    _stepDataArray = stepDataArray;
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stepDataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GPDaRenPicsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.picData = self.picData;
    cell.stepData = self.stepDataArray[indexPath.row];
    cell.currtnNum = indexPath.row + 1;
    return cell;
}
#pragma mark - UIcollectionView 代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:DaRenStep object:nil userInfo:@{@"pic":indexPath}];
}


@end
