//
//  ZHTool.m
//  base
//
//  Created by 翟中华 on 16/11/4.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "ZHTool.h"

@implementation ZHTool

+(AppDelegate *)shareAppHandle
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
