//
//  GPNavTitleView.h
//  GPHandMade
//
//  Created by dandan on 16/6/29.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NavTitleClickBlock)(UIButton *button);
@interface GPNavTitleView : UIView

- (instancetype)initWithFrame:(CGRect)frame block:(NavTitleClickBlock)block;
-(void)updateSelecterToolsIndex:(NSInteger )index;
@end
