//
//  NSString+check.h
//  digua
//
//  Created by NorthKing on 16/4/21.
//  Copyright © 2016年 xiangyang. All rights reserved.
/* 检查字符串是否包含非法字符 正则判断 */

#import <Foundation/Foundation.h>

@interface NSString (check)

/**
 *  检查字符串是否包含非法字符
 *
 *  @return 返回YES代表有非法字符
 */
-(BOOL)checkCharactersIllegal;

/** 正则判断非法字符 */
- (BOOL)JudgeTheillegalCharacter;
/** 正则判断emoji */
- (BOOL)stringContainsEmoji;
/** 过滤emoji */
- (NSString *)filterEmoji;

@end
