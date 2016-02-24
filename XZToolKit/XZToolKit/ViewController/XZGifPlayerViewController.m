//
//  XZGifPlayerViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/23.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGifPlayerViewController.h"
#import "XZGifPlayerView.h"
#import "XZGenerateGifHelper.h"

@interface XZGifPlayerViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation XZGifPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"birdFly" ofType:@"gif"];
    //方法一
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.webView loadData:data MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL new]];
    
    
    //方法二
//    NSURL *url = [NSURL fileURLWithPath:path];
//    XZGifPlayerView *view = [[XZGifPlayerView alloc] initWithFrame:self.view.bounds fileUrl:url];
//    [self.view addSubview:view];
    
//    [view startAnimation];
    
    //从视屏中生成GIF
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"mp4"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    XZGenerateGifHelper *generateGifHelper = [[XZGenerateGifHelper alloc] init];
//    [generateGifHelper generateGifFromUrl:url loopCount:0 FPS:30 completeBlock:^(NSURL *url) {
//       
//        XZObjectLog(url);
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter && Getter
- (UIWebView *)webView{
    
    if (!_webView) {
        
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_webView];
        _webView.backgroundColor = [UIColor redColor];
    }
    return _webView;
}

@end
