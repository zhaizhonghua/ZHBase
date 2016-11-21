//
//  UIDevice+Utils.m
//  Core
//
//  Created by Su Ying on 15/2/26.
//  Copyright (c) 2015年 Passion4Life. All rights reserved.
//

#import "UIDevice+Utils.h"
#import <sys/socket.h> // Per msqr
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <net/if.h>
#import <sys/types.h>
#import <sys/stat.h>
#import <sys/mount.h>
#import <mach/mach.h>
#import <MessageUI/MFMailComposeViewController.h>

@implementation UIDevice (Utils)

// 是否是iPhone
+ (BOOL)isiPhone
{
    return [[[UIDevice currentDevice].model lowercaseString] rangeOfString:@"iphone"].length > 0;
}

// 是否是iPad
+ (BOOL)isiPad
{
    UIDevice* device = [UIDevice currentDevice];
    
    if ([device.model isEqualToString:@"iPad"]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 是否是iTouch
+ (BOOL)isiPodTouch
{
    UIDevice* device = [UIDevice currentDevice];
    
    if ([device.model isEqualToString:@"iPod touch"]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 支持拔打电话
+ (BOOL)supportTelephone
{
    // 目前逻辑：iPhone支持电话，其余设备不支持
    if ([UIDevice isiPhone]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 支持发送短信
+ (BOOL)supportSendSMS
{
    // 目前逻辑：iPhone支待短信，其余设备不支待
    if ([UIDevice isiPhone]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 支持发送邮件
+ (BOOL)supportSendMail
{
    if ([MFMailComposeViewController canSendMail]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 支持摄像头取景
+ (BOOL)supportCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 以全小写的形式返回设备名称
- (NSString*)modelNameLowerCase
{
    return [self.model lowercaseString];
}

// Return the local MAC addy
// Courtesy of FreeBSD hackers email list

- (NSString *) macAddress{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

- (BOOL) isJailBroken
{
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt";
    if([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath])
    {
        return YES;
    }
    if([[NSFileManager defaultManager] fileExistsAtPath:aptPath])
    {
        return YES;
    }
    return NO;
}

// 内存信息
+ (unsigned int)freeMemory{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return (unsigned int)(vm_stat.free_count * pagesize);
}

+ (unsigned int)usedMemory{
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (unsigned int)((kerr == KERN_SUCCESS) ? info.resident_size : 0);
}

+ (BOOL) isRetina
{
    return [[UIScreen mainScreen] scale] >= 2.0;
}

+ (double) screenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (double) screenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (double)screenMaxLength
{
    return MAX([self screenWidth], [self screenHeight]);
}

+ (double)screenMinLength
{
    return MIN([self screenWidth], [self screenHeight]);
}

+ (BOOL) isIPhone4OrLess
{
    return [self isiPhone] && [self screenMaxLength] < 568.0;
}

+ (BOOL) isIPhone5
{
    return [self isiPhone] && [self screenMaxLength] == 568.0;
}

+ (BOOL) isIPhone5OrLess
{
    return [self isiPhone] && [self screenMaxLength] <= 568.0;
}

+ (BOOL) isIPhone6
{
    return [self isiPhone] && [self screenMaxLength] == 667.0;
}

+ (BOOL) isIPhone6P
{
    return [self isiPhone] && [self screenMaxLength] == 736.0;
}

+ (uint64_t)totalDiskSpace
{
    uint64_t totalSpace = 0;
    
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    return totalSpace;
}
+ (uint64_t)freeDiskSpace
{
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    return totalFreeSpace;
}

+ (NSString *)hardwareString
{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    return platform;
}


@end
