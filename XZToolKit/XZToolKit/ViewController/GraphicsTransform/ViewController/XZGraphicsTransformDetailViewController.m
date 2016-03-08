//
//  XZGraphicsTransformDetailViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/7.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGraphicsTransformDetailViewController.h"
#import "XZGraphicsTransformView.h"
#import "XZSnowView.h"
#import "XZMatrixTransformView.h"
#import "XZBlendModeView.h"

@interface XZGraphicsTransformDetailViewController ()

@end

@implementation XZGraphicsTransformDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.title isEqualToString:@"坐标变换"]) {

       XZGraphicsTransformView *graphicsView = [[XZGraphicsTransformView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        graphicsView.backgroundColor = [UIColor whiteColor];
        self.view = graphicsView;
        
    }else if ([self.title isEqualToString:@"坐标变换与路径"]){
        
       XZSnowView *snowView = [[XZSnowView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        snowView.backgroundColor = [UIColor whiteColor];
        self.view = snowView;

    }else if ([self.title isEqualToString:@"矩阵变换"]){
    
        XZMatrixTransformView *matrixTransformView = [[XZMatrixTransformView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        matrixTransformView.backgroundColor = [UIColor whiteColor];
        self.view = matrixTransformView;
    }else if ([self.title isEqualToString:@"叠加模式"]){
    
        XZBlendModeView *blendView = [[XZBlendModeView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        blendView.backgroundColor = [UIColor whiteColor];
        self.view = blendView;
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
