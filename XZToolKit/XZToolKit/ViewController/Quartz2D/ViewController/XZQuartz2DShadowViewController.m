//
//  XZQuartz2DShadowViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/25.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DShadowViewController.h"
#import "XZQuartz2DShadowView.h"

@interface XZQuartz2DShadowViewController ()

@end

@implementation XZQuartz2DShadowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XZQuartz2DShadowView *shadowView = [[XZQuartz2DShadowView alloc] initWithFrame:self.view.bounds];
    shadowView.backgroundColor = [UIColor whiteColor];
    self.view = shadowView;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
