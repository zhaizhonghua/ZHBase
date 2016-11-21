//
//  ZHBaseViewController.m
//  base
//
//  Created by 翟中华 on 16/11/3.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "ZHBaseViewController.h"

#import "ZHBaseViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "ZHNetTroubleView.h"
@interface ZHBaseViewController ()

@property(nonatomic,strong) AFNetworkReachabilityManager *reachabilityManger;
@property(nonatomic,strong) ZHNetTroubleView *netTroubleView;

@end

@implementation ZHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChangeNotifiaction) name:NOTIF_NETWORK_REACHABILITY object:nil];
    if (self.type == UIBaseCStyleLoading) {
        [MBProgressHUD showloadingGifHUDToView:self.view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(AFNetworkReachabilityManager *)reachabilityManger{
    
    if (!_reachabilityManger) {
        _reachabilityManger =[AFNetworkReachabilityManager sharedManager];
    }
    return _reachabilityManger;
}

-(BOOL)isWIFI{
    
    return self.reachabilityManger.isReachableViaWiFi;
}
-(BOOL)isWWAN{
    return self.reachabilityManger.isReachableViaWWAN;
}
-(BOOL)isReachable{
    return  self.reachabilityManger.isReachable;
}

-(void)netWorkChangeNotifiaction{
    
    //重写这个方法处理网络变化
    
}


-(void)setNavRightBtn:(NSString*)buttonTitle OrStyle:(UIButtonStyle)style;
{
    UIImage *rightImage;
    if(style == UIButtonStyleMore){
        rightImage =[UIImage imageNamed:@"more"];
    }else if(style == UIButtonStyleSearch){
        rightImage =[UIImage imageNamed:@"search2"];
    }else if (style == UIButtonStyleAdd){
        rightImage =[UIImage imageNamed:@"add"];
    }
    
    if (buttonTitle.length >0 && style == UIButtonStyleNone) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:buttonTitle style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick)];
    }
}

-(void)rightBtnClick{
    //重写这个方法处理Navgaition右边按钮事件
}

- (void)showNetTrobleView:(CGRect)frame trouble:(Trouble)trouble {
    
    [self.view addSubview:self.netTroubleView];
    self.netTroubleView.frame = frame;
    
    if (trouble == NetTrouble) {
        [self netTrouble];
    } else {
        [self dataTrouble];
    }
    
}

- (void)removeNetTrobleView {
    
    [self.netTroubleView removeFromSuperview];
}

- (void)netTrouble {
    self.netTroubleView.promptIcon = @"无线";
    self.netTroubleView.promptText = @"哎呀，网络好像有点问题。";
}

- (void)dataTrouble {
    self.netTroubleView.promptIcon = @"悲伤";
    self.netTroubleView.promptText = @"哎呀，暂时没有数据，再刷新看看。";
}
- (ZHNetTroubleView *)netTroubleView {
    if (!_netTroubleView) {
        _netTroubleView = [[ZHNetTroubleView alloc] init];
        _netTroubleView.backgroundColor = THEME_BG_COLOR;
    }
    
    [_netTroubleView.reloadBtn addTarget:self action:@selector(reloadAction:) forControlEvents:UIControlEventTouchUpInside];
    return _netTroubleView;
}
- (void)setReloadBtnHiden:(BOOL)reloadBtnHiden {
    if (reloadBtnHiden) {
        self.netTroubleView.reloadBtn.hidden = YES;
    } else {
        self.netTroubleView.reloadBtn.hidden = NO;
    }
}
- (void)reloadAction:(UIButton *)sender {
    //重写此方法处理重新加载事件
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
