//
//  XZBlogWebViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZBlogWebViewController.h"
#import "XZAPIHelper.h"

@interface XZBlogWebViewController ()<UIWebViewDelegate>

@end

@implementation XZBlogWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *resquest = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:resquest];
    
    [[XZAPIHelper shareInstance] downloadWith:self.url];
    
    [self.view addSubview:webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"%@",request.URL.absoluteString);
    return YES;
}

@end
