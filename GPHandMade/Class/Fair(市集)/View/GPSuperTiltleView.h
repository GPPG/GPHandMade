//
//  GPSuperTiltleView.h
//  GPHandMade
//
//  Created by dandan on 16/7/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPSuperTiltleView : UIView
- (instancetype)initWithChildControllerS:(NSArray *)titleArray;
- (void)updateSelecterToolsIndex:(NSInteger )index;
@end
