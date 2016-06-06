
//
//  GPNavigationCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPNavigationCell.h"
#import "UIImageView+WebCache.h"
#import "GPNavigationData.h"

@interface GPNavigationCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@end
@implementation GPNavigationCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setNavgationData:(GPNavigationData *)navgationData
{
    _navgationData = navgationData;
    NSURL *iconUrl = [NSURL URLWithString:navgationData.pic];
    [self.iconImageView sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.subtitle.text = navgationData.name;
}
@end
