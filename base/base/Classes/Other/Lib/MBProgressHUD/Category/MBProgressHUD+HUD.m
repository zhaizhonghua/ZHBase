//
//  MBProgressHUD+HUD.m
//  MBProgressHUD
//
//  Created by zhuchenglong on 16/7/23.
//  Copyright © 2016年 zhuchenglong. All rights reserved.
//

#import "MBProgressHUD+HUD.h"
#define DelayTime 1.5

@implementation MBProgressHUD (HUD)

/***
 最新版本的背景颜色的灰色半透明和黑色字，不喜欢的话可以用下面的方法修改：
 
 方框背景颜色(也可直接在MBProgressHUD.m的1111行修改)
 hud.bezelView.color = [UIColor blueColor];
 菊花和文字颜色
 hud.contentColor = [UIColor whiteColor];
 ***/


/** 只显示菊花 **/
+(void)showLoadHUD{
    
    [MBProgressHUD hideHUD];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    //hud.userInteractionEnabled = NO;
    hud.contentColor = [UIColor whiteColor];
}


//显示菊花+文字
+(void)showLoadHUDMsg:(NSString *)message{
    
    //    [MBProgressHUD hideHUD];
    //
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    //    //方框背景颜色(也可直接在MBProgressHUD.m的1111行修改)
    //    //hud.bezelView.color = [UIColor blueColor];
    //    //菊花和文字颜色
    //    hud.contentColor = [UIColor whiteColor];
    //    hud.label.text = message;
    
    [self showLoadHUDMsg:message toView:nil];
}


+(void)showLoadHUDMsg:(NSString *)message toView:(UIView *)view
{
    [MBProgressHUD hideHUD];
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //方框背景颜色(也可直接在MBProgressHUD.m的1111行修改)
    //hud.bezelView.color = [UIColor blueColor];
    //背景颜色和透明度
    //hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.2f];
    //菊花和文字颜色
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = message;
}
//显示文字-->几秒钟后消失
+(void)showHUDMsg:(NSString *)message{
    
    [MBProgressHUD hideHUD];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.contentColor = [UIColor whiteColor];
    //可以设置显示的位置
    // hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:DelayTime];
}

/** 环形进度条+文字 **/
+(void)showCircularHUDProgress{
    
    [MBProgressHUD hideHUD];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.mode = MBProgressHUDModeDeterminate,
    hud.label.text = @"加载中...";
}

/** 更新progress进度 **/
+(MBProgressHUD *)getHUDProgress{
    
    return [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
    
}


/** 水平进度条 + 文字 **/
+(void)showBarHUDProgress{
    
    [MBProgressHUD hideHUD];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text = @"加载中...";
}

/** 自定义图片 + 文字 **/
+(void)showCustomViewHUD:(NSString *)msg imageName:(NSString *)imageName{
    
    [MBProgressHUD hideHUD];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeCustomView;
    //设置显示的图片
    UIImage *image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    hud.label.text = msg;
    [hud hideAnimated:YES afterDelay:DelayTime];
}


/** 自定义加载动画 + 文字 **/
+(void)showCustomGifHUD:(NSString *)msg imageName:(NSString *)imageName{
    
    //    [MBProgressHUD hideHUD];
    //
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    //    hud.contentColor = [UIColor whiteColor];
    //    hud.mode = MBProgressHUDModeCustomView;
    //
    //    //设置显示的图片
    //    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    //
    //    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    //    rotationAnimation.duration = 0.6;
    //    rotationAnimation.cumulative = YES;
    //    rotationAnimation.repeatCount = 20000;//重复次数
    //    [hud.customView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    //
    //    // Looks a bit nicer if we make it square.
    //    hud.square = YES;
    //    hud.label.text = msg;
    
    [self showCustomGifHUD:msg imageName:imageName toView:nil];
}
+(void)showCustomGifHUD:(NSString *)msg imageName:(NSString *)imageName toView:(UIView *)view
{
    [MBProgressHUD hideHUD];
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeCustomView;
    
    //设置显示的图片
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 0.6;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 20000;//重复次数
    [hud.customView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    hud.label.text = msg;
}
+(void)showloadingGifHUDToView:(UIView *)view
{
    [self showCustomGifHUD:@"加载中..." imageName:LOADING_IMAGE toView:view];
}


//隐藏HUD
+(void)hideHUD{
    
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
