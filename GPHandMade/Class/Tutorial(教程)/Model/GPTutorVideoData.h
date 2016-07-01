//
//  GPTutorVideoData.h
//  GPHandMade
//
//  Created by dandan on 16/7/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPTutorVideoData : NSObject
@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *host_pic; // 主图片

@property (nonatomic, copy) NSString *subject; // 主标题

@property (nonatomic, assign) NSInteger deadline;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger suggest;

@property (nonatomic, assign) NSInteger is_free;

@end
