//
//  GPChatData.h
//  GPHandMade
//
//  Created by dandan on 16/6/29.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    GPMessageTypeSendToOthers,
    GPMessageTypeSendToMe
} GPMessageType;


@interface GPChatData : NSObject

@property (nonatomic, assign) GPMessageType messageType;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *imageName;
@end
