//
//  ZHNavigationController.m
//  base
//
//  Created by 翟中华 on 16/11/3.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "ZHNavigationController.h"

@interface ZHNavigationController ()

@end

@implementation ZHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count) { // 隐藏导航栏
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        //        // 自定义返回按钮
        //        viewController.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_9x16"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        //
        //        // 如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        //        __weak typeof(viewController)Weakself = viewController;
        //        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
