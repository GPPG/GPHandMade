//
//  GPFairBestCell.m
//  GPHandMade
//
//  Created by dandan on 16/7/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPFairBestCell.h"
#import "GPFariBestData.h"

@interface GPFairBestCell()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end
@implementation GPFairBestCell

- (void)setBestData:(GPFariBestData *)bestData
{
    _bestData = bestData;
    
    NSURL *picUrl = [NSURL URLWithString:bestData.picurl];
    [self.contentImageView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"001"]];
    self.titleLabel.text = bestData.title;
    self.priceLabel.text = bestData.price;
}




@end
