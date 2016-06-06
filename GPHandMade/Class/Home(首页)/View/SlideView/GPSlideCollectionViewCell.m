//
//  GPSlideCollectionViewCell.m
//  GPHandMade
//
//  Created by dandan on 16/5/23.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSlideCollectionViewCell.h"
#import "GPSlideShopData.h"
#import "UIImageView+WebCache.h"

@interface GPSlideCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *shopPic; //
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@property (weak, nonatomic) IBOutlet UILabel *vote;
@property (weak, nonatomic) IBOutlet UIImageView *userPic;
@property (weak, nonatomic) IBOutlet UILabel *useName;

@end

@implementation GPSlideCollectionViewCell
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.layer.cornerRadius = 5;
    }
    return self;
}
- (void)setShopData:(GPSlideShopData *)shopData
{
    _shopData = shopData;

    NSURL *shopUrl = [NSURL URLWithString:shopData.host_pic];
    NSURL *useUrl = [NSURL URLWithString:shopData.avatar];
    [self.shopPic sd_setImageWithURL:shopUrl placeholderImage:[UIImage imageNamed:@"2"]];
    self.subtitle.text = shopData.subject;
    self.vote.text = shopData.votes;
    [self.userPic sd_setImageWithURL:useUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.useName.text = shopData.uname;
    
    
}
@end
