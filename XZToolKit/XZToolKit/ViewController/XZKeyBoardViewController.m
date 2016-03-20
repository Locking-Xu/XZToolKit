//
//  XZKeyBoardViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/16.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZKeyBoardViewController.h"
#import "XZInputBarView.h"
#import "UINavigationController+Common.h"

@interface XZKeyBoardViewController ()
@property (nonatomic, strong) XZInputBarView *inputBar;
@end

@implementation XZKeyBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.inputBar = [[XZInputBarView alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGHT - 44.0f - 64.0f, UISCREEN_WIDTH, 44.0f)];
    [self.view addSubview:self.inputBar];
    
    [self.navigationController addSystemRightButton:UIBarButtonSystemItemDone delegate:self action:@selector(downBtn_Pressed)];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton_Actions
- (void)downBtn_Pressed{

    [(UITextView *)self.inputBar.textView resignFirstResponder];
}

@end
