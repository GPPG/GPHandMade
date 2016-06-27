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
@property (nonatomic, strong) NSArray *picArray;
@property (nonatomic, strong) NSMutableArray *handArray;
@end

@implementation GPDarenCell
- (void)awakeFromNib
{
    self.picArray = @[self.oneImageView,self.twoImageView,self.threeImageView];
}
#pragma mark - 懒加载
- (NSMutableArray *)handArray
{
    if (!_handArray) {
        
        _handArray = [[NSMutableArray alloc] init];
    }
    return _handArray;
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
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
    
    NSURL *iconUrl = [NSURL URLWithString:daData.avatar];
    [self.iconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.nameLabel.text = daData.nick_name;
    NSString *subStr = [NSString stringWithFormat:@"%@图文教程|%@视频教程|%@手工圈",daData.course_count,daData.video_count,daData.opus_count];
    self.subTitleLabel.text = subStr;
    int i = 0;
    for (NSDictionary *picDic in daData.list) {
        [self addImage:picDic[@"host_pic"] imageView:self.picArray[i] tag:picDic[@"hand_id"]];
        [self addTapGestuer:self.picArray[i]];
        i ++;
    }
}
#pragma mark - 内部方法
- (void)addImage:(NSString *)picUrl imageView:(UIImageView *)imageView tag:(NSString *)tapStr
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"2"]];
    imageView.tag = [tapStr intValue];
}
#pragma mark - 添加手势
- (void)addTapGestuer:(UIImageView *)imageView
{
    UITapGestureRecognizer *tapGs = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
    [imageView addGestureRecognizer:tapGs];
}
- (void)imageViewClick:(UITapGestureRecognizer *)gestureRecognizer
{
    UIImageView *imageView = (UIImageView *)[gestureRecognizer view];
    if (self.imageClick) {
        self.imageClick(imageView.tag);
    }
}
@end
