//
//  GPTutoriSubController.m
//  GPHandMade
//
//  Created by dandan on 16/7/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTutoriSubController.h"

@interface GPTutoriSubController()<UIScrollViewDelegate>

@end
@implementation GPTutoriSubController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}
///**
// *  手势冲突
// *
// */
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.x < 0) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"dawang" object:nil];
//    }
//    NSLog(@"%f____%f",scrollView.x,scrollView.contentOffset.x);
//}


@end
