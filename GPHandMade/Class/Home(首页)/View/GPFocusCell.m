//
//  GPFocusCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/28.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFocusCell.h"

@interface GPFocusCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentLael;
@property (weak, nonatomic) IBOutlet UILabel *subLael;

@end
@implementation GPFocusCell
- (void)awakeFromNib
{
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 20;
}
- (void)setContenStr:(NSString *)contenStr
{
    _contenStr = contenStr;
    self.subLael.text = self.contenStr;
}
- (void)setIconStr:(NSString *)iconStr
{
    _iconStr = iconStr;
    self.iconImageView.image = [UIImage imageNamed:self.iconStr];
}
- (void)setNameStr:(NSString *)nameStr
{
    _nameStr = nameStr;
    self.nameLabel.text = self.nameStr;
}
- (void)setImageStr:(NSString *)imageStr
{
    _imageStr = imageStr;
    self.contentLael.image = [UIImage imageNamed:self.imageStr];
}
@end
