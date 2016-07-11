////
////  HMStatusTool.h
////  黑马微博
////
////  Created by apple on 14-7-11.
////  Copyright (c) 2014年 heima. All rights reserved.
////  微博业务类：处理跟微博相关的一切业务，比如加载微博数据、发微博、删微博
//
//#import <Foundation/Foundation.h>
//#import "HMHomeStatusesParam.h"
//#import "HMHomeStatusesResult.h"
//#import "HMSendStatusParam.h"
//#import "HMSendStatusResult.h"
//#import "HMCommentsParam.h"
//#import "HMCommentsResult.h"
//#import "HMRepostsParam.h"
//#import "HMRepostsResult.h"
//#import "HMBaseTool.h"
//
//@interface HMStatusTool : HMBaseTool
//
///**
// *  加载首页的微博数据
// *
// *  @param param   请求参数
// *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
// *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
// */
//+ (void)homeStatusesWithParam:(HMHomeStatusesParam *)param success:(void (^)(HMHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;
//
///**
// *  发没有图片的微博
// *
// *  @param param   请求参数
// *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
// *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
// */
//+ (void)sendStatusWithParam:(HMSendStatusParam *)param success:(void (^)(HMSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
//
///**
// *  加载评论数据
// */
//+ (void)commentsWithParam:(HMCommentsParam *)param success:(void (^)(HMCommentsResult *result))success failure:(void (^)(NSError *error))failure;
///**
// *  加载转发数据
// */
//+ (void)repostsWithParam:(HMRepostsParam *)param success:(void (^)(HMRepostsResult *result))success failure:(void (^)(NSError *error))failure;
//@end
