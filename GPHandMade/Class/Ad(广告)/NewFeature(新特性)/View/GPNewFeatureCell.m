//
//  GPNewFeatureCell.m
//  GPHandMade
//
//  Created by dandan on 16/5/27.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPNewFeatureCell.h"

@interface GPNewFeatureCell()
@property (weak, nonatomic) IBOutlet UIImageView *FeatureImageView;

@end
@implementation GPNewFeatureCell

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.FeatureImageView.image = image;
}
@end
