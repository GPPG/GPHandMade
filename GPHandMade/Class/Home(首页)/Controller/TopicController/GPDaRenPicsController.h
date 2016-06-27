//
//  GPDaRenPicsController.h
//  GPHandMade
//
//  Created by dandan on 16/6/26.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPDaRenPicData;
@interface GPDaRenPicsController : UICollectionViewController
@property (nonatomic, strong) NSArray *stepDataArray;
@property (nonatomic, strong) GPDaRenPicData *picData;
@end
