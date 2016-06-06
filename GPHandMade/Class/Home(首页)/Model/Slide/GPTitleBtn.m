//
//  GPTitleBtn.m
//  GPOnFire
//
//  Created by dandan on 16/3/18.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPTitleBtn.h"

@implementation GPTitleBtn
// 取消按钮高亮状态下的反应
- (void)setHeight:(CGFloat)height
{
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
    
}
@end
