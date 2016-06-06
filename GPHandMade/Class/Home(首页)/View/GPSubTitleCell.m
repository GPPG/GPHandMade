//
//  GPSubTitleCell.m
//  GPHandMade
//
//  Created by dandan on 16/5/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPSubTitleCell.h"
#import "GPLessonData.h"

@interface GPSubTitleCell()
@property (weak, nonatomic) IBOutlet UILabel *subTitle; // 主标题
@property (weak, nonatomic) IBOutlet UILabel *nowPrice; // 目前价格
@property (weak, nonatomic) IBOutlet UILabel *laterPrice; // 以前价格
@property (weak, nonatomic) IBOutlet UILabel *buyCoutn; // 购买人数
@property (weak, nonatomic) IBOutlet UILabel *fanse; // 人气

@end

@implementation GPSubTitleCell

- (void)setLessonData:(GPLessonData *)lessonData
{
    _lessonData = lessonData;
    
    self.subTitle.text = lessonData.subject;
    self.nowPrice.text = [NSString stringWithFormat:@"$ %@",lessonData.price];
    self.buyCoutn.text = [NSString stringWithFormat:@"%@人已报名",lessonData.buyer_num];
    self.fanse.text = [NSString stringWithFormat:@"%@人气",lessonData.view];
    
    // 文字中间加横线
    if (lessonData.original_price.length != 0) {
        NSMutableAttributedString *orginPriceAstr = [[NSMutableAttributedString alloc]initWithString:lessonData.original_price];
        
        [orginPriceAstr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, orginPriceAstr.length)];
        self.laterPrice.attributedText = orginPriceAstr;
    }
   
}

@end
