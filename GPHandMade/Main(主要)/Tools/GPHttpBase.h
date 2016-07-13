//
//  GPHttpBase.h
//  GPHandMade
//
//  Created by dandan on 16/7/11.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPHttpBase : NSObject
+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)getMoreWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
