//
//  BaseRequst.h
//  base
//
//  Created by 翟中华 on 16/11/8.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface BaseRequst : NSObject


/**
 * 完整的表单提交,管理端上传文件
 */
+ (NSURLSessionDataTask *)postJson:(NSString *)url Params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block Response:(void (^)(id response))responseBlock ErrorMessage:(void (^)(NSString * msg)) errorBlock Finally:(void (^)()) finallyBlock;

/**
 *  简化的，不需要提交文件的，表单提交
 */
+ (NSURLSessionDataTask *)postJson:(NSString *)url Params:(NSDictionary *)params Response:(void (^)(id response))responseBlock ErrorMessage:(void (^)(NSString * msg)) errorBlock Finally:(void (^)()) finallyBlock;

/**
 * 返回的数据不做处理的表单提交
 */
+ (NSURLSessionDataTask *)postJsonAllResponse:(NSString *)url Params:(NSDictionary *)params Response:(void (^)(id response))responseBlock ErrorMessage:(void (^)(NSString * msg)) errorBlock;

@end
