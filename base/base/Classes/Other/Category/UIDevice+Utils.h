//
//  UIDevice+Utils.h
//  Core
//
//  Created by Su Ying on 15/2/26.
//  Copyright (c) 2015年 Passion4Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Utils)

// 是否是iPhone
+ (BOOL)isiPhone;

// 是否是iPad
+ (BOOL)isiPad;

// 是否是iTouch
+ (BOOL)isiPodTouch;

// 支持拔打电话
+ (BOOL)supportTelephone;

// 支持发送短信
+ (BOOL)supportSendSMS;

// 支持发送邮件
+ (BOOL)supportSendMail;

// 支持摄像头取景
+ (BOOL)supportCamera;

// 以全小写的形式返回设备名称
- (NSString*)modelNameLowerCase;

// Mac Address
- (NSString*)macAddress;

// 系统是否越狱
- (BOOL) isJailBroken;

// 内存信息
+ (unsigned int)freeMemory;
+ (unsigned int)usedMemory;

//
+ (BOOL) isRetina;

+ (double) screenWidth;
+ (double) screenHeight;
+ (double) screenMaxLength;
+ (double) screenMinLength;

+ (BOOL) isIPhone4OrLess;
+ (BOOL) isIPhone5;
+ (BOOL) isIPhone5OrLess;
+ (BOOL) isIPhone6;
+ (BOOL) isIPhone6P;

+ (uint64_t)totalDiskSpace;
+ (uint64_t)freeDiskSpace;

+(NSString *)hardwareString;

@end
