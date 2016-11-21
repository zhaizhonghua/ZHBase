//
//  ZHWebViewController.m
//  base
//
//  Created by 翟中华 on 16/11/7.
//  Copyright © 2016年 yihua. All rights reserved.
//

#import "ZHWebViewController.h"

@interface ZHWebViewController ()<UIWebViewDelegate>
{
    UIWebView *web;
}
@end

@implementation ZHWebViewController


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = [NSString stringWithFormat:@"%@",_navigItemTitle ? _navigItemTitle : @"内容"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigation];
    
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
    web.delegate = self;
    ((UIScrollView *)[web.subviews objectAtIndex:0]).bounces = NO;
    web.scalesPageToFit = YES;
    web.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:web];
    
    if(_url != nil && _url.length > 0){
        
        if([_url rangeOfString:@"http"].location !=NSNotFound){
            
        }else{
            _url = [@"http://" stringByAppendingFormat:@"%@",_url];
        }
        
        NSURL *uri = [NSURL URLWithString:_url];
        NSURLRequest *request= [[NSURLRequest alloc] initWithURL:uri];
        [web loadRequest:request];
        [MBProgressHUD showLoadHUDMsg:@"加载中..."];
        
    }
    
}

#pragma mark - Methods
-(void)initNavigation
{
    if (self.NavigCStyle == UINavigationCStyleAD) {
        UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
        backItem.target = self;
        backItem.image=[UIImage imageNamed:@"back"];
        backItem.action =@selector(goBackPressed);
        [[self navigationItem] setLeftBarButtonItem:backItem];
    }else if (self.NavigCStyle == UINavigationCStyleShare){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fenxiang"]  style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    }
}

-(void)goBackPressed
{
    [[ZHTool shareAppHandle] pushMainRootController];
    
    //    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    //        [[ZHTool shareAppHandle] pushMainRootController];
    //    }];
    
}

#pragma - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Share
-(void)shareAction
{
    NSLog(@"你点击了分享按钮");
}


@end
