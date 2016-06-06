//
//  GPNewFeatureController.m
//  GPHandMade
//
//  Created by dandan on 16/5/27.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPNewFeatureController.h"
#import "GPNewFeatureCell.h"
#import "GPAdViewController.h"

@interface GPNewFeatureController ()

@end

@implementation GPNewFeatureController

static NSString * const reuseIdentifier = @"featureCell";


- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    // 设置每一行的间距
    layout.minimumLineSpacing = 0;
    
    // 设置每个cell的间距
    layout.minimumInteritemSpacing = 0;
    
    // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCollectionView];
    
}

// 初始化CollectionView
- (void)setUpCollectionView
{
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GPNewFeatureCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    // 取消弹簧效果
    self.collectionView.bounces = NO;
    
    // 取消显示指示器
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 开启分页模式
    self.collectionView.pagingEnabled = YES;
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"newfeature_0%ld_736",indexPath.item + 1];
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        
        // 切换窗口的根控制器进行跳转
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [[GPAdViewController alloc]init];
        
        CATransition *anim = [CATransition animation];
        anim.type = @"rippleEffect";
        anim.duration = 1;
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
    }
    
}
@end
