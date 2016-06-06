//
//  GPHttpTool.h
//  GPOnFire
//
//  Created by dandan on 16/3/23.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPHttpTool : NSObject

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure: (void(^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success
     failure: (void(^)(NSError *error))failure;
@end
