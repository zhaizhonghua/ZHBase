//
//  BaseAPIClient.h
//  base
//
//  Created by 翟中华 on 16/11/8.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "AFHTTPSessionManager.h"

enum NetworkStatus
{
    NetworkStatusUnknown          = -1,//不知道
    NetworkStatusNotReachable     = 0,//断网
    NetworkStatusReachableViaWWAN = 1,//蜂窝网络
    NetworkStatusReachableViaWiFi = 2,//WIFI
};

extern enum NetworkStatus networkStatus;

@interface BaseAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
