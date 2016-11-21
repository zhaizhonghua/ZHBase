//
//  BaseAPIClient.m
//  base
//
//  Created by 翟中华 on 16/11/8.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "BaseAPIClient.h"

@implementation BaseAPIClient
+ (instancetype)sharedClient {
    static BaseAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BaseAPIClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        
        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedClient.requestSerializer.timeoutInterval = 10.0f;
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
        [BaseAPIClient getNetWorkNotificationCenter];
        [BaseAPIClient loadCookies];
        
    });
    
    return _sharedClient;
}

+ (void)loadCookies{
    
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
    
}

+ (void)getNetWorkNotificationCenter
{
    static BOOL isNotFirst;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (!isNotFirst) {
            isNotFirst = true;
            return;
        }
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                [MBProgressHUD showHUDMsg:@"网络好像断了"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                [MBProgressHUD showHUDMsg:@"已切换为WIFI网络"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                [MBProgressHUD showHUDMsg:@"已切换为蜂窝网络"];
                break;
            }
            default:
                return;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_NETWORK_REACHABILITY object:nil];
        
    }];
}
@end
