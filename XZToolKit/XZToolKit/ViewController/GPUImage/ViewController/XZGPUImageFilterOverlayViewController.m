//
//  XZGPUImageFilterOverlayViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/15.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGPUImageFilterOverlayViewController.h"
#import <GPUImage/GPUImage.h>
@interface XZGPUImageFilterOverlayViewController ()

@end

@implementation XZGPUImageFilterOverlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    UIImage *image = [UIImage imageNamed:@"2"];
    
    GPUImagePicture *sourceImage = [[GPUImagePicture alloc] initWithImage:image smoothlyScaleOutput:YES];
    
    GPUImageSepiaFilter *filter1 = [[GPUImageSepiaFilter alloc] init];
    GPUImageVignetteFilter *filter2 = [[GPUImageVignetteFilter alloc] init];
    filter2.vignetteStart = 0.4;
    filter2.vignetteEnd = 0.6;
    
    [sourceImage addTarget:filter1];
    [filter1 addTarget:filter2];
    
    [filter2 useNextFrameForImageCapture];
    
    [sourceImage processImageWithCompletionHandler:^{
        
        NSLog(@"完成");
        UIImage *image = [filter2 imageFromCurrentFramebuffer];
        
        imageView.image = image;
        
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
