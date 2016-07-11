//
//  GPHandMoreHeadView.m
//  GPHandMade
//
//  Created by dandan on 16/7/7.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHandMoreHeadView.h"

@interface GPHandMoreHeadView()
@property (weak, nonatomic) IBOutlet UILabel *plocerLabel;

@end

@implementation GPHandMoreHeadView
- (void)awakeFromNib {
    
}
-(void)setHeadStr:(NSString *)headStr
{
    _headStr = headStr;
    self.plocerLabel.text = headStr;
}

@end
