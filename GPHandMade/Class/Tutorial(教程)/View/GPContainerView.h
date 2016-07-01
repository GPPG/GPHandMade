//
//  GPContainerView.h
//  GPHandMade
//
//  Created by dandan on 16/6/30.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selecBlock)(int);

@interface GPContainerView : UIScrollView

- (instancetype)initWithChildControllerS:(NSArray *)vcArray selectBlock:(selecBlock)selecB;
-(void)updateVCViewFromIndex:(NSInteger )index;

@end
