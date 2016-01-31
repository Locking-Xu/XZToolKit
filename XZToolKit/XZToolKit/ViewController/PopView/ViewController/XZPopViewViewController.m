//
//  XZPopViewViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/31.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZPopViewViewController.h"
#import "XZPopView.h"

@interface XZPopViewViewController ()<XZPopViewDelegate>{
    
    XZPopView *_popView;
}

@end

@implementation XZPopViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2 - 50, UISCREEN_HEIGHT/2 -50, 100, 100)];
    
    button.backgroundColor = [UIColor redColor];
    
    [button addTarget:self action:@selector(button_Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"显示" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    _popView = [[XZPopView alloc] initWithRelyView:button height:100 leftWidth:30 rightWidth:50 direction:Top superView:self.view];
    _popView.delegate = self;
    _popView.contentViewColor = RGBA(171, 171, 171, 0.6);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)button_Pressed:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender.selected) {
    
        [sender setTitle:@"隐藏" forState:UIControlStateNormal];
        
        [_popView show];
    }else{
    
        [sender setTitle:@"隐藏" forState:UIControlStateNormal];
        
        [_popView hide];
    }
}

#pragma mark - XZPopView_Delegate
- (UIView *)xzPopViewContentView{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 100)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 40, 30)];
    label.text = @"徐章";
    
    [view addSubview:label];
    
    return view;
}

@end
