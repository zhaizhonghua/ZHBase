//
//  UITabBar+CentreBtn.h
//  base
//
//  Created by 翟中华 on 16/11/10.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (CentreBtn)

// 设置个性化中间按钮(把.m文件中的 load 方法放开即可)
- (void)setUpTabBarCenterButton:(void ( ^ _Nullable )(UIButton * _Nullable centerButton ))centerButtonBlock;

@end
