//
//  ZHThemeManger.m
//  base
//
//  Created by 翟中华 on 16/11/3.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "ZHThemeManger.h"
#import "AppDelegate.h"

@implementation ZHThemeManger

+ (void)configTheme
{
    [[UINavigationBar appearance] setBarTintColor:[self navigationBarColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    if(iOS8 && [UINavigationBar conformsToProtocol:@protocol(UIAppearanceContainer)]) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    if ([UIDevice isIPhone6P] || [UIDevice isIPhone6]) {
        [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter" size:17.0] }];
    }else{
        [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor] }];
    }
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}



+(UIColor *)navigationBarColor
{
    return THEME_NAVBAR_COLOR;
}
@end
