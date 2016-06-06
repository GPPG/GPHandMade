//
//  GPAdvanceCell.m
//  GPHandMade
//
//  Created by dandan on 16/6/4.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPAdvanceCell.h"
#import "GPAdvanceDtata.h"
#import "UIImageView+WebCache.h"

@interface GPAdvanceCell()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end
@implementation GPAdvanceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setAdvanceData:(GPAdvanceData *)advanceData
{
    _advanceData = advanceData;
    NSURL *bgUrl = [NSURL URLWithString:advanceData.pic];
    [self.bgImageView sd_setImageWithURL:bgUrl placeholderImage:[UIImage imageNamed:@"2"]];
}
@end
