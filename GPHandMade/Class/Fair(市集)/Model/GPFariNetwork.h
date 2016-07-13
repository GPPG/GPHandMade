//
//  GPFariNetwork.h
//  GPHandMade
//
//  Created by dandan on 16/7/12.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPFariParmer.h"
#import "GPFariData.h"
#import "GPFariTopicData.h"

@interface GPFariNetwork : NSObject
+(void)fariDataWithParms:(GPFariParmer *)parmer success:(void(^)(GPFariData *fariData))success failuer:(void(^)(NSError *error))failuer;

+(void)fariMoreDataWithParms:(GPFariParmer *)parmer success:(void(^)(NSArray *topicDataS))success failuer:(void(^)(NSError *error))failuer;

@end
