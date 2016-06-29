//
//  GPChatCell.h
//  GPHandMade
//
//  Created by dandan on 16/6/29.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLEmojiLabel.h"
#import "GPChatData.h"

@interface GPChatCell : UITableViewCell

@property (nonatomic, strong) GPChatData *model;

@property (nonatomic, copy) void (^didSelectLinkTextOperationBlock)(NSString *link, MLEmojiLabelLinkType type);
@end
