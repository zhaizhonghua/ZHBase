//
//  BaseRequst.m
//  base
//
//  Created by 翟中华 on 16/11/8.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "BaseRequst.h"
#import "BaseAPIClient.h"

@implementation BaseRequst
+ (NSURLSessionDataTask *)postJson:(NSString *)url Params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block Response:(void (^)(id response))responseBlock ErrorMessage:(void (^)(NSString * msg)) errorBlock Finally:(void (^)()) finallyBlock{
    
    if ([[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] == AFNetworkReachabilityStatusNotReachable) {
        [MBProgressHUD showHUDMsg:@"网络不顺畅，请稍候再试"];
        if (finallyBlock) {
            finallyBlock();
        }
        if(errorBlock){
            errorBlock(@"网络不顺畅，请稍候再试");
        }
        
        return nil;
    }
    
    NSString *fullPath = [NSString stringWithFormat:@"%@%@",BASE_URL,url];
    
    NSLog(@"####%@####",fullPath);
    
    NSLog(@"参数:== %@",params);
    
    return [[BaseAPIClient sharedClient] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (block != nil) {
            block(formData);
        }
        
    } progress:^(NSProgress * uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        [BaseRequst saveCookies];
        
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", result);
        
        
        
        NSString *emj = [[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] emojizedString];
        
        responseObject = [emj dataUsingEncoding:NSUTF8StringEncoding];
        
        
        NSError * error ;
        BOOL isSuccess = false;
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        
        if (!jsonObj || error) {
            errorBlock(@"数据解析失败");
            return ;
        }
        
        int errorCode = [[jsonObj objectForKey:@"errorcode"] intValue];
        
        isSuccess = errorCode == 99999;
        
        if (isSuccess) {
            responseBlock([jsonObj objectForKey:@"result"]);
        }else{
            errorBlock([jsonObj objectForKey:@"errormsg"]);
        }
        
        if (finallyBlock) {
            finallyBlock();
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        if (error.code == 3840) {
            //返回数据解析出错
            errorBlock(@"网络错误");
        }else{
            errorBlock(@"网络异常");
            NSLog(@"error.code --%ld",(long)error.code);
        }
        NSLog(@"%@",error.description);
        //        NSLog(@"%@",error.d)
        finallyBlock();
    }];
    
}

+ (NSURLSessionDataTask *)postJson:(NSString *)url Params:(NSDictionary *)params Response:(void (^)(id response))responseBlock ErrorMessage:(void (^)(NSString * msg)) errorBlock Finally:(void (^)()) finallyBlock;
{
    return [BaseRequst postJson:url Params:params constructingBodyWithBlock:nil Response:responseBlock ErrorMessage:errorBlock Finally:finallyBlock];
}

+ (NSURLSessionDataTask *)postJsonAllResponse:(NSString *)url Params:(NSDictionary *)params Response:(void (^)(id response))responseBlock ErrorMessage:(void (^)(NSString * msg)) errorBlock{
    
    return [[BaseAPIClient sharedClient] POST:url parameters:params constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [BaseRequst saveCookies];
        
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", result);
        
        responseBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code == 3840) {
            //返回数据解析出错
            errorBlock(@"网络错误");
        }else{
            errorBlock(@"网络异常");
        }
        
    }];
    
}


+ (void)saveCookies{
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"sessionCookies"];
    [defaults synchronize];
    
}

@end
