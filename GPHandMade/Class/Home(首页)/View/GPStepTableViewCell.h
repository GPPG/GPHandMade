//
//  GPStepTableViewCell.h
//  GPHandMade
//
//  Created by dandan on 16/6/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPDaRenToolsData,GPDaRenMaterialData;
@interface GPStepTableViewCell : UITableViewCell
@property (nonatomic, strong) GPDaRenMaterialData *materData;
@property (nonatomic, strong) GPDaRenToolsData *toolData;
@end
