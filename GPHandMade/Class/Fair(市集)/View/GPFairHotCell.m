//
//  GPFairHotCell.m
//  GPHandMade
//
//  Created by dandan on 16/7/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFairHotCell.h"
#import "GPFariHotData.h"

@interface GPFairHotCell()

@property (weak, nonatomic) IBOutlet UIImageView *contentPic;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation GPFairHotCell

- (void)awakeFromNib {
}
- (void)setHotData:(GPFariHotData *)hotData
{
    _hotData = hotData;
    
    NSURL *picUrl = [NSURL URLWithString:hotData.pic];
    [self.contentPic sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"004"]];
    self.contentLabel.text = hotData.name;
}
@end
