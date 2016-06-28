//
//  GPSlideSuperController.h
//  GPHandMade
//
//  Created by dandan on 16/6/6.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPslide;
@interface GPSlideSuperController : UICollectionViewController
@property (nonatomic, strong) GPslide *slide;
@property (nonatomic, copy) NSString *handID; // 记录点击轮播的参数

- (NSString *)paramA;
@end
