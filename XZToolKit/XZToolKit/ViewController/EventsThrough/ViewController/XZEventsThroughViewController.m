//
//  XZEventsThroughViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZEventsThroughViewController.h"
#import "XZEventsThroughView.h"

@interface XZEventsThroughViewController ()

@end

@implementation XZEventsThroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    button.backgroundColor = [UIColor yellowColor];
    [button setTitle:@"Click" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button_Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    XZEventsThroughView *view = [[XZEventsThroughView alloc] initWithFrame:CGRectMake(100, 50, 200, 200)];
    view.eventsThroughViews = @[button];
    view.backgroundColor = [UIColor redColor];
    view.alpha = 0.5;
    
    [self.view addSubview:view];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)button_Pressed{

    XZObjectLog(@"点击");
}

@end
