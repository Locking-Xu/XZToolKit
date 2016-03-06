//
//  XZImageCategoryViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZImageCategoryViewController.h"
#import "UIImage+Bitmap.h"

@interface XZImageCategoryViewController ()

@end

@implementation XZImageCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    UIImage *image = XZGetImageFromBundle(@"2", @"png");
    imageView.image = [image imageRotateByRadius:.8];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
