//
//  GPTutoriSubController.m
//  GPHandMade
//
//  Created by dandan on 16/7/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTutoriSubController.h"

@implementation GPTutoriSubController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}
@end
