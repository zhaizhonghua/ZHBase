//
//  ZHGuideViewController.m
//  base
//
//  Created by 翟中华 on 16/11/4.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "ZHGuideViewController.h"
#import "DHGuidePageHUD.h"
#import "ZHLoginViewController.h"

@interface ZHGuideViewController ()
{
    ZHLoginViewController *loginC;
}
@end

@implementation ZHGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    loginC = [[ZHLoginViewController alloc]init];
    
    // 静态引导页
    [self setStaticGuidePage];
    
    // 动态引导页
    // [self setDynamicGuidePage];
    
    // 视频引导页
    //[self setVideoGuidePage];
    
    
}


#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"guideImage1.jpg",@"guideImage2.jpg",@"guideImage3.jpg",@"guideImage4.jpg",@"guideImage5.jpg"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    guidePage.slideInto = YES;
    WEAKSELF
    //__weak typeof(DHGuidePageHUD) *weakGuidePage = guidePage;
    guidePage.removeBlock = ^(){//自己添加处理视图消失后的逻辑（不写走默认方法）
        //[weakGuidePage removeFromSuperview];
        //[weakSelf.navigationController pushViewController:loginC animated:YES];
        [[ZHTool shareAppHandle] pushMainRootController];
    };
    [self.view addSubview:guidePage];
}

#pragma mark - 设置APP动态图片引导页
- (void)setDynamicGuidePage {
    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = YES;
    [self.view addSubview:guidePage];
}

#pragma mark - 设置APP视频引导页
- (void)setVideoGuidePage {
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"]];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.bounds videoURL:videoURL];
    [self.view addSubview:guidePage];
}


@end
