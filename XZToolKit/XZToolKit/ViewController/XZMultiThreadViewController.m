//
//  XZMultiThreadViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZMultiThreadViewController.h"
#import "UINavigationController+Common.h"
#import "XZBlogListViewController.h"

@interface XZMultiThreadViewController ()

@end

@implementation XZMultiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController addSystemRightButton:UIBarButtonSystemItemSearch delegate:self action:@selector(detailBtn_Pressed)];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIButton_Pressed
- (void)detailBtn_Pressed{
    
    [self.navigationController setBackItemTitle:@"" viewController:self];
    XZBlogListViewController *blogListVc = [[XZBlogListViewController alloc] init];
    blogListVc.title = self.title;
    blogListVc.listName = @"MultiThreadList";
    [self.navigationController pushViewController:blogListVc animated:YES];
}

@end