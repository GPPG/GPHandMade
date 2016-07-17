//
//  GPSettingGroup.h
//  GPHandMade
//
//  Created by dandan on 16/7/14.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSettingGroup : NSObject
/** 组头 */
@property (nonatomic, copy) NSString *header;
/** 组尾 */
@property (nonatomic, copy) NSString *footer;
/**
 *  行模型
 */
@property (nonatomic, strong) NSMutableArray *items;
@end
