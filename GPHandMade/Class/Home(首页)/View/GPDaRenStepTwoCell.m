//
//  GPDaRenStepTwoCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDaRenStepTwoCell.h"
#import "GPDaRenMaterialData.h"
#import "GPDaRenToolsData.h"
#import "GPStepTableViewCell.h"

@interface GPDaRenStepTwoCell()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *stepTableView;


@end
@implementation GPDaRenStepTwoCell

#pragma mark - 初始化
- (void)awakeFromNib
{
    [self setup];
}
- (void)setup
{
    self.stepTableView.dataSource = self;
    self.stepTableView.delegate = self;
    self.stepTableView.rowHeight = 50;
    self.stepTableView.sectionHeaderHeight = 40;
    self.stepTableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.stepTableView registerNib:[UINib nibWithNibName:NSStringFromClass([GPStepTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"setpCell"];
}
#pragma mark - 数据处理
- (void)setToolsArray:(NSArray *)toolsArray
{
    _toolsArray = toolsArray;
    [self.stepTableView reloadData];
}
- (void)setMateriaArray:(NSArray *)materiaArray
{
    _materiaArray = materiaArray;
    [self.stepTableView reloadData];
}
#pragma mark - UItableView 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = self.toolsArray.count;
    if (section == 0) {
        rowCount = self.materiaArray.count;
    }
    return rowCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GPStepTableViewCell *stepCell = [tableView dequeueReusableCellWithIdentifier:@"setpCell"];
    if (indexPath.section == 0) {
        stepCell.materData = self.materiaArray[indexPath.row];
    }else{
        stepCell.toolData = self.toolsArray[indexPath.row];
    }
    return stepCell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headView = nil;
    if (section == 0) {
     headView = [self addHeadView:@"所需材料"];
    }else{
        headView = [self addHeadView:@"所需工具"];
    }
    return headView;
}
- (UILabel *)addHeadView:(NSString *)headStr
{
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headerLabel.backgroundColor = GPCommonBgColor;
    headerLabel.text = headStr;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    return headerLabel;
}
@end
