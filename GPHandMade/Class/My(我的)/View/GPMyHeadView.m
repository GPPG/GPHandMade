//
//  GPMyHeadView.m
//  GPHandMade
//
//  Created by dandan on 16/7/14.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPMyHeadView.h"

@interface GPMyHeadView()

@property (weak, nonatomic) IBOutlet UIButton *b;

@end

@implementation GPMyHeadView
- (void)awakeFromNib
{
    [self.b addTarget:self action:@selector(bClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)bClick
{
    if (self.BtnClick) {
        self.BtnClick();
    }
}
@end
