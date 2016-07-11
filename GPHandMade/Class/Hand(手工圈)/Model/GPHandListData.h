//
//  GPHandListData.h
//  GPHandMade
//
//  Created by dandan on 16/7/11.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPHandListData : NSObject

@property (nonatomic,copy) NSString *uname;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic, strong) NSArray *pic;
@property (nonatomic,copy) NSString *subject;
@property (nonatomic, strong) NSArray *comment;
@property (nonatomic,copy) NSString *comment_num;
@property (nonatomic, strong) NSArray *laud_list;
@property (nonatomic,copy) NSString *laud_num;
@property (nonatomic,copy) NSString *add_time;
@end
