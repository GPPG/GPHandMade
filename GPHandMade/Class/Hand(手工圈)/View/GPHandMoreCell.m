//
//  GPHandMoreCell.m
//  GPHandMade
//
//  Created by dandan on 16/7/7.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHandMoreCell.h"

@interface GPHandMoreCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation GPHandMoreCell

- (void)awakeFromNib {


}
- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}

#pragma mark - 内部方法

@end
