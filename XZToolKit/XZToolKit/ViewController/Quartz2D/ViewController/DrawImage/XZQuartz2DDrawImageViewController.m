//
//  XZQuartz2DDrawImageViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DDrawImageViewController.h"

@interface XZQuartz2DDrawImageViewController ()
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XZQuartz2DDrawImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    
    self.imageView.image = [self drawImage:self.view.frame.size];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  绘制图片
 */
- (UIImage *)drawImage:(CGSize)size{

    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 8.0f);
    //-------绘制-------
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextStrokeRect(context, CGRectMake(30, 30, 100, 100));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
