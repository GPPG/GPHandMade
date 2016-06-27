//
//  GPStepTableViewCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPStepTableViewCell.h"
#import "GPDaRenMaterialData.h"
#import "GPDaRenToolsData.h"

@interface GPStepTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nsmeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end
@implementation GPStepTableViewCell
#pragma mark - 数据处理
-(void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setMaterData:(GPDaRenMaterialData *)materData
{
    _materData = materData;
    self.nsmeLabel.text = materData.name;
    self.countLabel.text = materData.num;
}
- (void)setToolData:(GPDaRenToolsData *)toolData
{
    _toolData = toolData;
    self.nsmeLabel.text = toolData.name;
    self.countLabel.text = toolData.num;
}
@end
