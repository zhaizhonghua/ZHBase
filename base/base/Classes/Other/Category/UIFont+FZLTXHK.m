//
//  UIFont+FZLTXHK.m
//  digua
//
//  Created by NorthKing on 16/4/16.
//  Copyright © 2016年 xiangyang. All rights reserved.
//

#import "UIFont+FZLTXHK.h"

@implementation UIFont (FZLTXHK)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

+(UIFont *)systemFontOfSize:(CGFloat)fontSize{
    
    if (ZHScreenH > 667) {
        fontSize += 2;
    }
    
    UIFont *newFont = [UIFont fontWithName:@"Helvetica" size:fontSize];//自定字体
    return newFont;
}

+(UIFont *)boldSystemFontOfSize:(CGFloat)fontSize
{
    if (ZHScreenH > 667) {
        fontSize += 2;
    }
    
    UIFont *newFont = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];//自定字体
    return newFont;
}

#pragma clang diagnostic pop

@end
