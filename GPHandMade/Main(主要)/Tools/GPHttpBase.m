//
//  GPHttpBase.m
//  GPHandMade
//
//  Created by dandan on 16/7/11.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPHttpBase.h"
#import "GPHttpTool.h"

@implementation GPHttpBase
+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param mj_keyValues];
    [GPHttpTool get:url params:params success:^(id responseObj) {
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObj[@"data"]];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)getMoreWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param mj_keyValues];
    [GPHttpTool get:url params:params success:^(id responseObj) {
        if (success) {
            id result = [resultClass mj_objectArrayWithKeyValuesArray:responseObj[@"data"]];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param mj_keyValues];
    
    [GPHttpTool post:url params:params success:^(id responseObj) {
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
