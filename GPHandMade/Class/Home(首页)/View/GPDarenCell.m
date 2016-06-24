//
//  GPDarenCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/23.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDarenCell.h"
#import "GPDaData.h"
#import "UIImageView+WebCache.h"

@interface GPDarenCell()
@property (weak, nonatomic) IBOutlet UIButton *guanBtn;

- (IBAction)guanBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;
@property (nonatomic, strong) NSMutableArray *picArray;
@end

@implementation GPDarenCell
#pragma mark - 懒加载
- (NSMutableArray *)picArray
{
    if (!_picArray) {
        
        _picArray = [[NSMutableArray alloc] init];
    }
    return _picArray;
}

- (IBAction)guanBtnClick:(UIButton *)sender {
    sender.selected = YES;
    self.guanBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;

}
- (void)setDaData:(GPDaData *)daData
{
    _daData = daData;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.guanBtn.layer.cornerRadius = 5;
    self.guanBtn.layer.borderWidth = 1;
    if (self.guanBtn.selected != YES) {
        self.guanBtn.selected = NO;
        self.guanBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    self.iconImageView.layer.cornerRadius = 30;
    self.iconImageView.layer.masksToBounds = YES;
    
    NSURL *iconUrl = [NSURL URLWithString:daData.avatar];
    [self.iconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.nameLabel.text = daData.nick_name;
    NSString *subStr = [NSString stringWithFormat:@"%@图文教程|%@视频教程|%@手工圈",daData.course_count,daData.video_count,daData.opus_count];
    self.subTitleLabel.text = subStr;
    for (NSDictionary *picDic in daData.list) {
        [self.picArray addObject:picDic[@"host_pic"]];
    }
    [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:self.picArray[0]]placeholderImage:[UIImage imageNamed:@"2"]];
    [self.twoImageView sd_setImageWithURL:[NSURL URLWithString:self.picArray[1]]placeholderImage:[UIImage imageNamed:@"2"]];
    [self.threeImageView sd_setImageWithURL:[NSURL URLWithString:self.picArray[2]]placeholderImage:[UIImage imageNamed:@"2"]];
}
@end
