//
//  ZHRefreshGifHeader.m
//  base
//
//  Created by 翟中华 on 16/11/3.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "ZHRefreshGifHeader.h"

@implementation ZHRefreshGifHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    /*** 下面的设置无论是 继承默认加载或者继承动画加载类 都可以设置并且头部和尾部刷新都可以 ***/
    self.stateLabel.font = [UIFont systemFontOfSize:17];//设置字体字号大小
    self.stateLabel.textColor = [UIColor blueColor];//设置字体颜色
    self.lastUpdatedTimeLabel.hidden = YES;//是否隐藏时间提示
    self.stateLabel.hidden = YES;//是否隐藏加载状态
}
@end
