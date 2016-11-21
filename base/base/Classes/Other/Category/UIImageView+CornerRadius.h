//
//  UIImageView+CornerRadius.h
//  MyPractise
//
//  Created by lzy on 16/3/1.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (CornerRadius)



- (void)zy_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (void)zy_cornerRadiusRoundingRect;

/**
 *  设置圆角和边框颜色
 *
 *  @param cornerRadius    圆角半径
 *  @param rectCornerType  指定要设置的角
 *
 */
- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;
/**
 *  切圆图
 *
 *  @return 圆图
 */
- (instancetype)initWithRoundingRectImageView;


/**
 *  给图加边框
 *
 *  @param width 边框宽
 *  @param color 边框颜色
 */
- (void)zy_attachBorderWidth:(CGFloat)width color:(UIColor *)color;


@end
