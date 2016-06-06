

//
//  GPFooterClassCell.m
//  GPHandMade
//
//  Created by dandan on 16/5/30.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFooterClassCell.h"
#import "GPOtherClass.h"
#import "UIImageView+WebCache.h"

@interface GPFooterClassCell()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel; // 价格
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView; // 图片
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel; // 标题
@property (weak, nonatomic) IBOutlet UILabel *countLabel; // 报名数

@end

@implementation GPFooterClassCell

- (void)setOtherClass:(GPOtherClass *)otherClass
{
    _otherClass = otherClass;
    NSURL *shopUrl = [NSURL URLWithString:otherClass.host_pic];
    [self.shopImageView sd_setImageWithURL:shopUrl placeholderImage:[UIImage imageNamed:@"2"]];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",otherClass.price];
    self.subtitleLabel.text = otherClass.subject;
    self.countLabel.text = otherClass.buyer_num;
}

@end
