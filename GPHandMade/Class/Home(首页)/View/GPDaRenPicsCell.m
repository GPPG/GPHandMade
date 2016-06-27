
//
//  GPDaRenPicsCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/27.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDaRenPicsCell.h"
#import "UIImageView+WebCache.h"
#import "GPDaRenStepData.h"
#import "GPDaRenPicData.h"

@interface GPDaRenPicsCell()
@property (weak, nonatomic) IBOutlet UILabel *currtenLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@end
@implementation GPDaRenPicsCell
-(void)awakeFromNib
{
    self.layer.cornerRadius = 5;
}
- (void)setStepData:(GPDaRenStepData *)stepData
{
    _stepData = stepData;
    NSURL *picsUrl = [NSURL URLWithString:stepData.pic_s];
    [self.contentImageView sd_setImageWithURL:picsUrl placeholderImage:[UIImage imageNamed:@"2"]];
}

- (void)setCurrtnNum:(NSInteger)currtnNum
{
    _currtnNum = currtnNum;
    self.currtenLabel.text = [NSString stringWithFormat:@"%ld",currtnNum];
}
- (void)setPicData:(GPDaRenPicData *)picData
{
    _picData = picData;
    self.subTitleLabel.text = picData.subject;
}
@end
