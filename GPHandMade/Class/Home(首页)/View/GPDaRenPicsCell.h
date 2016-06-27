//
//  GPDaRenPicsCell.h
//  GPHandMade
//
//  Created by dandan on 16/6/27.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPDaRenStepData,GPDaRenPicData;
@interface GPDaRenPicsCell : UICollectionViewCell
@property (nonatomic, strong) GPDaRenStepData *stepData;
@property (nonatomic,assign) NSInteger currtnNum;
@property (nonatomic, strong) GPDaRenPicData *picData;
@end
