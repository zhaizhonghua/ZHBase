//
//  ZHBaseViewController.h
//  base
//
//  Created by 翟中华 on 16/11/3.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    NetTrouble,// 网络问题
    DataTrouble,// 数据问题
} Trouble;

typedef enum
{
    UIButtonStyleBack,              // 返回
    UIButtonStyleNone,              // 没有
    UIButtonStyleSearch,            // 搜索
    UIButtonStyleAdd,               // 添加
    UIButtonStyleMore               // 菜单
} UIButtonStyle;

typedef NS_ENUM(NSInteger, UIBaseCStyle) {
    UIBaseCStyleNormal = 0,
    UIBaseCStyleLoading,
};

@interface ZHBaseViewController : UIViewController

//网络状态判断
-(void)netWorkChangeNotifiaction;//网络改变通知
-(BOOL)isWIFI;
-(BOOL)isWWAN;
-(BOOL)isReachable;//是否有网
// ----------- 没有网络 || 没有数据 -----------
@property (nonatomic, assign) UIBaseCStyle type;
@property (nonatomic, assign) BOOL reloadBtnHiden;
- (void)showNetTrobleView:(CGRect)frame trouble:(Trouble)trouble;
- (void)removeNetTrobleView;

/**设置导航栏右边按钮，如果设置了style的话，标题无效*/
-(void)setNavRightBtn:(NSString*)buttonTitle OrStyle:(UIButtonStyle)style;
-(void)rightBtnClick;
@end
