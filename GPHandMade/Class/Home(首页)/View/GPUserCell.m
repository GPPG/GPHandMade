
//
//  GPUserCell.m
//  GPHandMade
//
//  Created by dandan on 16/5/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPUserCell.h"
#import "GPLessonData.h"
#import "UIImageView+WebCache.h"

@interface GPUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *userPic;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userTime;

@property (weak, nonatomic) IBOutlet UILabel *wirteNote;

@end
@implementation GPUserCell

- (void)setLessonData:(GPLessonData *)lessonData
{
    _lessonData = lessonData;
    
    NSURL *picUrl = [NSURL URLWithString:lessonData.face_pic];
    [self.userPic sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.userName.text = lessonData.uname;
    self.userTime.text = [NSString stringWithFormat:@"创建于%@",lessonData.create_time];
    self.wirteNote.text = lessonData.teacher_des;
}



@end
