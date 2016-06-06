//
//  GPContentCell.m
//  GPHandMade
//
//  Created by dandan on 16/5/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPContentCell.h"
#import "GPLessonData.h"
#import "GPMaterial.h"

@interface GPContentCell()
@property (weak, nonatomic) IBOutlet UILabel *ContenLabel;


@end
@implementation GPContentCell

- (void)setLessonData:(GPLessonData *)lessonData
{
    _lessonData = lessonData;
    
      
//    for (int i = 1; i < 7; i ++) {
//        self.ContenLabel.text = contentS[i];
//        
//    }
    
}

- (void)setContentStr:(NSString *)ContentStr
{
    _ContentStr = ContentStr;
    self.ContenLabel.text = ContentStr;
    
}

@end
