//
//  GPTimeLineCommentData.h
//  GPHandMade
//
//  Created by dandan on 16/6/20.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPTimeLineCommentData : NSObject
@property (nonatomic,copy) NSString *content; // 内容
@property (nonatomic,copy) NSString *add_time; // 时间
@property (nonatomic,copy) NSString *uname; // 昵称
@property (nonatomic,copy) NSString *avatar; // 头像
@property (nonatomic,copy) NSString *circle_item_id;
@property (nonatomic,copy) NSString *to_uname; // 回复

@end
