//
//  XZGuideViewController.m
//  OctopusNotebooks
//
//  Created by 徐章 on 15/9/26.
//  Copyright © 2015年 徐章. All rights reserved.
//

#import "XZGuideViewController.h"
#import "XZGuideView.h"

@interface XZGuideViewController ()

@end

@implementation XZGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    XZGuideView *guideView = [[XZGuideView alloc] initWithFrontImageArray:@[@"img_index_01txt",@"img_index_02txt",@"img_index_03txt"] backgroundImageArray:@[@"img_index_01bg",@"img_index_02bg",@"img_index_03bg"]];
    
    [self.view addSubview:guideView];
    
    guideView.finishBlock = ^{
        
        [self.navigationController popViewControllerAnimated:YES];
        
        self.navigationController.navigationBarHidden = NO;
        
    };
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
