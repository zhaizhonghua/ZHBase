//
//  UITabBar+CentreBtn.m
//  base
//
//  Created by 翟中华 on 16/11/10.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "UITabBar+CentreBtn.h"
#import <objc/runtime.h>

@implementation UITabBar (CentreBtn)

static NSString *AssociatedButtonKey;

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self xzm_swizzledMethodWithOriginalSelector:@selector(initWithFrame:)   swizzledSelector:@selector(swizzled_initWithFrame:)];
//        [self xzm_swizzledMethodWithOriginalSelector:@selector(layoutSubviews) swizzledSelector:@selector(swizzled_layoutSubviews)];
//    });
//}

+ (void)xzm_swizzledMethodWithOriginalSelector:(SEL)originalSelector
                              swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod([self class], originalSelector);
    
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    
    BOOL didAddMethod = class_addMethod([self class], originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod([self class], swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (instancetype)swizzled_initWithFrame:(CGRect)frame
{
    id instance = [self swizzled_initWithFrame:frame];
    
    UIButton *centerButton = objc_getAssociatedObject(self, &AssociatedButtonKey);
    if (!centerButton) {
        centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        objc_setAssociatedObject(self, &AssociatedButtonKey, centerButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self addSubview:centerButton];
    
    return instance;
}

- (void)swizzled_layoutSubviews
{
    [self swizzled_layoutSubviews];
    
    [self setValue:[NSValue valueWithCGRect:self.bounds] forKeyPath:@"_backgroundView.frame"];
    
    UIButton *centerButton = objc_getAssociatedObject(self, &AssociatedButtonKey);
    
    if (centerButton == nil) return;
    
    centerButton.bounds = CGRectMake(0, 0, centerButton.currentBackgroundImage.size.width, centerButton.currentBackgroundImage.size.height);
    CGFloat buttonW = self.frame.size.width / (self.items.count + 1);
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    CGFloat buttonX = 0;
    int index = 0;
    
    centerButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    for (UIView *chidView in self.subviews) {
        if ([chidView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            buttonX = index *buttonW;
            index++;
            if (index == 2) {
                index++;
            }
            chidView.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        }
    }
}

- (void)setUpTabBarCenterButton:(void ( ^ _Nullable )(UIButton * _Nullable centerButton ))centerButtonBlock
{
    centerButtonBlock(objc_getAssociatedObject(self, &AssociatedButtonKey));
}


@end
