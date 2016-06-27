//
//  GPDaRenStepThreeCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/24.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDaRenStepThreeCell.h"
#import "GPDaRenStepData.h"
#import "UIImageView+WebCache.h"

@interface GPDaRenStepThreeCell()
@property (weak, nonatomic) IBOutlet UILabel *intLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contenImageView;
@property (weak, nonatomic) IBOutlet UIButton *setpBtn;
- (IBAction)setBtnClick:(UIButton *)sender;


@end
@implementation GPDaRenStepThreeCell
- (void)awakeFromNib
{
    self.setpBtn.layer.borderWidth = 1;
    self.setpBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.setpBtn.layer.cornerRadius = 15;
}
- (void)setSetpData:(GPDaRenStepData *)setpData
{
    _setpData = setpData;
    NSURL *picUrl = [NSURL URLWithString:setpData.pic];
    [self.contenImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"3"]];
    self.intLabel.text = setpData.content;
    [self.setpBtn setImage:[UIImage imageNamed:@"ic_course_sort_all"] forState:UIControlStateNormal];
    NSString *setpStr = [NSString stringWithFormat:@"步骤%ld/%ld",self.currentNum,self.sumNum];
    [self.setpBtn setTitle: setpStr forState:UIControlStateNormal];
}
- (IBAction)setBtnClick:(UIButton *)sender {
        if(self.setpBtnClick){
            self.setpBtnClick();
        }
}
@end
