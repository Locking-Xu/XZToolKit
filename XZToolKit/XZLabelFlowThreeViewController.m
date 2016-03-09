//
//  XZLabelFlowThreeViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/9.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLabelFlowThreeViewController.h"
#import "XZLabelFlowThreeView.h"
#import "XZLabelFlowThreeConfig.h"

@interface XZLabelFlowThreeViewController ()<XZLabelFlowThreeViewDelegate>

@end

@implementation XZLabelFlowThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //单行
    XZLabelFlowThreeConfig *config = [[XZLabelFlowThreeConfig alloc] init];
    config.titleArray = @[@"徐fd章",@"杨fd权",@"胡远鲍",@"顾fdsf强",@"夏文fds强",@"杨权",@"胡远鲍",@"顾强",@"夏fds文强",@"杨权",@"胡fds远鲍",@"顾强",@"夏文强",@"徐章",@"杨权",@"胡远鲍ddfsfsdf",@"顾d强",@"夏文fdsd强",@"杨fds权",@"胡远鲍",@"顾dfs强",@"夏文fs强",@"杨权fdd",@"胡远鲍",@"顾强",@"夏文强"];
    XZLabelFlowThreeView *view = [[XZLabelFlowThreeView alloc] initWithFrame:CGRectMake(20, 20, 250, 30) config:config];
    view.labelFlowThreeDelegate = self;
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    //多行
    config.lineType = MultipleLine;
    XZLabelFlowThreeView *view2 = [[XZLabelFlowThreeView alloc] initWithFrame:CGRectMake(20, 60, 250, 100) config:config];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - XZLabelFlowThree_Delegate
- (void)clickTagAtIndex:(NSInteger)index title:(NSString *)title{
    
    XZIntLog(index);
    XZObjectLog(title);
}
@end
