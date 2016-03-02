//
//  XZBlogWebViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZBlogWebViewController.h"
#import "XZAPIHelper.h"
#import <NJKWebViewProgress/NJKWebViewProgressView.h>
#import <NJKWebViewProgress/NJKWebViewProgress.h>
#import "UINavigationController+Common.h"

@interface XZBlogWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>{

    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    UIWebView *_webView;
}

@end

@implementation XZBlogWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController addSystemRightButton:UIBarButtonSystemItemRefresh delegate:self action:@selector(reloadBtn_Pressed)];
    
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate =_progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.0f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    [self.navigationController.navigationBar addSubview:_progressView];
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *resquest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:resquest];
    
    [self.view addSubview:_webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}

- (void)reloadBtn_Pressed{

    [_webView reload];
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}
@end
