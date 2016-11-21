//
//  AppDelegate+LaunchAd.m
//  base
//
//  Created by 翟中华 on 16/11/4.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "AppDelegate+LaunchAd.h"
#import "XHLaunchAd.h"

//静态广告
#define ImgUrlString1 @"http://d.hiphotos.baidu.com/image/pic/item/14ce36d3d539b60071473204e150352ac75cb7f3.jpg"
//动态广告
#define ImgUrlString2 @"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg"

@implementation AppDelegate (LaunchAd)

-(void)startLaunchAd
{
    /**
     *  1.显示启动页广告
     */
    [XHLaunchAd showWithAdFrame:CGRectMake(0, 0,self.window.bounds.size.width, self.window.bounds.size.height-150) setAdImage:^(XHLaunchAd *launchAd) {
        
        //未检测到广告数据,启动页停留时间,不设置默认为3,(设置4即表示:启动页显示了4s,还未检测到广告数据,就自动进入window根控制器)
        //launchAd.noDataDuration = 4;
        
        //获取广告数据
        [self requestImageData:^(NSString *imgUrl, NSInteger duration, NSString *openUrl) {
            
            /**
             *  2.设置广告数据
             */
            
            //定义一个weakLaunchAd
            __weak __typeof(launchAd) weakLaunchAd = launchAd;
            [launchAd setImageUrl:imgUrl duration:duration skipType:SkipTypeTimeText options:XHWebImageDefault completed:^(UIImage *image, NSURL *url) {
                
                //异步加载图片完成回调(若需根据图片尺寸,刷新广告frame,可在这里操作)
                //weakLaunchAd.adFrame = ...;
                
            } click:^{
                
                //广告点击事件
                
                //1.用浏览器打开
                //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
                
                //2.在webview中打开
                ZHWebViewController *webVC = [[ZHWebViewController alloc] init];
                webVC.navigItemTitle = @"广告";
                webVC.NavigCStyle = UINavigationCStyleAD;
                webVC.url = openUrl;
                UINavigationController *webNav = [[UINavigationController alloc] initWithRootViewController:webVC];
                [weakLaunchAd presentViewController:webNav animated:YES completion:nil];
                
            }];
            
        }];
        
    } showFinish:^{
        
        //广告展示完成回调,设置window根控制器
//        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        [[ZHTool shareAppHandle] pushMainRootController];
        
    }];
}

/**
 *  模拟:向服务器请求广告数据
 *
 *  @param imageData 回调imageUrl,及停留时间,跳转链接
 */
-(void)requestImageData:(void(^)(NSString *imgUrl,NSInteger duration,NSString *openUrl))imageData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(imageData)
        {
            imageData(ImgUrlString2,5,@"http://www.returnoc.com");
        }
    });
}
@end
