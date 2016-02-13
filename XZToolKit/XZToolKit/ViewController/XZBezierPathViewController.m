//
//  XZBezierPathViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/7.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZBezierPathViewController.h"
#import "XZBezierPathView.h"

@interface XZBezierPathViewController ()

@end

@implementation XZBezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    XZBezierPathView *view = [[XZBezierPathView alloc] initWithFrame:self.view.bounds];
    
    view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:view];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
