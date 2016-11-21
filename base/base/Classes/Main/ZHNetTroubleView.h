//
//  ZHNetTroubleView.h
//  YiHua
//
//  Created by 翟中华 on 16/11/14.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHNetTroubleView : UIView

/** 提示图片 */
@property (nonatomic, copy) NSString *promptIcon;
/** 提示文字 */
@property (nonatomic, copy) NSString *promptText;
/** 重新加载 */
@property (nonatomic, strong) UIButton *reloadBtn;

@end
