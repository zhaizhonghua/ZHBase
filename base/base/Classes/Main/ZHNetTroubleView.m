//
//  ZHNetTroubleView.m
//  YiHua
//
//  Created by 翟中华 on 16/11/14.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "ZHNetTroubleView.h"

#define TextFont 15.0f
@interface ZHNetTroubleView ()

@property (nonatomic, strong) UIImageView *troubleImage;
@property (nonatomic, strong) UILabel *troubleLabel;

@end
@implementation ZHNetTroubleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    [self addSubview:self.troubleImage];
    [self addSubview:self.troubleLabel];
    [self addSubview:self.reloadBtn];
}

- (void)layoutSubviews {
    
    //图片
    CGFloat imageWH ;
    CGFloat imageY;
    CGFloat labelY;
    imageWH = self.width * 0.25;
    if (self.height == ZHScreenW ) {
        imageY = imageWH / 2 + 64;
    }else{
        imageY = imageWH / 2;
    }
    labelY = imageY + imageWH ;
    CGFloat imageX = (self.width - imageWH) * 0.5;
    
    _troubleImage.frame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //文字
    CGFloat labelX = 20;
    CGFloat labelW = self.width - 2 * labelX;
    CGFloat labelH = 80;
    _troubleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    //重新加载
    CGFloat buttonW = 80*ZHSCALEX;
    CGFloat buttonH = 30;
    CGFloat buttonX = (self.width - buttonW) * 0.5;
    CGFloat buttonY = _troubleLabel.bottom + 20;
    _reloadBtn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
}

- (UIImageView *)troubleImage {
    if (!_troubleImage) {
        _troubleImage = [[UIImageView alloc] init];
    }
    return _troubleImage;
}

- (UILabel *)troubleLabel {
    if (!_troubleLabel) {
        _troubleLabel = [[UILabel alloc] init];
        _troubleLabel.textAlignment = NSTextAlignmentCenter;
        _troubleLabel.numberOfLines = 0;
        _troubleLabel.textColor = RGBColor(149, 149, 149);
        _troubleLabel.font = [UIFont systemFontOfSize:TextFont];
    }
    return _troubleLabel;
}

- (UIButton *)reloadBtn {
    if (!_reloadBtn) {
        _reloadBtn = [[UIButton alloc] init];
        _reloadBtn.backgroundColor = RGBColor(149, 149, 149);
        _reloadBtn.titleLabel.font = [UIFont systemFontOfSize:TextFont];
        [_reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [_reloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _reloadBtn;
}

- (void)setPromptIcon:(NSString *)promptIcon {
    self.troubleImage.image = [UIImage imageNamed:promptIcon];
}

- (void)setPromptText:(NSString *)promptText {
    self.troubleLabel.text = promptText;
}

@end
