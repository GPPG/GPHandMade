//
//  GPHotCell.m
//  GPHandMade
//
//  Created by dandan on 16/5/19.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHotCell.h"
#import "GPHotData.h"
#import "UIImageView+WebCache.h"

@interface GPHotCell()
@property (weak, nonatomic) IBOutlet UIImageView *BgImageView;
@property (weak, nonatomic) IBOutlet UILabel *SubTitle;

@end

@implementation GPHotCell

- (void)setHotdata:(GPHotData *)hotdata
{
    _hotdata = hotdata;
    
    NSURL *bgUrl = [NSURL URLWithString:hotdata.pic];
    [self.BgImageView sd_setImageWithURL:bgUrl placeholderImage:[UIImage imageNamed:@"2"]];
    self.SubTitle.text = hotdata.subject;
    
    
}

@end
