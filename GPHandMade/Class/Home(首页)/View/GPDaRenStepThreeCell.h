//
//  GPDaRenStepThreeCell.h
//  GPHandMade
//
//  Created by dandan on 16/6/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPDaRenStepData;
@interface GPDaRenStepThreeCell : UICollectionViewCell
@property (nonatomic, strong) GPDaRenStepData *setpData;
@property (nonatomic,assign) NSInteger sumNum;
@property (nonatomic,assign) NSInteger currentNum;
@property (nonatomic,copy) void(^setpBtnClick)();
@end
