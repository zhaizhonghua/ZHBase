//
//  UIView+Utils.h
//  Core
//
//  Created by Su Ying on 15/2/9.
//  Copyright (c) 2015年 Passion4Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 *  左下角坐标
 */
@property (readonly) CGPoint bottomLeft;
/**
 *  右下角坐标
 */
@property (readonly) CGPoint bottomRight;
/**
 *  右上角坐标
 */
@property (readonly) CGPoint topRight;

/**
 *  移动
 *
 *  @param delta 偏移量
 */
- (void) moveBy: (CGPoint) delta;
/**
 *  缩放
 *
 *  @param scaleFactor 缩放倍数
 */
- (void) scaleBy: (CGFloat) scaleFactor;
/**
 *  缩小到指定大小的尺寸
 *
 *  @param aSize 指定大小的尺寸
 */
- (void) fitInSize: (CGSize) aSize;

#pragma mark 控件截图
/**
 *  截取指定控件上得图片（控件截图）
 *
 *  @param size  需要截图的大小
 *  @param view  截取那个控件
 *  @param scale 缩放比例
 *
 *  @return 返回截图
 */
+(UIImage *)screenShotsWithSize:(CGSize)size WithView:(UIView*)view WithScale:(CGFloat)scale;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;


/**
 * Calculates the offset of this view from another view in screen coordinates.
 *
 * otherView should be a parent view of this view.
 */
- (CGPoint)offsetFromView:(UIView*)otherView;

/** 展示主窗口 */
- (BOOL)isShowingOnKeyWindow;

@end