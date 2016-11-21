//
//  ZHWebViewController.h
//  base
//
//  Created by 翟中华 on 16/11/7.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "ZHBaseViewController.h"

typedef NS_ENUM(NSInteger, UINavigationCStyle) {
    UINavigationCStyleNormal = 0,
    UINavigationCStyleAD,
    UINavigationCStyleShare,
};
@interface ZHWebViewController : ZHBaseViewController

/**
 *  加载网址
 */
@property (nonatomic) NSString *url;
/**
 *  导航栏标题
 */
@property (nonatomic, copy) NSString *navigItemTitle;
/**
 *  是否为分享类 UINavigation
 */
@property (nonatomic,assign)UINavigationCStyle NavigCStyle;
/**
 *  分享的图标
 */
@property (nonatomic, copy) NSString *imageId;
/**
 *  分享的主标题
 */
@property (nonatomic, copy) NSString *mainTitle;
/**
 *  分享的副标题
 */
@property (nonatomic, copy) NSString *subTitle;

@end
