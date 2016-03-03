//
//  XZQuartz2DPolygonViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/3.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZQuartz2DPolygonViewController.h"
#import "XZQuartz2DPolygonView.h"

@interface XZQuartz2DPolygonViewController ()

@end

@implementation XZQuartz2DPolygonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XZQuartz2DPolygonView *view = [[XZQuartz2DPolygonView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: view];
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
