//
//  ZHTabBarController.m
//  base
//
//  Created by 翟中华 on 16/11/3.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "ZHTabBarController.h"
#import "ZHHomeViewController.h"
#import "ZHMeViewController.h"
#import "ZHFoundViewController.h"
#import "ZHBaseViewController.h"
#import "UITabBar+CentreBtn.h"
#import "ZHSearchViewController.h"
#import "ZHUploadViewController.h"

@interface ZHTabBarController ()

@end

@implementation ZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabBar];
}

-(void)initTabBar
{
    NSMutableArray *vcs = [NSMutableArray array];
    
    NSArray *images = @[@"home_normal", @"order_normal",@"order_normal", @"search_normal", @"me_normal"];
    NSArray *imageselect = @[@"home_selected", @"order_selected", @"order_selected",@"me_selected", @"me_selected"];
    NSArray *title = @[@"首页", @"发现",@"上传",@"搜索" ,@"我的"];
    NSArray *class = @[@"ZHHomeViewController", @"ZHFoundViewController",@"ZHUploadViewController",@"ZHSearchViewController",@"ZHMeViewController"];
    
    for(int i = 0; i < class.count; i++){
        ZHBaseViewController *page = [[NSClassFromString((NSString*)class[i]) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:page];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title[i] image:[[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:imageselect[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [vcs addObject:nav];
    }
    
    self.viewControllers = vcs;
    self.customizableViewControllers = vcs;
//    [self setCentreButton];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBColor(100, 100, 100),  NSForegroundColorAttributeName,[UIFont systemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateSelected];
    
#ifdef __IPHONE_7_0
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = RGBAColor(235, 235, 235,0.5);
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
#else
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [BASETCBKCOLOR CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.tabBar.backgroundImage = image;
#endif
    
}

/** 配置中间按钮 */
-(void)setCentreButton
{
    [self.tabBar setUpTabBarCenterButton:^(UIButton *centerButton) {
        [centerButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        [centerButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [centerButton addTarget:self action:@selector(chickCenterButton) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)chickCenterButton
{
    NSLog(@"点击了中间按钮");
    [self presentViewController:[[ZHMeViewController alloc] init] animated:YES completion:nil];
}

@end
